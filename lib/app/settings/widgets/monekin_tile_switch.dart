import 'package:flutter/material.dart';

class MonekinTileSwitch extends StatefulWidget {
  const MonekinTileSwitch({
    super.key,
    required this.title,
    this.subtitle,
    this.initialValue = false,
    this.icon,
    required this.onSwitched,
    this.syncWithInitialValue = true,
    this.disabled = false,
  });

  final String title;
  final String? subtitle;
  final bool initialValue;
  final IconData? icon;
  final Function(bool)? onSwitched;
  final bool syncWithInitialValue;
  final bool disabled;

  @override
  State<MonekinTileSwitch> createState() => _MonekinTileSwitchState();
}

class _MonekinTileSwitchState extends State<MonekinTileSwitch> {
  bool value = true;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  void didUpdateWidget(MonekinTileSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != value && widget.syncWithInitialValue) {
      setState(() {
        value = widget.initialValue;
      });
    }
  }

  Future<void> toggleSwitch() async {
    if (widget.onSwitched == null) {
      return;
    }

    setState(() {
      value = !value;
    });

    try {
      await widget.onSwitched!(value);
    } catch (e) {
      setState(() {
        value = !value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle == null ? null : Text(widget.subtitle!),
      secondary: widget.icon == null ? null : Icon(widget.icon),
      value: value,
      onChanged: widget.disabled
          ? null
          : (_) {
              toggleSwitch();
            },
    );
  }
}
