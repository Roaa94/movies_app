import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

class GoldenTestUtils {
  /// Loads the cached material icon font.
  /// Relies on the tool updating cached assets before running tests.
  static Future<void> loadMaterialIconsFont() async {
    const FileSystem fs = LocalFileSystem();
    const Platform platform = LocalPlatform();
    final flutterRoot = fs.directory(platform.environment['FLUTTER_ROOT']);

    final iconFont = flutterRoot.childFile(
      fs.path.join(
        'bin',
        'cache',
        'artifacts',
        'material_fonts',
        'MaterialIcons-Regular.otf',
      ),
    );

    final bytes =
        Future<ByteData>.value(iconFont.readAsBytesSync().buffer.asByteData());

    await (FontLoader('MaterialIcons')..addFont(bytes)).load();
  }
}
