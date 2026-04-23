import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class BalanceCorrectionModal extends StatefulWidget {
  const BalanceCorrectionModal({super.key, required this.account});

  final Account account;

  @override
  State<BalanceCorrectionModal> createState() => _BalanceCorrectionModalState();
}

class _BalanceCorrectionModalState extends State<BalanceCorrectionModal> {
  late TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _balanceController = TextEditingController();
    _loadCurrentBalance();
  }

  Future<void> _loadCurrentBalance() async {
    final currentBalance = await AccountService.instance
        .getAccountMoney(account: widget.account)
        .first;
    _balanceController.text = currentBalance.toStringAsFixed(
      widget.account.currency.decimalPlaces,
    );
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _saveBalance() async {
    final t = Translations.of(context);
    final newBalance = double.tryParse(_balanceController.text);

    if (newBalance == null) {
      MonekinSnackbar.error(SnackbarParams('Invalid number'));
      return;
    }

    final currentBalance = await AccountService.instance
        .getAccountMoney(account: widget.account)
        .first;

    final newIniValue = widget.account.iniValue + (newBalance - currentBalance);

    final updatedAccount = widget.account.copyWith(iniValue: newIniValue);

    await AccountService.instance.updateAccount(updatedAccount);

    if (mounted) {
      Navigator.of(context).pop();
      MonekinSnackbar.success(SnackbarParams(t.account.close.success));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.account.correct_balance,
      subtitle: t.account.form.correct_balance_description,
      footer: BottomSheetFooter(
        submitText: t.ui_actions.save,
        onSaved: _saveBalance,
      ),
      bodyPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      body: TextFormField(
        controller: _balanceController,
        decoration: InputDecoration(
          labelText: '${t.account.balance} *',
          hintText: '0.00',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
