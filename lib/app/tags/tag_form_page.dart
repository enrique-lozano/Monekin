import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/form_fields/read_only_form_field.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TagFormPage extends StatefulWidget {
  const TagFormPage({super.key, this.tag});

  final Tag? tag;

  @override
  State<TagFormPage> createState() => _TagFormPageState();
}

class _TagFormPageState extends State<TagFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();

  late String _color;

  Color get _colorObj => ColorHex.get(_color);

  @override
  void initState() {
    super.initState();

    _nameController.value = TextEditingValue(text: widget.tag?.name ?? '');
    _descrController.value = TextEditingValue(
      text: widget.tag?.description ?? '',
    );

    _color = widget.tag?.color ?? defaultColorPickerOptions.randomItem();
  }

  submitForm() async {
    final messager = ScaffoldMessenger.of(context);

    final tagToEdit = Tag(
      id: widget.tag?.id ?? generateUUID(),
      name: _nameController.text,
      description: _descrController.text.isEmpty ? null : _descrController.text,
      color: _color,
    );

    if (widget.tag != null) {
      await TagService.instance
          .updateTag(tagToEdit)
          .then((value) {
            messager.showSnackBar(SnackBar(content: Text(t.tags.edit_success)));
          })
          .catchError((error) {
            messager.showSnackBar(SnackBar(content: Text(error.toString())));
          });
    } else {
      final db = AppDB.instance;

      final query = db.select(db.tags)
        ..addColumns([db.tags.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        messager.showSnackBar(SnackBar(content: Text(t.tags.already_exists)));

        return;
      }

      await TagService.instance
          .insertTag(tagToEdit)
          .then((value) {
            Navigator.pop(context);

            messager.showSnackBar(
              SnackBar(content: Text(t.tags.create_success)),
            );
          })
          .catchError((error) {
            messager.showSnackBar(SnackBar(content: Text(error.toString())));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tag != null ? t.tags.edit : t.tags.add),
        actions: [
          if (widget.tag != null)
            IconButton(
              onPressed: () {
                final scaffold = ScaffoldMessenger.of(context);

                confirmDialog(
                  context,
                  dialogTitle: t.tags.delete_warning_header,
                  contentParagraphs: [Text(t.tags.delete_warning_message)],
                  confirmationText: t.ui_actions.continue_text,
                  showCancelButton: true,
                  icon: Icons.delete,
                ).then((isConfirmed) {
                  if (isConfirmed != true) return;

                  TagService.instance
                      .deleteTag(widget.tag!.id)
                      .then((value) {
                        Navigator.pop(context);

                        scaffold.showSnackBar(
                          SnackBar(content: Text(t.tags.delete_success)),
                        );
                      })
                      .catchError((err) {
                        scaffold.showSnackBar(SnackBar(content: Text('$err')));
                      });
                });
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                submitForm();
              }
            },
            icon: const Icon(Icons.check),
            label: Text(t.ui_actions.save_changes),
          ),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Tag.icon, color: _colorObj, size: 48),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          maxLength: maxLabelLenghtForDisplayNames,
                          decoration: InputDecoration(
                            labelText: '${t.tags.form.name} *',
                            hintText: 'Ex.: Food',
                          ),
                          validator: (value) =>
                              fieldValidator(value, isRequired: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ReadOnlyTextFormField(
                    displayValue: null,
                    decoration: InputDecoration(
                      hintText: t.icon_selector.color,
                      suffixIcon: const Icon(Icons.circle),
                      suffixIconColor: ColorHex.get(_color),
                    ),
                    onTap: () => showColorPickerModal(
                      context,
                      ColorPickerModal(
                        colorOptions: defaultColorPickerOptions,
                        selectedColor: _color,
                        onColorSelected: (value) {
                          Navigator.pop(context);

                          setState(() {
                            _color = value.toHex();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descrController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: t.tags.form.description,
                      alignLabelWithHint: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
