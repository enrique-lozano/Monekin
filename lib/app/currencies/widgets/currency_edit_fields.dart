import 'package:flutter/material.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/currency/currency_type.enum.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/tappable-text-entry.dart';
import 'package:monekin/core/routes/route_utils.dart';

class CurrencyEditFields extends StatefulWidget {
  const CurrencyEditFields({
    super.key,
    required this.currency,
    this.onChanged,
    this.isInFormMode = true,
  });

  final Currency currency;

  final bool isInFormMode;

  final VoidCallback? onChanged;

  @override
  State<CurrencyEditFields> createState() => CurrencyEditFieldsState();
}

class CurrencyEditFieldsState extends State<CurrencyEditFields> {
  late TextEditingController _symbolController;
  late TextEditingController _codeController;
  late String _displayName;
  late CurrencyType _currencyType;
  late int _decimalPlaces;

  String get displayName => _displayName;
  String get symbol => _symbolController.text;
  String get code => _codeController.text;
  CurrencyType get currencyType => _currencyType;
  int get decimalPlaces => _decimalPlaces;

  Future<void> selectCurrencyType() async {
    final result =
        await showDynamicSelectorBottomSheet<CurrencyType, CurrencyType>(
          context,
          selectorWidget: DynamicSelectorModal(
            title: 'Select Currency Type',
            items: CurrencyType.values,
            selectedValue: _currencyType,
            displayNameGetter: (type) => type.name.toUpperCase(),
            valueGetter: (type) => type,
            trailingIconGetter: (type) => type.icon,
          ),
        );
    if (result != null) {
      setState(() {
        _currencyType = result.result!;
      });
      widget.onChanged?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    _symbolController = TextEditingController(text: widget.currency.symbol);
    _codeController = TextEditingController(text: widget.currency.code);
    _displayName = widget.currency.name;
    _currencyType = widget.currency.currencyType;
    _decimalPlaces = widget.currency.decimalPlaces;
  }

  @override
  void dispose() {
    _symbolController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  bool get hasChanged {
    return _symbolController.text != widget.currency.symbol ||
        _codeController.text != widget.currency.code ||
        _decimalPlaces != widget.currency.decimalPlaces ||
        _displayName != widget.currency.name ||
        _currencyType != widget.currency.currencyType;
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = UnderlineInputBorder(
      borderSide: TappableTextEntry.borderSide(context),
    );

    return Column(
      children: [
        ListTile(
          title: const Text('Display Name'),
          subtitle: Text(_displayName),
          trailing: const Icon(Icons.edit_rounded),
          onTap: () async {
            final newName = await showModalBottomSheet<String>(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (context) =>
                  _CurrencyNameModal(initialName: _displayName),
            );

            if (newName != null) {
              setState(() {
                _displayName = newName;
              });
              widget.onChanged?.call();
            }
          },
        ),

        ListTile(
          title: const Text('Currency Type'),
          subtitle: Text(_currencyType.name.toUpperCase()),
          enabled: !widget.isInFormMode,
          trailing: widget.isInFormMode || !widget.currency.isDefault
              ? const Icon(Icons.arrow_drop_down)
              : null,
          onTap: widget.currency.isDefault ? null : selectCurrencyType,
        ),

        if (!widget.currency.isDefault)
          ListTile(
            title: const Text('Code'),
            trailing: SizedBox(
              width: 74,
              child: TextFormField(
                controller: _codeController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                maxLength: 3,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  filled: false,
                  counterText: '',
                  hintText: 'USD',
                  hintStyle: TextStyle(color: AppColors.of(context).textHint),
                ),
                onChanged: (value) {
                  setState(() {});
                  widget.onChanged?.call();
                },
              ),
            ),
          ),

        ListTile(
          title: const Text('Symbol'),
          trailing: SizedBox(
            width: 64,
            child: TextFormField(
              controller: _symbolController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 4,
                ),
                border: inputBorder,
                enabledBorder: inputBorder,
                filled: false,
                counterText: '',
                hintText: '7',
                hintStyle: TextStyle(color: AppColors.of(context).textHint),
              ),
              onChanged: (value) {
                setState(() {});
                widget.onChanged?.call();
              },
            ),
          ),
        ),

        // Edit number of decimals places:
        ListTile(
          title: const Text('Decimal Places'),
          subtitle: Text(_decimalPlaces.toString()),
          contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 2),
          trailing: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth * 0.6,
                child: Slider.adaptive(
                  value: _decimalPlaces.toDouble(),
                  label: _decimalPlaces.toString(),
                  max: 6,
                  divisions: 6,
                  onChanged: (double value) {
                    setState(() {
                      _decimalPlaces = value.toInt();
                    });
                    widget.onChanged?.call();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CurrencyNameModal extends StatefulWidget {
  const _CurrencyNameModal({required this.initialName});

  final String initialName;

  @override
  State<_CurrencyNameModal> createState() => _CurrencyNameModalState();
}

class _CurrencyNameModalState extends State<_CurrencyNameModal> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      title: 'Edit Display Name',
      footer: BottomSheetFooter(
        onSaved: () {
          if (_controller.text.isNotEmpty) {
            RouteUtils.popRoute(_controller.text);
          }
        },
      ),
      bodyPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      body: TextFormField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Display Name'),
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            RouteUtils.popRoute(value);
          }
        },
      ),
    );
  }
}
