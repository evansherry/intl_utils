library intl_utils;

import 'dart:io';

import 'package:intl_utils_plus/intl_utils.dart';
import 'package:intl_utils_plus/src/generator/generator_exception.dart';
import 'package:intl_utils_plus/src/utils/utils.dart';

Future<void> main(List<String> args) async {
  try {
    if (args.contains('reDir')) {
      reDirectory();
    }
    var generator = Generator();
    await generator.generateAsync(args.contains('app'));
  } on GeneratorException catch (e) {
    exitWithError(e.message);
  } catch (e) {
    exitWithError('Failed to generate localization files.\n$e');
  }
}

/// 如果路径中包含lib/l10n，进入lib上层
void reDirectory() {
  final curPath = Directory.current.path;
  final index = curPath.indexOf('lib/l10n');
  if (index != -1) {
    Directory.current = curPath.substring(0, index);
  }
}
