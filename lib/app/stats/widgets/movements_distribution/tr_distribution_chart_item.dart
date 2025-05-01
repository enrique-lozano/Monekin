import 'package:monekin/core/models/transaction/transaction.dart';

class TrDistributionChartItem<T> {
  final T category;
  List<MoneyTransaction> transactions;
  double value;

  TrDistributionChartItem({
    required this.category,
    required this.transactions,
    required this.value,
  });
}
