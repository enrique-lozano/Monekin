import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context, rootNavigator: true).pop();
  }

  void show() {
    showDialog(
      useRootNavigator: true,
      context: _context,
      barrierDismissible: false,
      builder: (ctx) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
