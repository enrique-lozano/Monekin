import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/tags_filter/tags_filter_container.dart';
import 'package:monekin/i18n/translations.g.dart';

part 'transaction_more_info.modal.g.dart';

@CopyWith()
class TransactionMoreInfo {
  final String? note;
  final List<Tag> tags;

  const TransactionMoreInfo({
    this.note,
    this.tags = const [],
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
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                        title: const Text('Location'),
                        subtitle: const Text('-22.7832933, 2.8992929'),
                        onTap: () {},
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: StatefulBuilder(builder: (context, setState) {
                          return TagsFilterContainer(
                            headerLabelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w700),
                            headerSpacing: 8,
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 0,
                              children: [
                                ...List.generate(moreInfoData.tags.length,
                                    (index) {
                                  final tag = moreInfoData.tags[index];

                                  return FilterChip(
                                    label: Text(
                                      tag.name,
                                      style: TextStyle(color: tag.colorData),
                                    ),
                                    selected: true,
                                    onSelected: (value) => setState(() {
                                      moreInfoData.tags.removeWhere(
                                          (element) => element.id == tag.id);
                                    }),
                                    showCheckmark: false,
                                    selectedColor: tag.colorData.lighten(0.8),
                                    avatar: tag.displayIcon(),
                                  );
                                }),
                                ActionChip(
                                  label: Text(t.tags.add),
                                  avatar: const Icon(Icons.add),
                                  onPressed: () => showTagListModal(context,
                                      modal: TagSelector(
                                        allowEmptySubmit: true,
                                        includeNullTag: false,
                                        selectedTags: moreInfoData.tags,
                                      )).then(
                                    (value) {
                                      if (value != null) {
                                        setState(() {
                                          moreInfoData = moreInfoData.copyWith(
                                            tags: value.nonNulls.toList(),
                                          );
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            footer: BottomSheetFooter(
              onSaved: () => Navigator.pop(context, moreInfoData),
            ),
          );
        });
  }
}
