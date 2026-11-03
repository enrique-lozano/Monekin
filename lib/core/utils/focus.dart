import 'package:material_ui/material_ui.dart';

void unfocusCurrentFocusedItem(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild?.unfocus();
  }
}
