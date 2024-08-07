import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<String?> showTransactionTitleModal(
  BuildContext context, {
  required String? initialTitle,
}) {
  return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return TransactionTitleModal(
          initialTitle: initialTitle,
        );
      });
}

class TransactionTitleModal extends StatefulWidget {
  const TransactionTitleModal({super.key, required this.initialTitle});

  final String? initialTitle;

  @override
  State<TransactionTitleModal> createState() => _TransactionTitleModalState();
}

class _TransactionTitleModalState extends State<TransactionTitleModal> {
  FocusNode titleFocusNode = FocusNode();

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.initialTitle ?? '';
    titleFocusNode.requestFocus();
  }

  @override
  void dispose() {
    titleFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.transaction.form.title,
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      body: TextFormField(
        controller: titleController,
        maxLength: maxLabelLenghtForDisplayNames,
        decoration:
            InputDecoration(label: Text(t.transaction.form.title_short)),
        focusNode: titleFocusNode,
      ),
      footer: BottomSheetFooter(
        onSaved: () => Navigator.pop(context, titleController.text),
      ),
    );
  }
}
