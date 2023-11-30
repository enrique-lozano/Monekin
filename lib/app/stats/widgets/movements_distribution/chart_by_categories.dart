import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/category_stats_modal.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class TrDistributionChartItem<T> {
  T category;
  List<MoneyTransaction> transactions;
  double value;

  TrDistributionChartItem({
    required this.category,
    required this.transactions,
    required this.value,
  });
}

class ChartByCategories extends StatefulWidget {
  const ChartByCategories(
      {super.key,
      required this.startDate,
      required this.endDate,
      this.showList = false,
      this.initialSelectedType = TransactionType.expense,
      this.filters = const TransactionFilters()});

  final DateTime? startDate;
  final DateTime? endDate;

  final bool showList;

  final TransactionType initialSelectedType;

  final TransactionFilters filters;

  @override
  State<ChartByCategories> createState() => _ChartByCategoriesState();
}

class _ChartByCategoriesState extends State<ChartByCategories> {
  int touchedIndex = -1;
  late TransactionType transactionsType;

  TransactionFilters _getTransactionFilters() {
    return widget.filters.copyWith(
      status:
          TransactionStatus.getStatusThatCountsForStats(widget.filters.status),
      transactionTypes: [
        if (transactionsType == TransactionType.expense)
          TransactionType.expense,
        if (transactionsType == TransactionType.income) TransactionType.income
      ],
      minDate: widget.startDate,
      maxDate: widget.endDate,
    );
  }

  Future<List<TrDistributionChartItem<Category>>> getEvolutionData(
    BuildContext context,
  ) async {
    final data = <TrDistributionChartItem<Category>>[];

    final transactionService = TransactionService.instance;

    final transactions = await transactionService
        .getTransactions(filters: _getTransactionFilters())
        .first;

    for (final transaction in transactions) {
      final trValue = transaction.currentValueInPreferredCurrency.abs();

      final categoryToEdit = data.firstWhereOrNull((cat) =>
          cat.category.id == transaction.category?.id ||
          cat.category.id == transaction.category?.parentCategoryID);

      if (categoryToEdit != null) {
        categoryToEdit.value += trValue;
        categoryToEdit.transactions.add(transaction);
      } else {
        data.add(
          TrDistributionChartItem(
              category: transaction.category!.parentCategoryID == null
                  ? Category.fromDB(transaction.category!, null)
                  : (await CategoryService.instance
                      .getCategoryById(transaction.category!.parentCategoryID!)
                      .first)!,
              transactions: [transaction],
              value: trValue),
        );
      }
    }

    data.sort((a, b) => b.value.compareTo(a.value));
    return data;
  }

  /// Returns a value between 0 and 100
  double getElementPercentageInTotal(
      double elementValue, List<TrDistributionChartItem> items) {
    return (elementValue / items.map((e) => e.value).sum);
  }

  List<TrDistributionChartItem> deleteUnimportantItems(
      List<TrDistributionChartItem> data) {
    const limit = 0.05;

    final unimportantItems = data.where(
        (element) => getElementPercentageInTotal(element.value, data) < limit);

    if (unimportantItems.length <= 1) return data;

    final toReturn = data
        .where((element) =>
            getElementPercentageInTotal(element.value, data) >= limit)
        .toList();

    final toAdd = TrDistributionChartItem(
        value: 0,
        transactions: [],
        category: Category(
            id: 'Other',
            name: 'Other',
            iconId: 'iconId',
            type: CategoryType.B,
            color: 'DEDEDE'));

    for (final item in unimportantItems) {
      toAdd.value += item.value;
      toAdd.transactions = [...toAdd.transactions, ...item.transactions];
    }

    toReturn.add(toAdd);

    return toReturn;
  }

  List<PieChartSectionData> showingSections(
      List<TrDistributionChartItem> data) {
    if (data.isEmpty) {
      return [
        PieChartSectionData(
          color: Colors.grey.withOpacity(0.175),
          value: 100,
          radius: 50,
          showTitle: false,
        )
      ];
    }

    return data.mapIndexed((index, element) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      final percentage = getElementPercentageInTotal(element.value, data);

      return PieChartSectionData(
        color: ColorHex.get(element.category.color),
        value: percentage,
        title: NumberFormat.percentPattern().format(percentage),
        radius: radius,
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  Widget indicator({
    required Color color,
    required String text,
    required bool isSquare,
    double size = 12,
    Color? textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    transactionsType = widget.initialSelectedType;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder(
      future: getEvolutionData(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        final filteredDataItems = deleteUnimportantItems(snapshot.data!);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: TransactionType.expense,
                    label: Text(t.transaction.types.expense(n: 1)),
                  ),
                  ButtonSegment(
                    value: TransactionType.income,
                    label: Text(t.transaction.types.income(n: 1)),
                  ),
                ],
                showSelectedIcon: false,
                selected: {transactionsType},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    transactionsType = newSelection.first;
                  });
                },
              ),
            ),
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  PieChart(
                    swapAnimationCurve: Curves.easeOut,
                    swapAnimationDuration: const Duration(milliseconds: 450),
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(filteredDataItems),
                    ),
                  ),
                  if (snapshot.data!.isEmpty)
                    Positioned.fill(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            t.general.insufficient_data,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    ),
                ],
              ),
            ),

            /* ----------------------------- */
            /* ------- CHART LEGEND -------- */
            /* ----------------------------- */

            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
              child: Wrap(
                spacing: 10, // gap between adjacent cards
                runSpacing: 2, // gap between lines
                alignment: WrapAlignment.center,
                children: filteredDataItems
                    .map((e) => indicator(
                        color: ColorHex.get(e.category.color),
                        text: e.category.name,
                        isSquare: false))
                    .toList(),
              ),
            ),

            /* ----------------------------- */
            /* ------ Info in a list ------- */
            /* ----------------------------- */

            if (widget.showList)
              ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final dataCategory = snapshot.data![index];

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dataCategory.category.name),
                        CurrencyDisplayer(amountToConvert: dataCategory.value)
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${dataCategory.transactions.length} ${t.transaction.display(n: dataCategory.transactions.length)}'
                              .toLowerCase(),
                        ),
                        Text(
                            NumberFormat.decimalPercentPattern(decimalDigits: 2)
                                .format(getElementPercentageInTotal(
                                    dataCategory.value, snapshot.data!)))
                      ],
                    ),
                    leading: dataCategory.category.icon.displayFilled(
                        size: 25,
                        color: ColorHex.get(dataCategory.category.color)),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return CategoryStatsModal(
                              categoryData: dataCategory,
                              filters: _getTransactionFilters(),
                            );
                          });
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
