import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/taxonomy/taxonomy_service.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';

void main() {
  late AppDB db;
  late TaxonomyService service;

  setUp(() async {
    db = AppDB.forTesting(NativeDatabase.memory());
    service = TaxonomyService.forTesting(db);

    // Seed a minimal set of taxonomies/categories by hand (the JSON seeder
    // needs the asset bundle, which isn't available in a plain unit test).
    await db
        .into(db.taxonomies)
        .insert(
          TaxonomyInDB(
            id: 'asset_classes',
            name: 'Asset Classes',
            color: '#879a39',
            isSystem: true,
            isSingleSelect: false,
            displayOrder: 10,
          ),
        );
    await db
        .into(db.taxonomies)
        .insert(
          TaxonomyInDB(
            id: 'risk',
            name: 'Risk',
            color: '#d14d41',
            isSystem: true,
            isSingleSelect: true,
            displayOrder: 20,
          ),
        );

    for (final c in const [
      ('ac_equity', 'Equity'),
      ('ac_cash', 'Cash'),
    ]) {
      await db
          .into(db.taxonomyCategories)
          .insert(
            TaxonomyCategoryInDB(
              id: c.$1,
              taxonomyID: 'asset_classes',
              name: c.$2,
              color: '#4385be',
              displayOrder: 10,
            ),
          );
    }
    await db
        .into(db.taxonomyCategories)
        .insert(
          TaxonomyCategoryInDB(
            id: 'risk_low',
            taxonomyID: 'risk',
            name: 'Low',
            color: '#879a39',
            displayOrder: 10,
          ),
        );

    await db
        .into(db.securities)
        .insert(
          SecurityInDB(
            id: 'sec-1',
            name: 'Test Security',
            type: SecurityType.stock,
            currencyId: 'USD',
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('stores weighted multi-select assignments', () async {
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [
        (categoryId: 'ac_equity', weight: 6000),
        (categoryId: 'ac_cash', weight: 4000),
      ],
    );

    final res = await service.getAssignmentsForSecurity('sec-1').first;

    expect(res.length, 2);
    expect(res.fold<int>(0, (sum, a) => sum + a.weight), 10000);
  });

  test('replaceAssignments replaces the previous assignments', () async {
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [(categoryId: 'ac_equity', weight: 10000)],
    );
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [(categoryId: 'ac_cash', weight: 10000)],
    );

    final res = await service.getAssignmentsForSecurity('sec-1').first;

    expect(res.length, 1);
    expect(res.single.categoryID, 'ac_cash');
  });

  test('zero-weight rows are dropped', () async {
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [
        (categoryId: 'ac_equity', weight: 0),
        (categoryId: 'ac_cash', weight: 10000),
      ],
    );

    final res = await service.getAssignmentsForSecurity('sec-1').first;

    expect(res.length, 1);
    expect(res.single.categoryID, 'ac_cash');
  });

  test('getSecurityClassification joins category and taxonomy', () async {
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [(categoryId: 'ac_equity', weight: 10000)],
    );

    final res = await service.getSecurityClassification('sec-1').first;

    expect(res.single.category.name, 'Equity');
    expect(res.single.taxonomy.id, 'asset_classes');
  });

  test('getAssignmentsForTaxonomy scopes to a single taxonomy', () async {
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'asset_classes',
      assignments: [(categoryId: 'ac_equity', weight: 10000)],
    );
    await service.replaceAssignments(
      securityId: 'sec-1',
      taxonomyId: 'risk',
      assignments: [(categoryId: 'risk_low', weight: 10000)],
    );

    final assetClasses = await service
        .getAssignmentsForTaxonomy('asset_classes')
        .first;
    final risk = await service.getAssignmentsForTaxonomy('risk').first;

    expect(assetClasses.length, 1);
    expect(assetClasses.single.categoryID, 'ac_equity');
    expect(risk.length, 1);
    expect(risk.single.categoryID, 'risk_low');
  });
}
