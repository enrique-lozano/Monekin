import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart' show rootBundle;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A single category assignment for a security: which category and with which
/// weight (in basis points, `0..10000` where `10000` = 100%).
typedef CategoryWeight = ({String categoryId, int weight});

/// An assignment joined with its category and taxonomy, ready to display.
typedef SecurityClassification = ({
  SecurityTaxonomyAssignmentInDB assignment,
  TaxonomyCategoryInDB category,
  TaxonomyInDB taxonomy,
});

/// CRUD + seeding for the security-classification system (taxonomies).
///
/// A taxonomy is a classification dimension (Asset Class, Region, Sector,
/// Risk). Each taxonomy has a tree of [taxonomyCategories]; securities are
/// linked to categories via weighted [securityTaxonomyAssignments], which
/// powers the portfolio-composition breakdowns. Built-in taxonomies ship
/// seeded but stay fully editable.
class TaxonomyService {
  final AppDB db;

  TaxonomyService._(this.db);
  static final TaxonomyService instance = TaxonomyService._(AppDB.instance);

  /// Creates a service bound to a specific (test) database.
  @visibleForTesting
  TaxonomyService.forTesting(this.db);

  // ---------------------------------------------------------------------------
  // Reads
  // ---------------------------------------------------------------------------

  Stream<List<TaxonomyInDB>> getTaxonomies() {
    return (db.select(
      db.taxonomies,
    )..orderBy([(t) => OrderingTerm.asc(t.displayOrder)])).watch();
  }

