import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/utils/color_utils.dart';

class AmountSelector extends StatefulWidget {
  const AmountSelector({
    super.key,
    required this.amountToConvert,
    this.currency,
    this.onSubmit,
    required this.title,
  });

  final String title;

  final double amountToConvert;
  final CurrencyInDB? currency;

  final void Function(double amount)? onSubmit;

  @override
  State<AmountSelector> createState() => _AmountSelectorState();
}

class _AmountSelectorState extends State<AmountSelector> {
  late String selectedAmount;
  double get valueToNumber => double.tryParse(selectedAmount) ?? 0;

  FocusNode _focusNode = FocusNode();
  late FocusAttachment _focusAttachment;

  /// String that identifies the remove character button
  final removeID = '⌫';

  @override
  void initState() {
    super.initState();

    if (widget.amountToConvert == 0) {
      selectedAmount = '0';
    } else {
      selectedAmount =
          removeTrailingZeroes(widget.amountToConvert.toStringAsFixed(2));
    }

    _focusAttachment = _focusNode.attach(context, onKeyEvent: (node, event) {
      bool keyIsPressed = event.runtimeType == KeyDownEvent ||
          event.runtimeType == KeyRepeatEvent;

      if (!keyIsPressed) {
        return KeyEventResult.handled;
      }

      if ((event.logicalKey == LogicalKeyboardKey.browserBack ||
          event.logicalKey == LogicalKeyboardKey.goBack ||
          event.logicalKey == LogicalKeyboardKey.escape)) {
        Navigator.pop(context);
      }

      for (final (index, element) in [
        LogicalKeyboardKey.digit0,
        LogicalKeyboardKey.digit1,
        LogicalKeyboardKey.digit2,
        LogicalKeyboardKey.digit3,
        LogicalKeyboardKey.digit4,
        LogicalKeyboardKey.digit5,
        LogicalKeyboardKey.digit6,
        LogicalKeyboardKey.digit7,
        LogicalKeyboardKey.digit8,
        LogicalKeyboardKey.digit9,
      ].indexed) {
        if (event.logicalKey == element) {
          addToAmount(index.toStringAsFixed(0));
          break;
        }
      }

      for (final (index, element) in [
        LogicalKeyboardKey.numpad0,
        LogicalKeyboardKey.numpad1,
        LogicalKeyboardKey.numpad2,
        LogicalKeyboardKey.numpad3,
        LogicalKeyboardKey.numpad4,
        LogicalKeyboardKey.numpad5,
        LogicalKeyboardKey.numpad6,
        LogicalKeyboardKey.numpad7,
        LogicalKeyboardKey.numpad8,
        LogicalKeyboardKey.numpad9,
      ].indexed) {
        if (event.logicalKey == element) {
          addToAmount(index.toStringAsFixed(0));
          break;
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.period) {
        addToAmount('.');
      } else if (event.logicalKey == LogicalKeyboardKey.numpadDecimal) {
        addToAmount('.');
      } else if (event.logicalKey == LogicalKeyboardKey.comma) {
        addToAmount('.');
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        onButtonPress(removeID);
      } else if (event.logicalKey == LogicalKeyboardKey.delete) {
        onButtonPress(removeID);
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        submitAmount();
      }

      return KeyEventResult.handled;
    });

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String removeTrailingZeroes(String input) {
    if (!input.contains('.')) {
      return input;
    }
    int index = input.length - 1;
    while (input[index] == '0') {
      index--;
    }
    if (input[index] == '.') {
      index--;
    }
    return input.substring(0, index + 1);
  }

  void addToAmount(String text) {
    final decimalPlaces = selectedAmount.split('.').elementAtOrNull(1);

    if (decimalPlaces != null && decimalPlaces.length >= 2) {
      return;
    }

    setState(() {
      selectedAmount += text;
    });
  }

  submitAmount() {
    HapticFeedback.lightImpact();

    if (widget.onSubmit != null) {
      widget.onSubmit!(valueToNumber);
    }
  }

  void onButtonPress(String text) {
    if (text == 'DONE') {
      submitAmount();
      return;
    }

    HapticFeedback.lightImpact();

    if (text == 'AC') {
      setState(() {
        selectedAmount = '0';
      });
    } else if (text == removeID) {
      if (valueToNumber == 0) return;

      setState(() {
        selectedAmount = selectedAmount.substring(0, selectedAmount.length - 1);
      });
    } else {
      addToAmount(text);
    }
  }

  Widget buildCalculatorButton(
    BuildContext context, {
    required String text,
    int flex = 1,
    Color? bgColor,
    Color? textColor,
  }) {
    textColor ??= AppColors.of(context).onBackground;
    bgColor ??= AppColors.of(context).background;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? bgColor.darken(0.025)
                : bgColor.darken(0.15),
            shadowColor: bgColor.darken(0.15),
            surfaceTintColor: bgColor.darken(0.15),
            foregroundColor: textColor,
            disabledForegroundColor: textColor.withOpacity(0.3),
            disabledBackgroundColor: bgColor.withOpacity(0.3),
            elevation: 0,
          ),
          onPressed: text == 'DONE' && (valueToNumber == 0)
              ? null
              : () => onButtonPress(text),
          child: text == removeID || text == 'DONE'
              ? Icon(text == removeID
                  ? Icons.backspace_rounded
                  : Icons.check_rounded)
              : Text(
                  text,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(builder: (context) {
                        const bigSizeStyle = TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        );

                        return CurrencyDisplayer(
                          amountToConvert: valueToNumber,
                          currency: widget.currency,
                          decimalsStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 22,
                              color: selectedAmount.contains('.')
                                  ? null
                                  : AppColors.of(context)
                                      .onBackground
                                      .withOpacity(0.3)),
                          integerStyle: bigSizeStyle,
                          currencyStyle: bigSizeStyle,
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Flexible(
              child: Container(
                  height: 250,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildCalculatorButton(context, text: '1'),
                            buildCalculatorButton(context, text: '4'),
                            buildCalculatorButton(context, text: '7'),
                            buildCalculatorButton(context, text: '.'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildCalculatorButton(context, text: '2'),
                            buildCalculatorButton(context, text: '5'),
                            buildCalculatorButton(context, text: '8'),
                            buildCalculatorButton(context, text: '0'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildCalculatorButton(context, text: '3'),
                            buildCalculatorButton(context, text: '6'),
                            buildCalculatorButton(context, text: '9'),
                            buildCalculatorButton(context, text: removeID),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildCalculatorButton(context, text: 'AC'),
                            buildCalculatorButton(context,
                                bgColor: AppColors.of(context).primary,
                                text: 'DONE',
                                textColor: Colors.white,
                                flex: 3),
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ]),
    );
  }
}
