import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';

/// String that identifies the remove character button
const _removeButtonID = '⌫';

class TransactionFormCalculator extends StatefulWidget {
  const TransactionFormCalculator(
      {super.key,
      required this.amountToConvert,
      this.onChange,
      this.onSubmit,
      this.showNegativeToggleButton = true});

  final double amountToConvert;

  final bool showNegativeToggleButton;

  /// If the calculator will start with a negative value
//final bool initiallyNegative;

  final void Function(double amount)? onChange;
  final void Function()? onSubmit;

  @override
  State<TransactionFormCalculator> createState() =>
      _TransactionFormCalculatorState();
}

class _TransactionFormCalculatorState extends State<TransactionFormCalculator> {
  late String selectedAmount;
  double get valueToNumber => double.tryParse(selectedAmount) ?? 0;

  late bool isNegative;

  final FocusNode _focusNode = FocusNode();
  late FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();

    if (widget.amountToConvert == 0) {
      selectedAmount = '0';
    } else {
      selectedAmount =
          removeTrailingZeroes(widget.amountToConvert.toStringAsFixed(2));
    }

    isNegative = widget.amountToConvert.isNegative;

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

      if (event.logicalKey == LogicalKeyboardKey.period ||
          event.logicalKey == LogicalKeyboardKey.numpadDecimal ||
          event.logicalKey == LogicalKeyboardKey.comma) {
        addToAmount('.');
      } else if (event.logicalKey == LogicalKeyboardKey.backspace ||
          event.logicalKey == LogicalKeyboardKey.delete) {
        onButtonPress(_removeButtonID);
      } else if (event.logicalKey == LogicalKeyboardKey.enter &&
          widget.onSubmit != null) {
        widget.onSubmit!();
      }

      return KeyEventResult.handled;
    });

    _focusNode.requestFocus();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amountToConvert != widget.amountToConvert ||
        oldWidget.amountToConvert.isNegative !=
            widget.amountToConvert.isNegative) {
      setState(() {
        isNegative = widget.amountToConvert.isNegative;
      });
    }
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

    updateSelectedAmount(selectedAmount + text);
  }

  void updateSelectedAmount(String newAmount) {
    setState(() {
      selectedAmount =
          "${isNegative ? '-' : ''}${newAmount.replaceAll('-', '')}";

      if (widget.onChange != null) {
        widget.onChange!(valueToNumber);
      }
    });
  }

  void onButtonPress(String text) {
    HapticFeedback.lightImpact();

    if (text == 'DONE') {
      if (widget.onSubmit != null) {
        widget.onSubmit!();
      }

      return;
    }

    if (text == 'AC') {
      updateSelectedAmount('0');
    } else if (text == _removeButtonID) {
      if (valueToNumber == 0) return;

      updateSelectedAmount(
          selectedAmount.substring(0, selectedAmount.length - 1));
    } else if (text == '-') {
      isNegative = !isNegative;
      updateSelectedAmount(selectedAmount);
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
    bgColor ??= Colors.transparent;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shadowColor: bgColor.darken(0.15),
            surfaceTintColor: bgColor.darken(0.15),
            foregroundColor: textColor,
            disabledForegroundColor: textColor.withOpacity(0.3),
            disabledBackgroundColor: bgColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          onPressed: text == 'DONE' && (valueToNumber == 0)
              ? null
              : () => onButtonPress(text),
          child: text == _removeButtonID || text == 'DONE'
              ? Icon(text == _removeButtonID
                  ? Icons.backspace_rounded
                  : Icons.check_rounded)
              : text == '-'
                  ? const Icon(Icons.exposure_rounded)
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

    return Row(
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
              buildCalculatorButton(context, text: _removeButtonID),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCalculatorButton(context, text: 'AC'),
              if (widget.showNegativeToggleButton)
                buildCalculatorButton(context, text: '-'),
              buildCalculatorButton(context,
                  bgColor: AppColors.of(context).primary,
                  text: 'DONE',
                  textColor: AppColors.of(context).onPrimary,
                  flex: widget.showNegativeToggleButton ? 2 : 3),
            ],
          ),
        ),
      ],
    );
  }
}