  Stream<List<TaxonomyCategoryInDB>> getCategories(String taxonomyId) {
    return (db.select(db.taxonomyCategories)
          ..where((t) => t.taxonomyID.equals(taxonomyId))
          ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
        .watch();
  }

  /// All the category assignments of a security, across every taxonomy.
  Stream<List<SecurityTaxonomyAssignmentInDB>> getAssignmentsForSecurity(
    String securityId,
  ) {
    return (db.select(
      db.securityTaxonomyAssignments,
    )..where((t) => t.securityID.equals(securityId))).watch();
  }

  /// A security's assignments joined with their category and taxonomy, for
  /// display (chips grouped by taxonomy). Ordered by taxonomy display order.
  Stream<List<SecurityClassification>> getSecurityClassification(
    String securityId,
  ) {
    final query =
        db.select(db.securityTaxonomyAssignments).join([
            innerJoin(
              db.taxonomyCategories,
              db.taxonomyCategories.id.equalsExp(
                db.securityTaxonomyAssignments.categoryID,
              ),
            ),
            innerJoin(
              db.taxonomies,
              db.taxonomies.id.equalsExp(
                db.securityTaxonomyAssignments.taxonomyID,
              ),
            ),
          ])
          ..where(db.securityTaxonomyAssignments.securityID.equals(securityId))
          ..orderBy([OrderingTerm.asc(db.taxonomies.displayOrder)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (r) => (
              assignment: r.readTable(db.securityTaxonomyAssignments),
              category: r.readTable(db.taxonomyCategories),
              taxonomy: r.readTable(db.taxonomies),
            ),
          )
          .toList(),
    );
  }

  /// Every assignment recorded for a taxonomy (across all securities). Used by
  /// the portfolio-composition breakdown to split each holding's value across
  /// its categories.
  Stream<List<SecurityTaxonomyAssignmentInDB>> getAssignmentsForTaxonomy(
    String taxonomyId,
  ) {
    return (db.select(
      db.securityTaxonomyAssignments,
    )..where((t) => t.taxonomyID.equals(taxonomyId))).watch();
  }

  // ---------------------------------------------------------------------------
  // Writes
  // ---------------------------------------------------------------------------

  /// Replaces (delete + insert) all of a security's assignments for a single
  /// taxonomy in one transaction, mirroring the editor's "save all" semantics.
  Future<void> replaceAssignments({
    required String securityId,
    required String taxonomyId,
    required List<CategoryWeight> assignments,
  }) async {
    await db.transaction(() async {
      await (db.delete(db.securityTaxonomyAssignments)..where(
            (t) =>
                t.securityID.equals(securityId) &
                t.taxonomyID.equals(taxonomyId),
          ))
          .go();

      for (final a in assignments) {
        if (a.weight <= 0) continue;

        await db
            .into(db.securityTaxonomyAssignments)
            .insert(
              SecurityTaxonomyAssignmentInDB(
                id: generateUUID(),
                securityID: securityId,
                taxonomyID: taxonomyId,
                categoryID: a.categoryId,
                weight: a.weight.clamp(0, 10000),
              ),
            );
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Seeding
  // ---------------------------------------------------------------------------

  /// Seeds the built-in taxonomies when none exist yet. Runs on every app
  /// open, so it covers both fresh installs (empty schema) and existing
  /// databases that just gained the tables via a migration. It is a cheap
  /// `COUNT` when the tables are already populated.
  Future<void> ensureSeeded() async {
    final count =
        await (db.selectOnly(db.taxonomies)
              ..addColumns([db.taxonomies.id.count()]))
            .map((row) => row.read(db.taxonomies.id.count()) ?? 0)
            .getSingle();

    if (count > 0) return;

    await initializeTaxonomies();
  }

  /// Reads `assets/sql/initial_taxonomies.json` and seeds the taxonomies and
  /// their (possibly nested) categories, picking names for the device language
  /// and falling back to English.
  Future<void> initializeTaxonomies() async {
    final raw = await rootBundle.loadString(
      'assets/sql/initial_taxonomies.json',
    );
    final List<dynamic> json = jsonDecode(raw) as List<dynamic>;

    String lang = AppLocaleUtils.findDeviceLocale().languageCode;
    if (!AppLocaleUtils.supportedLocalesRaw.any((l) => l == lang)) {
      lang = 'en';
    }

    String pickName(Map<String, dynamic> names) =>
        (names[lang] ?? names['en']) as String;

    await db.transaction(() async {
      for (final (taxIndex, dynamic taxonomy) in json.indexed) {
        final tax = taxonomy as Map<String, dynamic>;

        await db
            .into(db.taxonomies)
            .insert(
              TaxonomyInDB(
                id: tax['id'] as String,
                name: pickName(tax['names'] as Map<String, dynamic>),
                color: (tax['color'] as String?) ?? '#8abceb',
                isSystem: true,
                isSingleSelect: tax['isSingleSelect'] == true,
                displayOrder: (taxIndex + 1) * 10,
              ),
            );

        final categories =
            (tax['categories'] as List<dynamic>?) ?? const <dynamic>[];

        for (final (catIndex, dynamic category) in categories.indexed) {
          await _insertCategory(
            taxonomyId: tax['id'] as String,
            category: category as Map<String, dynamic>,
            parentId: null,
            order: catIndex + 1,
            pickName: pickName,
          );
        }
      }
    });
  }

  Future<void> _insertCategory({
    required String taxonomyId,
    required Map<String, dynamic> category,
    required String? parentId,
    required int order,
    required String Function(Map<String, dynamic>) pickName,
  }) async {
    await db
        .into(db.taxonomyCategories)
        .insert(
          TaxonomyCategoryInDB(
            id: category['id'] as String,
            taxonomyID: taxonomyId,
            parentID: parentId,
            name: pickName(category['names'] as Map<String, dynamic>),
            color: (category['color'] as String?) ?? '#808080',
            displayOrder: order * 10,
          ),
        );

    final children =
        (category['children'] as List<dynamic>?) ?? const <dynamic>[];

    for (final (childIndex, dynamic child) in children.indexed) {
      await _insertCategory(
        taxonomyId: taxonomyId,
        category: child as Map<String, dynamic>,
        parentId: category['id'] as String,
        order: childIndex + 1,
        pickName: pickName,
      );
    }
  }
}
