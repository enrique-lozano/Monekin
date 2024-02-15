import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/stats/widgets/movements_distribution/chart_by_categories.dart';
import 'package:monekin/app/transactions/transactions.page.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class SubcategoryModalItem {
  String id;
  String name;
  SupportedIcon icon;
  double value;

  SubcategoryModalItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.value,
  });
}

class CategoryStatsModal extends StatelessWidget {
  const CategoryStatsModal({
    super.key,
    required this.categoryData,
    required this.filters,
    required this.dateRangeText,
  });

  final TrDistributionChartItem<Category> categoryData;
  final TransactionFilters filters;

  final String dateRangeText;

  Future<List<SubcategoryModalItem>> getSubcategoriesData(
      BuildContext context) async {
    final t = Translations.of(context);

    List<SubcategoryModalItem> subcategories = [];

    for (final transaction in categoryData.transactions) {
      final notBelongToAnySubcatName = t.categories.select.without_subcategory;

      final categoryToEdit = subcategories
          .firstWhereOrNull((x) => x.id == transaction.category!.id);

      final trValue = await ExchangeRateService.instance
          .calculateExchangeRateToPreferredCurrency(
              fromCurrency: transaction.account.currencyId,
              amount: transaction.value.abs())
          .first;

      if (categoryToEdit != null) {
        categoryToEdit.value += trValue;
      } else {
        subcategories.add(SubcategoryModalItem(
            id: transaction.category!.id,
            name: transaction.category!.isMainCategory
                ? notBelongToAnySubcatName
                : transaction.category!.name,
            icon: transaction.category!.icon,
            value: trValue));
      }
    }

    return subcategories.sorted((a, b) => b.value.compareTo(a.value));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconDisplayer.fromCategory(
                        context,
                        category: categoryData.category,
                        size: 34,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryData.category.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            '${categoryData.transactions.length} ${t.transaction.display(n: categoryData.transactions.length)}'
                                .toLowerCase(),
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => RouteUtils.pushRoute(
                      context,
                      TransactionsPage(
                        filters: filters.copyWith(
                          categories: [categoryData.category.id],
                          includeParentCategoriesInSearch: true,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateRangeText,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  CurrencyDisplayer(
                    amountToConvert: categoryData.value,
                    integerStyle: Theme.of(context).textTheme.titleLarge!,
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        FutureBuilder(
            future: getSubcategoriesData(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              final subcategories = snapshot.data!;

              return Column(
                children: List.generate(subcategories.length, (index) {
                  final subcategoryData = subcategories[index];

                  return ListTile(
                    leading: IconDisplayer(
                      supportedIcon: subcategoryData.icon,
                      mainColor: ColorHex.get(categoryData.category.color),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subcategoryData.name),
                        CurrencyDisplayer(
                            amountToConvert: subcategoryData.value)
                      ],
                    ),
                    subtitle: AnimatedProgressBar(
                      value: subcategoryData.value / categoryData.value,
                      color: ColorHex.get(categoryData.category.color),
                    ),
                  );
                }),
              );
            })
      ],
    );
  }
}
