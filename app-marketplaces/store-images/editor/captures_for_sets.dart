// Prints the comma-separated `<app locale>-<currency>` captures needed by the
// given store image sets (all of them if none), as defined in
// `app-marketplaces/store-images/config.json`. Used by
// `scripts/generate_screenshots.bat`.
//
// Run from the repository root:
//   dart app-marketplaces/store-images/editor/captures_for_sets.dart en-US pt-BR
import 'dart:convert';
import 'dart:io';

void main(List<String> setIds) {
  final config =
      jsonDecode(
            File(
              'app-marketplaces/store-images/config.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final sets = (config['sets'] as List).cast<Map<String, dynamic>>();

  final selected = setIds.isEmpty
      ? sets
      : [
          for (final id in setIds)
            sets.firstWhere(
              (s) => s['id'] == id,
              orElse: () {
                stderr.writeln(
                  'Unknown set: $id. Available: '
                  '${sets.map((s) => s['id']).join(', ')}',
                );
                exit(1);
              },
            ),
        ];

  stdout.write(
    {for (final s in selected) '${s['app']}-${s['currency']}'}.join(','),
  );
}
