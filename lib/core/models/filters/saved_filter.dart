import 'package:monekin/core/database/app_db.dart';

class SavedFilter extends SavedFilterInDB {
  final TransactionFilterSetInDB filterSet;

  SavedFilter({
    required super.id,
    required super.name,
    required this.filterSet,
    required super.displayOrder,
  }) : super(filterID: filterSet.id);
}
