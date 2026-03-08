import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:monekin/app/debts/debt_form_page.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DebtFabButton extends StatefulWidget {
  const DebtFabButton({super.key});

  @override
  State<DebtFabButton> createState() => _DebtFabButtonState();
}

class _DebtFabButtonState extends State<DebtFabButton> {
  final _fabKey = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ExpandableFab(
      key: _fabKey,
      overlayStyle: ExpandableFabOverlayStyle(color: Colors.transparent),
      type: ExpandableFabType.up,
      pos: ExpandableFabPos.right,
      duration: const Duration(milliseconds: 250),
      distance: 56,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add_rounded),
        fabSize: ExpandableFabSize.regular,
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        backgroundColor: Colors.red.shade100,
        foregroundColor: Colors.red.shade400,
        fabSize: ExpandableFabSize.small,
      ),
      children: [
        buildFabOption(DebtDirection.lent),
        buildFabOption(DebtDirection.borrowed),
      ],
    );
  }

  Widget buildFabOption(DebtDirection direction) {
    return SizedBox(
      height: 48,
      child: FloatingActionButton.extended(
        heroTag: null,
        icon: Icon(direction.icon()),
        label: Text(direction.title(context)),
        onPressed: () {
          final state = _fabKey.currentState;
          if (state != null && state.isOpen) {
            state.toggle();
          }
          RouteUtils.pushRoute(DebtFormPage(type: direction));
        },
      ),
    );
  }
}
