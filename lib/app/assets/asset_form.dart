import 'package:drift/drift.dart' show BaseAggregate;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/widgets/balance_currency_form_field.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class AssetFormPage extends StatefulWidget {
  const AssetFormPage({super.key, this.asset});

  /// Asset UUID to edit (if any)
  final Asset? asset;

  @override
  State<AssetFormPage> createState() => _AssetFormPageState();
}

class _AssetFormPageState extends State<AssetFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _initialValueController = TextEditingController(
    text: '0',
  );

  Currency? _currency;
  DateTime _creationDate = DateTime.now();
  AssetType _assetType = AssetType.other;
  Account? _linkedAccount;

  late final Asset? _assetToEdit;

  Future<void> submitForm() async {
    if (_currency == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.form.select_currency),
      );
      return;
    }

    final investmentService = InvestmentService.instance;

    final initialValue = double.tryParse(_initialValueController.text) ?? 0;

    final AssetInDB assetToSubmit = AssetInDB(
      id: _assetToEdit?.id ?? generateUUID(),
      name: _nameController.text,
      initialValue: initialValue,
      currencyId: _currency!.code,
      creationDate: _creationDate,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      assetType: _assetType,
      linkedAccountID: _linkedAccount?.id,
    );

    // Check for assets with same names before continue:
    if (_assetToEdit == null || _assetToEdit.name != assetToSubmit.name) {
      final db = AppDB.instance;
      final query = db.select(db.assets)
        ..addColumns([db.assets.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        MonekinSnackbar.error(
          SnackbarParams.fromError(
            t.assets.form.already_exists,
            duration: const Duration(seconds: 6),
          ),
        );

        return;
      }
    }

    if (_assetToEdit != null) {
      await investmentService.updateAsset(assetToSubmit);
      //MonekinSnackbar.success(SnackbarParams(t.assets.form.edit_success));
    } else {
      await investmentService.insertAsset(assetToSubmit);
      //  MonekinSnackbar.success(SnackbarParams(t.assets.form.create_success));
    }

    RouteUtils.popRoute();
  }

  @override
  void initState() {
    super.initState();

    _assetToEdit = widget.asset;

    if (_assetToEdit != null) {
      _fillForm();
    }

    CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
      value,
    ) {
      setState(() {
        if (widget.asset == null) {
          _currency = value;
        }
      });
    });
  }

  void _fillForm() {
    if (_assetToEdit == null) return;

    _nameController.text = _assetToEdit.name;
    _descriptionController.text = _assetToEdit.description ?? '';
    _initialValueController.text = _assetToEdit.initialValue.toString();
    _creationDate = _assetToEdit.creationDate;
    _assetType = _assetToEdit.assetType;
    final linkedId = _assetToEdit.linkedAccountID;
    if (linkedId != null) {
      AccountService.instance.getAccountById(linkedId).first.then((acc) {
        if (mounted) setState(() => _linkedAccount = acc);
      });
    }

    CurrencyService.instance
        .getCurrencyByCode(_assetToEdit.currency.code)
        .first
        .then((value) {
          setState(() {
            _currency = value;
          });
        });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _initialValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final pageTitle = widget.asset != null
        ? t.assets.form.edit
        : t.assets.form.create;
    final footerButtons = [
      PersistentFooterButton(
        child: FilledButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              submitForm();
            }
          },
          icon: const Icon(Icons.save),
          label: Text(pageTitle),
        ),
      ),
    ];

    return PageFramework(
      title: pageTitle,
      persistentFooterButtons: footerButtons,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '${t.assets.form.name} *',
                ),
                validator: (value) => fieldValidator(value, isRequired: true),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Initial value field
              AmountAndCurrencyFormField(
                amountController: _initialValueController,
                currency: _currency,
                amountLabel: t.assets.form.initial_value,
                enabled: true,
                onCurrencySelected: (newCurrency) {
                  setState(() {
                    _currency = newCurrency;
                  });
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<AssetType>(
                value: _assetType,
                decoration: InputDecoration(
                  labelText: t.assets.form.asset_type,
                ),
                items: AssetType.values
                    .map(
                      (at) => DropdownMenuItem(
                        value: at,
                        child: Text(at.displayName(context)),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _assetType = v);
                },
              ),
              const SizedBox(height: 16),

              StreamBuilder<List<Account>>(
                stream: AccountService.instance.getAccounts(),
                builder: (context, snap) {
                  final accounts = snap.data ?? [];
                  return DropdownButtonFormField<Account?>(
                    value: _linkedAccount,
                    decoration: InputDecoration(
                      labelText: t.assets.form.linked_account,
                    ),
                    items: [
                      const DropdownMenuItem<Account?>(
                        value: null,
                        child: Text('—'),
                      ),
                      ...accounts.map(
                        (a) => DropdownMenuItem(
                          value: a,
                          child: Text(a.name),
                        ),
                      ),
                    ],
                    onChanged: (a) => setState(() => _linkedAccount = a),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: t.assets.form.description,
                ),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),

              // Creation date field
              DateTimeFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.event),
                  labelText: '${t.assets.form.creation_date} *',
                ),
                initialDate: _creationDate,
                dateFormat: DateFormat.yMMMd().add_jm(),
                validator: (e) =>
                    e == null ? t.general.validations.required : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    _creationDate = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
