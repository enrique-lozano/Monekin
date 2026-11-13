import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/database/services/user-setting/app_lock_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Covers [child] with a lock screen while the app is locked. Locks again when
/// the app comes back from the background after [AppLockService.relockAfter].
class AppLockGate extends StatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  final _service = AppLockService.instance;

  DateTime? _backgroundedAt;
  bool _authenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _service.isLocked.addListener(_onLockChanged);
    _onLockChanged();
  }

  @override
  void dispose() {
    _service.isLocked.removeListener(_onLockChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The system auth prompt also sends the app to background, ignore it
    if (_authenticating) return;

    if (state == AppLifecycleState.paused) {
      _backgroundedAt ??= DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      final since = _backgroundedAt;
      _backgroundedAt = null;

      if (_service.isEnabled &&
          since != null &&
          DateTime.now().difference(since) >= AppLockService.relockAfter) {
        _service.isLocked.value = true;
      }
    }
  }

  void _onLockChanged() {
    if (_service.isLocked.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _unlock());
    }
  }

  Future<void> _unlock() async {
    if (_authenticating || !mounted || !_service.isLocked.value) return;

    _authenticating = true;
    final ok = await _service.authenticate(
      Translations.of(context).settings.security.app_lock.unlock_reason,
    );
    _authenticating = false;

    if (ok) {
      _service.isLocked.value = false;
    } else if (!await _service.isDeviceSupported()) {
      // The device lock was removed after enabling the app lock: let the user in
      // instead of locking them out forever
      await _service.setEnabled(false);
      _service.isLocked.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _service.isLocked,
      child: widget.child,
      builder: (context, locked, child) {
        return Stack(
          children: [
            Offstage(offstage: locked, child: child),
            if (locked) _LockScreen(onUnlock: _unlock),
          ],
        );
      },
    );
  }
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({required this.onUnlock});

  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;

    return Positioned.fill(
      child: Material(
        color: colors.surface,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_outline_rounded, size: 64, color: colors.primary),
              const SizedBox(height: 16),
              Text(
                t.settings.security.app_lock.locked,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onUnlock,
                icon: const Icon(Icons.fingerprint),
                label: Text(t.settings.security.app_lock.unlock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
