import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monekin/app/layout/tabs.dart';
import 'package:monekin/app/onboarding/classes/OnboardingItem.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/styles/big_button_style.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  PageController pageController = PageController();

  introFinished() {
    AppDataService.instance
        .setItem(AppDataKey.introSeen, '1', updateGlobalState: true)
        .then(
      (value) {
        RouteUtils.pushRoute(
          context,
          TabsPage(key: tabsPageKey),
          withReplacement: true,
        );
      },
    );
  }

  _goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  _goToPrevPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final items = [
      OnboardingItem(
        header: t.intro.sl1_title,
        description: t.intro.sl1_descr,
        imageAsset: 'assets/icons/app_onboarding/first.svg',
        extraWidget: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: buildCurrencySelectorTile(context),
        ),
      ),
      OnboardingItem(
        header: t.intro.sl2_title,
        description: t.intro.sl2_descr,
        description2: t.intro.sl2_descr2,
        imageAsset: 'assets/icons/app_onboarding/security.svg',
      ),
      OnboardingItem(
        header: t.intro.last_slide_title,
        description: t.intro.last_slide_descr,
        description2: t.intro.last_slide_descr2,
        imageAsset: 'assets/icons/app_onboarding/wallet.svg',
      ),
    ];

    final isInLastPage = currentPage >= items.length - 1;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: screenWidth < 700 ? 1.0 : 700 / screenWidth,
            child: Scaffold(
                persistentFooterButtons: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedExpanded(
                        axis: Axis.horizontal,
                        expand: currentPage > 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: IconButton.outlined(
                            onPressed: _goToPrevPage,
                            icon: const Icon(Icons.arrow_back_rounded),
                            iconSize: 20,
                            style: ButtonStyle(
                              fixedSize:
                                  const WidgetStatePropertyAll(Size(42, 56)),
                              shape:
                                  WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: PersistentFooterButton(
                          child: FilledButton.icon(
                            onPressed: () {
                              if (isInLastPage) {
                                introFinished();
                              } else {
                                _goToNextPage();
                              }
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
                            iconAlignment: IconAlignment.end,
                            label: Text(isInLastPage
                                ? t.ui_actions.continue_text
                                : t.intro.next),
                            style: getBigButtonStyle(context),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                body: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 4, right: 16, left: 16),
                        child: LayoutBuilder(builder: (context, constraints) {
                          const expansionFactor = 4;
                          const spacing = 4;

                          return AnimatedSmoothIndicator(
                            activeIndex: currentPage,
                            count: items.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 12,
                              radius: 2,
                              dotColor: AppColors.of(context)
                                  .consistentPrimary
                                  .lighten(0.8),
                              activeDotColor:
                                  AppColors.of(context).consistentPrimary,
                              spacing: spacing.toDouble(),
                              dotWidth: constraints.maxWidth /
                                      (items.length + expansionFactor - 1) -
                                  spacing / items.length,
                              expansionFactor: 4,
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) {
                            final item = items.elementAt(index);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 16,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                        color: isAppInDarkBrightness(context)
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .lighten(0.8)
                                            : Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                                .lighten(0.58),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SvgPicture.asset(
                                        item.imageAsset,
                                        fit: BoxFit.contain,
                                        width: 240.0,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.header,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            //  textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(item.description),
                                          if (item.description2 != null) ...[
                                            const SizedBox(height: 6),
                                            Text(item.description2!),
                                          ],
                                          if (item.extraWidget != null)
                                            item.extraWidget!,
                                          const SizedBox(height: 64),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: items.length,
                          onPageChanged: (pageIndex) {
                            setState(() {
                              currentPage = pageIndex;
                            });
                          },
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  StreamBuilder<Currency> buildCurrencySelectorTile(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: CurrencyService.instance.getUserPreferredCurrency(),
      builder: (context, snapshot) {
        final userCurrency = snapshot.data;

        return ListTile(
          tileColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.04),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
          ),
          leading: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: userCurrency != null
                ? userCurrency.displayFlagIcon(size: 42)
                : const Skeleton(height: 42, width: 42),
          ),
          title: Text(t.intro.select_your_currency),
          subtitle: userCurrency != null
              ? Text(userCurrency.name)
              : const Skeleton(height: 12, width: 50),
          onTap: () {
            if (userCurrency == null) return;

            showCurrencySelectorModal(
              context,
              CurrencySelectorModal(
                  preselectedCurrency: userCurrency,
                  onCurrencySelected: (newCurrency) {
                    UserSettingService.instance
                        .setItem(SettingKey.preferredCurrency, newCurrency.code)
                        .then((value) => setState(() => {}));
                  }),
            );
          },
        );
      },
    );
  }
}
