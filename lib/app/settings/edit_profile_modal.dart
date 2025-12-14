import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class EditProfileModal extends StatefulWidget {
  const EditProfileModal({super.key});

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  String? selectedAvatar;

  final List<String> allAvatars = [
    'man',
    'woman',
    'executive_man',
    'executive_woman',
    'blonde_man',
    'blonde_woman',
    'black_man',
    'black_woman',
    'woman_with_bangs',
    'man_with_goatee',
  ];

  @override
  void initState() {
    super.initState();

    selectedAvatar = appStateSettings[SettingKey.avatar];
    _nameController.value = TextEditingValue(
      text: appStateSettings[SettingKey.userName] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.settings.edit_profile,
      footer: BottomSheetFooter(
        onSaved: selectedAvatar == null
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  final userSettingsService = UserSettingService.instance;

                  Future.wait(
                    [
                      userSettingsService.setItem(
                        SettingKey.userName,
                        _nameController.text,
                      ),
                      userSettingsService.setItem(
                        SettingKey.avatar,
                        selectedAvatar!,
                      ),
                    ].map((e) => Future.value(e)),
                  ).then((value) {
                    RouteUtils.popRoute();
                  });
                }
              },
      ),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              maxLength: 20,
              decoration: const InputDecoration(labelText: 'User name *'),
              validator: (value) => fieldValidator(value, isRequired: true),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, // gap between adjacent cards
            runSpacing: 12, // gap between lines
            alignment: WrapAlignment.center,
            children: allAvatars
                .map((avatarName) => buildTappableAvatar(context, avatarName))
                .toList(),
          ),
        ],
      ),
    );
  }

  Tappable buildTappableAvatar(BuildContext context, String avatarName) {
    return Tappable(
      borderRadius: BorderRadius.circular(888),
      bgColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          selectedAvatar = avatarName;
        });
      },
      child: UserAvatar(
        avatar: avatarName,
        size: 52,
        backgroundColor: Colors.transparent,
        border: selectedAvatar == avatarName
            ? Border.all(width: 2, color: Theme.of(context).colorScheme.primary)
            : Border.all(width: 2, color: Colors.transparent),
      ),
    );
  }
}
