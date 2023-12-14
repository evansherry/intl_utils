library intl_utils;

import 'package:intl_utils_plus/intl_utils.dart';
import 'package:intl_utils_plus/src/generator/generator_exception.dart';
import 'package:intl_utils_plus/src/utils/utils.dart';

Future<void> main(List<String> args) async {
  try {
    var generator = Generator();
    await generator.generateAsync();
  } on GeneratorException catch (e) {
    exitWithError(e.message);
  } catch (e) {
    exitWithError('Failed to generate localization files.\n$e');
  }
}
