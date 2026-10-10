// Lists the connected devices, asks which one to capture the screenshots on
// and prints the `flutter drive` flags for it: the device id, plus `--profile`
// when the device supports it (much faster than debug). Used by
// `scripts/generate_screenshots.bat`.
//
// Profile mode only works on physical Android devices: emulators don't
// support it, and on desktop the captures are taken from a debug-only API.
//
// Run from the repository root:
//   dart app-marketplaces/store-images/editor/pick_device.dart
import 'dart:convert';
import 'dart:io';

/// Platforms the screenshot test can run on.
const _supportedPlatforms = {'android', 'windows'};

Future<void> main() async {
  final result = await Process.run('flutter', [
    'devices',
    '--machine',
  ], runInShell: true);
  if (result.exitCode != 0) {
    stderr.writeln('Failed listing devices:\n${result.stderr}');
    exit(1);
  }

  final output = result.stdout as String;
  final devices = [
    for (final device
        in (jsonDecode(output.substring(output.indexOf('['))) as List)
            .cast<Map<String, dynamic>>())
      if (_supportedPlatforms.any(
        (p) => (device['targetPlatform'] as String).startsWith(p),
      ))
        device,
  ];

  if (devices.isEmpty) {
    stderr.writeln(
      'No Android device, emulator or Windows desktop found. '
      'Start an emulator or connect a device first.',
    );
    exit(1);
  }

  bool supportsProfile(Map<String, dynamic> device) =>
      (device['targetPlatform'] as String).startsWith('android') &&
      device['emulator'] == false;

  var chosen = devices.first;
  if (devices.length > 1) {
    stderr.writeln('Devices:');
    for (final (i, device) in devices.indexed) {
      final mode = supportsProfile(device) ? 'profile, faster' : 'debug';
      stderr.writeln('  ${i + 1}. ${device['name']} ($mode)');
    }
    stderr.write('Device to use (Enter = 1): ');
    final answer = int.tryParse(_readAnswer().trim()) ?? 1;
    chosen = devices[(answer - 1).clamp(0, devices.length - 1)];
  }

  final profile = supportsProfile(chosen);
  stderr.writeln(
    'Using ${chosen['name']} in ${profile ? 'profile' : 'debug'} mode.',
  );
  stdout.write(['-d', chosen['id'], if (profile) '--profile'].join(' '));
}

/// Reads a line typed by the user. The .bat runs this script inside `for /f`,
/// which leaves stdin empty, so on Windows it reads from the console instead.
String _readAnswer() {
  if (!Platform.isWindows) return stdin.readLineSync() ?? '';

  final console = File('CON').openSync();
  try {
    final bytes = <int>[];
    while (true) {
      final byte = console.readByteSync();
      if (byte == -1 || byte == 10 || byte == 13) break;
      bytes.add(byte);
    }
    return String.fromCharCodes(bytes);
  } finally {
    console.closeSync();
  }
}
