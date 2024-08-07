import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_value_in_destiny_modal.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/count_indicator.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/i18n/translations.g.dart';

part 'transaction_more_info.modal.g.dart';

@CopyWith()
class TransactionMoreInfo {
  final String? note;
  final List<Tag> tags;

// Specify only if we are on a transfer:
  final num? valueInDestiny;
  final Account? transferAccount;

  const TransactionMoreInfo({
    this.note,
    this.tags = const [],
    this.valueInDestiny,
    this.transferAccount,
  });
}

Future<TransactionMoreInfo?> showTransactionMoreInfoModal(
  BuildContext context, {
  required TransactionMoreInfo data,
}) {
  return showModalBottomSheet<TransactionMoreInfo>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return _TransactionMoreInfoModal(
          initialData: data,
        );
      });
}

class _TransactionMoreInfoModal extends StatefulWidget {
  const _TransactionMoreInfoModal({required this.initialData});

  final TransactionMoreInfo initialData;

  @override
  State<_TransactionMoreInfoModal> createState() =>
      _TransactionMoreInfoModalState();
}

class _TransactionMoreInfoModalState extends State<_TransactionMoreInfoModal> {
  late TransactionMoreInfo moreInfoData;

  @override
  void initState() {
    super.initState();

    moreInfoData = widget.initialData.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    var listTiles = [
      ListTile(
        leading: const Icon(Icons.location_on_outlined),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        title: const Text('Location'),
        subtitle: const Text('Coming soon!'),
        enabled: false,
        onTap: () {},
      ),
      const Divider(),
      ListTile(
        leading: Icon(Tag.icon),
        trailing: CountIndicatorWithExpandArrow(
          countToDisplay: moreInfoData.tags.length,
        ),
        title: Text(t.tags.display(n: 2)),
        subtitle: Text(
          moreInfoData.tags.isEmpty
              ? t.transaction.form.no_tags
              : moreInfoData.tags.map((t) => t.name).printFormatted(),
          style: TextStyle(
            fontStyle:
                moreInfoData.tags.isEmpty ? FontStyle.italic : FontStyle.normal,
          ),
        ),
        onTap: () {
          showTagListModal(context,
              modal: TagSelector(
                allowEmptySubmit: true,
                includeNullTag: false,
                selectedTags: moreInfoData.tags,
              )).then((value) {
            if (value != null) {
              setState(() {
                moreInfoData = moreInfoData.copyWith(
                  tags: value.nonNulls.toList(),
                );
              });
            }
          });
        },
      ),
      const Divider(),
      if (moreInfoData.valueInDestiny != null) ...[
        ListTile(
          leading: const Icon(Icons.start_rounded),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          title: Text(t.transfer.form.value_in_destiny.title),
          subtitle: CurrencyDisplayer(
            amountToConvert: moreInfoData.valueInDestiny!.toDouble(),
            currency: moreInfoData.transferAccount?.currency,
          ),
          enabled: moreInfoData.transferAccount != null,
          onTap: () {
            showTransactionValueInDestinyModal(
              context,
              initialValue: moreInfoData.valueInDestiny!,
              currency: moreInfoData.transferAccount!
                  .currency, // Can not be null due to the `enabled` property of the tile
            ).then((value) {
              if (value != null) {
                setState(() {
                  moreInfoData = moreInfoData.copyWith(valueInDestiny: value);
                });
              }
            });
          },
        ),
        const Divider(),
      ]
    ];

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.85,
      minChildSize: 0.85,
      initialChildSize: 0.85,
      builder: (context, sc) {
        return ModalContainer(
          title: t.transaction.details,
          body: Column(
            children: [
              SingleChildScrollView(
                controller: sc,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      initialValue: widget.initialData.note,
                      onChanged: (value) {
                        setState(() {
                          moreInfoData = moreInfoData.copyWith(note: value);
                        });
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: AppColors.of(context).modalBackground,
                        hoverColor: AppColors.of(context).modalBackground,
                        focusColor: AppColors.of(context).modalBackground,
                        hintText: t.transaction.form.description_info,
                      ),
                    ),
                    const Divider(),
                    ...listTiles
                  ],
                ),
              ),
            ],
          ),
          footer: BottomSheetFooter(
            onSaved: () => Navigator.pop(context, moreInfoData),
          ),
        );
      },
    );
  }
}
