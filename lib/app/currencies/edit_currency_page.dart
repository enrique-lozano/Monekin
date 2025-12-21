import 'package:flutter/material.dart';
import 'package:monekin/app/currencies/widgets/currency_edit_fields.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/exit_without_save_warn_dialog.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class EditCurrencyPage extends StatefulWidget {
  const EditCurrencyPage({super.key, required this.currency});

  final Currency currency;

  @override
  State<EditCurrencyPage> createState() => _EditCurrencyPageState();
}

class _EditCurrencyPageState extends State<EditCurrencyPage> {
  final GlobalKey<CurrencyEditFieldsState> _formKey = GlobalKey();
  bool _hasChanged = false;

  void submitChanges() {
    if (!_hasChanged) return;

    final t = Translations.of(context);
    final formState = _formKey.currentState!;

    final updatedCurrency = widget.currency.copyWith(
      code: formState.code,
      name: formState.displayName,
      symbol: formState.symbol,
      decimalPlaces: formState.decimalPlaces,
      type: formState.currencyType.dbValue,
    );

    CurrencyService.instance
        .updateCurrency(widget.currency.code, updatedCurrency)
        .then((value) {
          MonekinSnackbar.success(
            SnackbarParams(t.currencies.currency_form.edit_success),
          );
          RouteUtils.popRoute(updatedCurrency);
        })
        .catchError((err) {
          MonekinSnackbar.error(SnackbarParams.fromError(err));
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PopScope(
      canPop: !_hasChanged,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (_hasChanged) {
          showExitWithoutSaveWarnDialog(context);
        }
      },
      child: PageFramework(
        title: t.currencies.currency_form.edit,
        persistentFooterButtons: [
          PersistentFooterButton(
            child: FilledButton.icon(
              onPressed: !_hasChanged ? null : submitChanges,
              icon: const Icon(Icons.save),
              label: Text(t.ui_actions.save_changes),
            ),
          ),
        ],
        body: CurrencyEditFields(
          key: _formKey,
          currency: widget.currency,
          onChanged: () {
            final changed = _formKey.currentState?.hasChanged ?? false;
            if (changed != _hasChanged) {
              setState(() {
                _hasChanged = changed;
              });
            }
          },
        ),
      ),
    );
  }
}
