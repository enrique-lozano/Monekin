import 'package:flutter/material.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class SubcategoryFormDialog extends StatefulWidget {
  const SubcategoryFormDialog(
      {super.key,
      required this.onSubmit,
      this.name = '',
      required this.icon,
      this.color = Colors.black});

  final String name;
  final SupportedIcon icon;
  final Color color;

  final void Function(String name, SupportedIcon icon) onSubmit;

  @override
  State<SubcategoryFormDialog> createState() => _SubcategoryFormDialogState();
}

class _SubcategoryFormDialogState extends State<SubcategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  late SupportedIcon _icon;
  late Color _color;

  @override
  void initState() {
    super.initState();

    _nameController.value = TextEditingValue(text: widget.name);

    setState(() {
      _icon = widget.icon;
      _color = widget.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: widget.name.isEmpty
          ? t.categories.subcategories_add
          : t.categories.edit,
      footer: BottomSheetFooter(onSaved: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          widget.onSubmit(_nameController.text, _icon);
          Navigator.pop(context);
        }
      }),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => showIconSelectorModal(
              context,
              IconSelectorModal(
                preselectedIconID: _icon.id,
                subtitle: t.icon_selector.select_category_icon,
                onIconSelected: (selectedIcon) {
                  setState(() {
                    _icon = selectedIcon;
                  });
                },
              ),
            ),
            child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: _color.withOpacity(0.05),
                    border: Border.all(
                      width: 1,
                      color: _color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: _icon.display(size: 50, color: _color)),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                maxLength: maxLabelLenghtForDisplayNames,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: '${t.categories.name} *',
                  hintText: 'Ex.: My account',
                ),
                validator: (value) => fieldValidator(value, isRequired: true),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
          )
        ],
      ),
    );
  }
}
