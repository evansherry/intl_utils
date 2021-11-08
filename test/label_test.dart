import 'package:intl_utils/src/generator/label.dart';
import 'package:test/test.dart';

void main() {
  group('Label instantiation', () {
    test('Test instantiation with mandatory args', () {
      var label = Label('labelName', 'Content');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation with all args', () {
      var label = Label('labelName', 'Content with {name} placeholder!',
          type: 'text',
          description: 'Description',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with {name} placeholder!'));
      expect(label.type, equals('text'));
      expect(label.description, equals('Description'));
      expect(label.placeholders?.length, equals(1));
      expect(label.placeholders?.first.name, equals('name'));
    });

    test('Test instantiation when content contains a tag', () {
      var label = Label('labelName', 'Content with a <b>tag</b>.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with a <b>tag</b>.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a less-than sign', () {
      var label = Label('labelName', 'Content with a < sign.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with a < sign.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a greater-than sign', () {
      var label = Label('labelName', 'Content with a > sign.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with a > sign.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a new line', () {
      var label = Label('labelName', 'Content with \n new line.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with \n new line.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a single quotation mark',
        () {
      var label = Label('labelName', 'Content with \' single quotation mark.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with \' single quotation mark.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a dollar sign', () {
      var label = Label('labelName', 'Content with \$ dollar sign.');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content with \$ dollar sign.'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when content contains a simple json string', () {
      var label =
          Label('labelName', '{ "firstName": "John", "lastName": "Doe" }');

      expect(label.name, equals('labelName'));
      expect(
          label.content, equals('{ "firstName": "John", "lastName": "Doe" }'));
      expect(label.type, isNull);
      expect(label.description, isNull);
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a tag', () {
      var label = Label('labelName', 'Content',
          description: 'Description with a <b>tag</b>');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, equals('Description with a <b>tag</b>'));
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a less-than sign', () {
      var label = Label('labelName', 'Content',
          description: 'Description with a < sign');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, equals('Description with a < sign'));
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a greater-than sign',
        () {
      var label = Label('labelName', 'Content',
          description: 'Description with a > sign');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, equals('Description with a > sign'));
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a new line', () {
      var label = Label('labelName', 'Content',
          description: 'Description with \n new line');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, equals('Description with \n new line'));
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a single quotation mark',
        () {
      var label = Label('labelName', 'Content',
          description: 'Description with \' single quotation mark');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description,
          equals('Description with \' single quotation mark'));
      expect(label.placeholders, isNull);
    });

    test('Test instantiation when description contains a dollar sign', () {
      var label = Label('labelName', 'Content',
          description: 'Description with \$ dollar sign');

      expect(label.name, equals('labelName'));
      expect(label.content, equals('Content'));
      expect(label.type, isNull);
      expect(label.description, equals('Description with \$ dollar sign'));
      expect(label.placeholders, isNull);
    });
  });

  group('Invalid label properties', () {
    test('Test dart getter when name is empty string', () {
      var label = Label('', 'Content');

      expect(label.generateDartGetter(),
          equals("  // skipped getter for the '' key"));
    });

    test('Test dart getter when name is plain text', () {
      var label = Label('Some plain text', 'Content');

      expect(label.generateDartGetter(),
          equals("  // skipped getter for the 'Some plain text' key"));
    });

    test('Test dart getter when name does not follow naming convention', () {
      var label = Label('page.home.title', 'Content');

      expect(label.generateDartGetter(),
          equals("  // skipped getter for the 'page.home.title' key"));
    });

    test('Test dart getter when content contains an empty placeholder', () {
      var label = Label('labelName', 'Content {} with empty placeholder');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Content {} with empty placeholder`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Content {} with empty placeholder\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join("\n")));
    });

    test('Test dart getter when content contains a digit placeholder', () {
      var label = Label('labelName', 'Content {0} with digit placeholder');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Content {0} with digit placeholder`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Content {0} with digit placeholder\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join("\n")));
    });

    test('Test dart getter when content contains a hash placeholder', () {
      var label = Label('labelName', 'Content {#} with hash placeholder');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Content {#} with hash placeholder`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Content {#} with hash placeholder\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join("\n")));
    });

    test(
        'Test dart getter when content contains a placeholder which name does not follow naming convention',
        () {
      var label = Label('labelName',
          'Content {invalid-placeholder-name} with invalid placeholder name');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Content {invalid-placeholder-name} with invalid placeholder name`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Content {invalid-placeholder-name} with invalid placeholder name\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join("\n")));
    });
  });

  group('Literal getters', () {
    test('Test literal dart getter with name and content set', () {
      var label = Label('labelName', 'Literal message');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter with name, content and type set', () {
      var label = Label('labelName', 'Literal message', type: 'text');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test literal dart getter with name, content, type and description set',
        () {
      var label = Label('labelName', 'Literal message',
          type: 'text', description: 'Some description');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'Some description\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a tag', () {
      var label = Label('labelName', 'Literal message with a <b>tag</b>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message with a <b>tag</b>`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message with a <b>tag</b>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content is wrapped with tag', () {
      var label =
          Label('labelName', '<p>Literal message with a <b>tag</b></p>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>Literal message with a <b>tag</b></p>`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'<p>Literal message with a <b>tag</b></p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a less-than sign', () {
      var label = Label('labelName', 'Literal message with a < sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message with a < sign`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message with a < sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a greater-than sign',
        () {
      var label = Label('labelName', 'Literal message with a > sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message with a > sign`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message with a > sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a backtick', () {
      var label = Label('labelName', 'Literal `message`');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal \'message\'`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal `message`\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a new line', () {
      var label = Label('labelName', 'Literal message \n with new line');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message \\n with new line`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message \\n with new line\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test literal dart getter when content contains a single quotation mark',
        () {
      var label =
          Label('labelName', 'Literal message \' with single quotation mark');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message \' with single quotation mark`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message \\\' with single quotation mark\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a dollar sign', () {
      var label = Label('labelName', 'Literal message \$ with dollar sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message \$ with dollar sign`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message \\\$ with dollar sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains escaping chars', () {
      var label = Label('labelName', 'Escaping chars: \\\n\r\t\b\f\'"');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Escaping chars: \\\\n\\r\\t\\b\\f\'"`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Escaping chars: \\\\\\n\\r\\t\\b\\f\\\'"\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a simple json string',
        () {
      var label =
          Label('labelName', '{ "firstName": "John", "lastName": "Doe" }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "firstName": "John", "lastName": "Doe" }`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'{ "firstName": "John", "lastName": "Doe" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a nested json string',
        () {
      var label = Label('labelName',
          '{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when content contains a complex json string',
        () {
      var label = Label('labelName',
          '{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'{ "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test literal dart getter when content contains a json string with special chars',
        () {
      var label = Label('labelName',
          '{ "special_chars": "abc !@#\$%^&*()_+-=`~[]{};\'\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "special_chars": "abc !@#\$%^&*()_+-=\'~[]{};\'\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'{ "special_chars": "abc !@#\\\$%^&*()_+-=`~[]{};\\\'\\\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when description contains a new line', () {
      var label = Label('labelName', 'Literal message',
          description: 'Description \n with new line');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'Description \\n with new line\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test literal dart getter when description contains a single quotation mark',
        () {
      var label = Label('labelName', 'Literal message',
          description: 'Description \' with single quotation mark');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'Description \\\' with single quotation mark\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when description contains a dollar sign',
        () {
      var label = Label('labelName', 'Literal message',
          description: 'Description \$ with dollar sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'Description \\\$ with dollar sign\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test literal dart getter when description contains escaping chars',
        () {
      var label = Label('labelName', 'Literal message',
          description: 'Escaping chars: \\\n\r\t\b\f\'"');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Literal message`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'Literal message\',',
            '      name: \'labelName\',',
            '      desc: \'Escaping chars: \\\\\\n\\r\\t\\b\\f\\\'"\',',
            '      args: [],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Argument getters', () {
    test('Test argument dart getter with name and content set', () {
      var label = Label('labelName', 'Argument message {name}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and placeholders set when placeholders are not used',
        () {
      var label = Label('labelName', 'Argument message',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter with name, content and placeholders set',
        () {
      var label = Label('labelName', 'Argument message {name}.',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and the first placeholder set',
        () {
      var label = Label('labelName', 'Argument message {firstName} {lastName}.',
          placeholders: [Placeholder('labelName', 'firstName', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName}.`',
            '  String labelName(Object firstName, Object lastName) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [firstName, lastName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and the last placeholder set',
        () {
      var label = Label('labelName', 'Argument message {firstName} {lastName}.',
          placeholders: [Placeholder('labelName', 'lastName', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName}.`',
            '  String labelName(Object lastName, Object firstName) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [lastName, firstName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name and content set when some placeholders are repeated',
        () {
      var label = Label('labelName',
          'Argument message {firstName} {lastName} {address}, {firstName} {lastName}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName} {address}, {firstName} {lastName}.`',
            '  String labelName(Object firstName, Object lastName, Object address) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName \$address, \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [firstName, lastName, address],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and placeholders set when some placeholders are repeated',
        () {
      var label = Label('labelName',
          'Argument message {firstName} {lastName} {address}, {firstName} {lastName}.',
          placeholders: [
            Placeholder('labelName', 'firstName', {}),
            Placeholder('labelName', 'lastName', {}),
            Placeholder('labelName', 'address', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName} {address}, {firstName} {lastName}.`',
            '  String labelName(Object firstName, Object lastName, Object address) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName \$address, \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [firstName, lastName, address],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and the first placeholder set when some placeholders are repeated',
        () {
      var label = Label('labelName',
          'Argument message {firstName} {lastName} {address}, {firstName} {lastName}.',
          placeholders: [Placeholder('labelName', 'firstName', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName} {address}, {firstName} {lastName}.`',
            '  String labelName(Object firstName, Object lastName, Object address) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName \$address, \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [firstName, lastName, address],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter with name, content and the last placeholder set when some placeholders are repeated',
        () {
      var label = Label('labelName',
          'Argument message {firstName} {lastName} {address}, {firstName} {lastName}.',
          placeholders: [Placeholder('labelName', 'address', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {firstName} {lastName} {address}, {firstName} {lastName}.`',
            '  String labelName(Object address, Object firstName, Object lastName) {',
            '    return Intl.message(',
            '      \'Argument message \$firstName \$lastName \$address, \$firstName \$lastName.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [address, firstName, lastName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a tag', () {
      var label = Label('labelName', 'Argument message <b>{name}</b>.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message <b>{name}</b>.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message <b>\$name</b>.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content is wrapped with tag', () {
      var label = Label('labelName', '<p>Argument message <b>{name}</b>.</p>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>Argument message <b>{name}</b>.</p>`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'<p>Argument message <b>\$name</b>.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a less-than sign',
        () {
      var label = Label('labelName', 'Argument message with < {placeholder}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message with < {placeholder}.`',
            '  String labelName(Object placeholder) {',
            '    return Intl.message(',
            '      \'Argument message with < \$placeholder.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [placeholder],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a greater-than sign',
        () {
      var label = Label('labelName', 'Argument message with > {placeholder}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message with > {placeholder}.`',
            '  String labelName(Object placeholder) {',
            '    return Intl.message(',
            '      \'Argument message with > \$placeholder.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [placeholder],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a backtick', () {
      var label = Label('labelName', 'Argument `message` {name}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument \'message\' {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument `message` \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a new line', () {
      var label = Label('labelName', 'Argument message \n {name}.',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message \\n {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \\n \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when content contains a single quotation mark',
        () {
      var label = Label('labelName', 'Argument message \' {name}.',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message \' {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \\\' \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a dollar sign', () {
      var label = Label('labelName', 'Argument message \$ {name}.',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message \$ {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \\\$ \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with text at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before{name} after.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before{name} after.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before\$name after.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with underscore sign at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before _{name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before _{name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before _\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with number at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before 357{name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before 357{name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before 357\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dash sign at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before -{name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before -{name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before -\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dot sign at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before .{name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before .{name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before .\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with ampersand sign at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before &{name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before &{name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before &\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dollar sign at the beginning',
        () {
      var label = Label('labelName', 'Argument message: before \${name} .');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before \${name} .`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \\\$\$name .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with text at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}after.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}after.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \${name}after.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with underscore sign at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}_.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}_.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \${name}_.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with number at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}357.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}357.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \${name}357.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dash sign at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}-.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}-.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \$name-.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dot sign at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with ampersand sign at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}&.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}&.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \$name&.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with dollar sign at the ending',
        () {
      var label = Label('labelName', 'Argument message: before {name}\$.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before {name}\$.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before \$name\\\$.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder is linked with text at the beginning and the ending',
        () {
      var label = Label('labelName', 'Argument message: before{name}after.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: before{name}after.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: before\${name}after.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a simple json string',
        () {
      var label = Label('labelName',
          'Argument message: {name} - { "firstName": "John", "lastName": "Doe" }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: {name} - { "firstName": "John", "lastName": "Doe" }`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: \$name - { "firstName": "John", "lastName": "Doe" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when content contains a nested json string',
        () {
      var label = Label('labelName',
          'Argument message: {name} - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: {name} - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: \$name - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" } }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when content contains a complex json string',
        () {
      var label = Label('labelName',
          'Argument message: {name} - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: {name} - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: \$name - { "firstName": "John", "lastName": "Doe", "address": { "street": "Some street 123", "city": "Some city" }, "skills": [ { "name": "programming" }, { "name": "design" } ] }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when content contains a json string with special chars',
        () {
      var label = Label('labelName',
          'Argument message: {name} - { "special_chars": "abc !@#\$%^&*()_+-=`~[]{};\'\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message: {name} - { "special_chars": "abc !@#\$%^&*()_+-=\'~[]{};\'\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message: \$name - { "special_chars": "abc !@#\\\$%^&*()_+-=`~[]{};\\\'\\\\:"|,./<>?*ÄäÖöÜüẞ你好أهلا" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when content contains a json string with placeholders',
        () {
      var label = Label('labelName',
          '{ "name": "{name}", "address": { "street": "{street}", "city": "{city}" } }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "name": "{name}", "address": { "street": "{street}", "city": "{city}" } }`',
            '  String labelName(Object name, Object street, Object city) {',
            '    return Intl.message(',
            '      \'{ "name": "\$name", "address": { "street": "\$street", "city": "\$city" } }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name, street, city],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when content contains a json string with formatted placeholder',
        () {
      var label = Label('labelName', '{ "name": "{name}", "date": "{date}" }',
          placeholders: [
            Placeholder('labelName', 'name', {'type': 'String'}),
            Placeholder(
                'labelName', 'date', {'type': 'DateTime', 'format': 'yMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{ "name": "{name}", "date": "{date}" }`',
            '  String labelName(String name, DateTime date) {',
            '    final DateFormat dateDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String dateString = dateDateFormat.format(date);',
            '',
            '    return Intl.message(',
            '      \'{ "name": "\$name", "date": "\$dateString" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name, dateString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format is not provided',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format is blank string',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': ' '})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format is invalid',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'invalid'})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format d',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.d(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format E',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'E'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.E(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format EEEE',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'EEEE'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.EEEE(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format LLL',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'LLL'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.LLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format LLLL',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'LLLL'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.LLLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format M',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'M'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.M(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format Md',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'Md'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Md(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'MEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMM',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'MMM'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMMd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'MMMd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMMEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'MMMEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMMM',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'MMMM'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMMMd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format MMMMEEEEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMEEEEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format QQQ',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'QQQ'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format QQQQ',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'QQQQ'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format y',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'y'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.y(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yM',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'yM'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'yMd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMM',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMM'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMMd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMMEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMMM',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMM'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMMMd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yMMMMEEEEd',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMEEEEd'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yQQQ',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQ'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format yQQQQ',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQQ'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format H',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'H'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.H(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format Hm',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'Hm'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Hm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format Hms',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'Hms'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Hms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format j',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'j'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.j(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jm',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jm'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jms',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jms'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jmv',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jmv'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jmv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jmz',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jmz'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jmz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jv',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jv'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format jz',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'jz'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format m',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'm'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.m(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format ms',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 'ms'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.ms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type DateTime and format s',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'DateTime', 'format': 's'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.s(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format is not provided',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'int'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format is blank string',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'int', 'format': ' '})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type int and format is invalid',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'int', 'format': 'invalid'})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type int and format compact',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'int', 'format': 'compact'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format compactCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'int', 'format': 'compactCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format compactSimpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'int', 'format': 'compactSimpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format compactLong',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'int', 'format': 'compactLong'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format currency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'int', 'format': 'currency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format decimalPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'int', 'format': 'decimalPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format decimalPercentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'int', 'format': 'decimalPercentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format percentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'int', 'format': 'percentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format scientificPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'int', 'format': 'scientificPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int and format simpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'int', 'format': 'simpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'compactCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'compactCurrency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format currency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'currency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'currency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2,
            'customPattern': '\u00A4#,##0.00'
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'decimalPercentPattern',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'simpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'int',
          'format': 'simpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format is not provided',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'double'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format is blank string',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'double', 'format': ' '})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type double and format is invalid',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'double', 'format': 'invalid'})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type double and format compact',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'double', 'format': 'compact'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format compactCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'compactCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format compactSimpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'compactSimpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format compactLong',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'double', 'format': 'compactLong'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format currency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'double', 'format': 'currency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format decimalPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'decimalPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format decimalPercentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'decimalPercentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format percentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'percentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format scientificPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'scientificPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double and format simpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'double', 'format': 'simpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'compactCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'compactCurrency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format currency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'currency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'currency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2,
            'customPattern': '\u00A4#,##0.00'
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'decimalPercentPattern',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'simpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'double',
          'format': 'simpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format is not provided',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'num'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format is blank string',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'num', 'format': ' '})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test argument dart getter when placeholder has type num and format is invalid',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'num', 'format': 'invalid'})
      ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });
    //

    test(
        'Test argument dart getter when placeholder has type num and format compact',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'num', 'format': 'compact'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format compactCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'num', 'format': 'compactCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format compactSimpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'num', 'format': 'compactSimpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format compactLong',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'num', 'format': 'compactLong'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format currency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'num', 'format': 'currency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format decimalPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'num', 'format': 'decimalPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format decimalPercentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'num', 'format': 'decimalPercentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format percentPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'num', 'format': 'percentPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format scientificPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value',
            {'type': 'num', 'format': 'scientificPattern'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num and format simpleCurrency',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder(
            'labelName', 'value', {'type': 'num', 'format': 'simpleCurrency'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'compactCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'compactCurrency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'compactSimpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format currency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'currency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'currency',
          'optionalParameters': {
            'name': 'EUR',
            'symbol': '€',
            'decimalDigits': 2,
            'customPattern': '\u00A4#,##0.00'
          }
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'decimalPercentPattern',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'simpleCurrency',
          'optionalParameters': {'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {
          'type': 'num',
          'format': 'simpleCurrency',
          'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
        })
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'Argument message \$valueString.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when placeholder has type Object', () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'Object'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(Object value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when placeholder has type String', () {
      var label =
          Label('labelName', 'Argument message {value}.', placeholders: [
        Placeholder('labelName', 'value', {'type': 'String'})
      ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {value}.`',
            '  String labelName(String value) {',
            '    return Intl.message(',
            '      \'Argument message \$value.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when description contains a new line', () {
      var label = Label('labelName', 'Argument message {name}.',
          description: 'Description with \n new line',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\n new line\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test argument dart getter when description contains a single quotation mark',
        () {
      var label = Label('labelName', 'Argument message {name}.',
          description: 'Description with \' single quotation mark',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\' single quotation mark\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test argument dart getter when description contains a dollar sign',
        () {
      var label = Label('labelName', 'Argument message {name}.',
          description: 'Description with \$ dollar sign',
          placeholders: [Placeholder('labelName', 'name', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Argument message {name}.`',
            '  String labelName(Object name) {',
            '    return Intl.message(',
            '      \'Argument message \$name.\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\$ dollar sign\',',
            '      args: [name],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Plural getters', () {
    test('Test plural dart getter with name and content set', () {
      var label = Label(
          'labelName', '{count, plural, one {one item} other {other items}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one item} other {other items}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one item\',',
            '      other: \'other items\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter with name, content and placeholders set', () {
      var label = Label(
          'labelName', '{count, plural, one {one item} other {other items}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one item} other {other items}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one item\',',
            '      other: \'other items\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter with name, content and placeholders set for all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message} one {one message} two {two message} few {few message} many {many message} other {other message}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message} one {one message} two {two message} few {few message} many {many message} other {other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message\',',
            '      one: \'one message\',',
            '      two: \'two message\',',
            '      few: \'few message\',',
            '      many: \'many message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter with name, content and placeholders set for all plural forms when plural forms are empty',
        () {
      var label = Label('labelName',
          '{count, plural, zero {} one {} two {} few {} many {} other {}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {} one {} two {} few {} many {} other {}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'\',',
            '      one: \'\',',
            '      two: \'\',',
            '      few: \'\',',
            '      many: \'\',',
            '      other: \'\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: Tags are not supported in plural messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test plural dart getter when content contains a tag in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {<b>zero</b> message} one {<b>one</b> message} two {<b>two</b> message} few {<b>few</b> message} many {<b>many</b> message} other {<b>other</b> message}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {<b>zero</b> message} one {<b>one</b> message} two {<b>two</b> message} few {<b>few</b> message} many {<b>many</b> message} other {<b>other</b> message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'<b>zero</b> message\',',
            '      one: \'<b>one</b> message\',',
            '      two: \'<b>two</b> message\',',
            '      few: \'<b>few</b> message\',',
            '      many: \'<b>many</b> message\',',
            '      other: \'<b>other</b> message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    // Note: Less-than sign is not supported in plural messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test plural dart getter when content contains a less-than sign in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message with < sign} one {one message with < sign} two {two message with < sign} few {few message with < sign} many {many message with < sign} other {other message with < sign}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message with < sign} one {one message with < sign} two {two message with < sign} few {few message with < sign} many {many message with < sign} other {other message with < sign}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message with < sign\',',
            '      one: \'one message with < sign\',',
            '      two: \'two message with < sign\',',
            '      few: \'few message with < sign\',',
            '      many: \'many message with < sign\',',
            '      other: \'other message with < sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test plural dart getter when content contains a greater-than sign in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message with > sign} one {one message with > sign} two {two message with > sign} few {few message with > sign} many {many message with > sign} other {other message with > sign}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message with > sign} one {one message with > sign} two {two message with > sign} few {few message with > sign} many {many message with > sign} other {other message with > sign}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message with > sign\',',
            '      one: \'one message with > sign\',',
            '      two: \'two message with > sign\',',
            '      few: \'few message with > sign\',',
            '      many: \'many message with > sign\',',
            '      other: \'other message with > sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a backtick in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero `message`} one {one `message`} two {two `message`} few {few `message`} many {many `message`} other {other `message`}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero \'message\'} one {one \'message\'} two {two \'message\'} few {few \'message\'} many {many \'message\'} other {other \'message\'}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero `message`\',',
            '      one: \'one `message`\',',
            '      two: \'two `message`\',',
            '      few: \'few `message`\',',
            '      many: \'many `message`\',',
            '      other: \'other `message`\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a new line in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero \n message} one {one \n message} two {two \n message} few {few \n message} many {many \n message} other {other \n message}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero \\n message} one {one \\n message} two {two \\n message} few {few \\n message} many {many \\n message} other {other \\n message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \\n message\',',
            '      one: \'one \\n message\',',
            '      two: \'two \\n message\',',
            '      few: \'few \\n message\',',
            '      many: \'many \\n message\',',
            '      other: \'other \\n message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a single quotation mark in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero \' message} one {one \' message} two {two \' message} few {few \' message} many {many \' message} other {other \' message}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero \' message} one {one \' message} two {two \' message} few {few \' message} many {many \' message} other {other \' message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \\\' message\',',
            '      one: \'one \\\' message\',',
            '      two: \'two \\\' message\',',
            '      few: \'few \\\' message\',',
            '      many: \'many \\\' message\',',
            '      other: \'other \\\' message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a dollar sign in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero \$ message} one {one \$ message} two {two \$ message} few {few \$ message} many {many \$ message} other {other \$ message}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero \$ message} one {one \$ message} two {two \$ message} few {few \$ message} many {many \$ message} other {other \$ message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \\\$ message\',',
            '      one: \'one \\\$ message\',',
            '      two: \'two \\\$ message\',',
            '      few: \'few \\\$ message\',',
            '      many: \'many \\\$ message\',',
            '      other: \'other \\\$ message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a placeholder that is linked with text at the ending in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero {count}abc} one {one {count}abc} two {two {count}abc} few {few {count}abc} many {many {count}abc} other {other {count}abc}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero {count}abc} one {one {count}abc} two {two {count}abc} few {few {count}abc} many {many {count}abc} other {other {count}abc}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \${count}abc\',',
            '      one: \'one \${count}abc\',',
            '      two: \'two \${count}abc\',',
            '      few: \'few \${count}abc\',',
            '      many: \'many \${count}abc\',',
            '      other: \'other \${count}abc\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a placeholder that is linked with underscore sign at the ending in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero {count}_ .} one {one {count}_ .} two {two {count}_ .} few {few {count}_ .} many {many {count}_ .} other {other {count}_ .}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero {count}_ .} one {one {count}_ .} two {two {count}_ .} few {few {count}_ .} many {many {count}_ .} other {other {count}_ .}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \${count}_ .\',',
            '      one: \'one \${count}_ .\',',
            '      two: \'two \${count}_ .\',',
            '      few: \'few \${count}_ .\',',
            '      many: \'many \${count}_ .\',',
            '      other: \'other \${count}_ .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a placeholder that is linked with number at the ending in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero {count}357 .} one {one {count}357 .} two {two {count}357 .} few {few {count}357 .} many {many {count}357 .} other {other {count}357 .}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero {count}357 .} one {one {count}357 .} two {two {count}357 .} few {few {count}357 .} many {many {count}357 .} other {other {count}357 .}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero \${count}357 .\',',
            '      one: \'one \${count}357 .\',',
            '      two: \'two \${count}357 .\',',
            '      few: \'few \${count}357 .\',',
            '      many: \'many \${count}357 .\',',
            '      other: \'other \${count}357 .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains a placeholder that is linked with text at the beginning and the ending in all plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero before{count}after.} one {one before{count}after.} two {two before{count}after.} few {few before{count}after.} many {many before{count}after.} other {other before{count}after.}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero before{count}after.} one {one before{count}after.} two {two before{count}after.} few {few before{count}after.} many {many before{count}after.} other {other before{count}after.}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero before\${count}after.\',',
            '      one: \'one before\${count}after.\',',
            '      two: \'two before\${count}after.\',',
            '      few: \'few before\${count}after.\',',
            '      many: \'many before\${count}after.\',',
            '      other: \'other before\${count}after.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: JSON strings are not supported in plural messages with the current parser implementation.
    test('Test plural dart getter when content contains a simple json string',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message { "firstName": "John", "lastName": "Doe" }} one {one message { "firstName": "John", "lastName": "Doe" }} two {two message { "firstName": "John", "lastName": "Doe" }} few {few message { "firstName": "John", "lastName": "Doe" }} many {many message { "firstName": "John", "lastName": "Doe" }} other {other message { "firstName": "John", "lastName": "Doe" }}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message { "firstName": "John", "lastName": "Doe" }} one {one message { "firstName": "John", "lastName": "Doe" }} two {two message { "firstName": "John", "lastName": "Doe" }} few {few message { "firstName": "John", "lastName": "Doe" }} many {many message { "firstName": "John", "lastName": "Doe" }} other {other message { "firstName": "John", "lastName": "Doe" }}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message { "firstName": "John", "lastName": "Doe" }\',',
            '      one: \'one message { "firstName": "John", "lastName": "Doe" }\',',
            '      two: \'two message { "firstName": "John", "lastName": "Doe" }\',',
            '      few: \'few message { "firstName": "John", "lastName": "Doe" }\',',
            '      many: \'many message { "firstName": "John", "lastName": "Doe" }\',',
            '      other: \'other message { "firstName": "John", "lastName": "Doe" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test plural dart getter when placeholder has type DateTime and format is not provided',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'DateTime'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format is blank string',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format is invalid',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format d',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.d(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format E',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'E'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.E(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format EEEE',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'EEEE'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.EEEE(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format LLL',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.LLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format LLLL',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.LLLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format M',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'M'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.M(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format Md',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Md'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Md(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMM',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMMd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMMEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMMM',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMMMd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format MMMMEEEEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'MMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format QQQ',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format QQQQ',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format y',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'y'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.y(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yM',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMM',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMMd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMMEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMMM',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMMMd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yMMMMEEEEd',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'yMMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yQQQ',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format yQQQQ',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format H',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'H'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.H(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format Hm',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Hm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format Hms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Hms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format j',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'j'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.j(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jm',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jmv',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jmv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jmz',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jmz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jv',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format jz',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format m',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.m(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format ms',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'ms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.ms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type DateTime and format s',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 's'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.s(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format is not provided',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format is blank string',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type int and format is invalid',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type int and format compact',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format compactCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format compactLong',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format currency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format decimalPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format percentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format scientificPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format is not provided',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format is blank string',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type double and format is invalid',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type double and format compact',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format compactCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format compactLong',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format currency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format decimalPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format percentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format scientificPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format is not provided',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format is blank string',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type num and format is invalid',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test plural dart getter when placeholder has type num and format compact',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format compactCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format compactLong',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format currency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format decimalPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format percentPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format scientificPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num value, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when placeholder has type Object', () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'Object'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(Object value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when placeholder has type String', () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'String'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(String value, num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has the type int, the same as plural variable',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'count', {'type': 'int'}),
            Placeholder('labelName', 'value', {'type': 'int'}),
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(int count, int value) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$value\',',
            '      one: \'one message \$value\',',
            '      two: \'two message \$value\',',
            '      few: \'few message \$value\',',
            '      many: \'many message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has the type double, the same as plural variable',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'count', {'type': 'double', 'format': 'compact'}),
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'compact'}),
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(double count, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when placeholder has the type num, the same as plural variable',
        () {
      var label = Label('labelName',
          '{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'count', {'type': 'num', 'format': 'compact'}),
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compact'}),
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, zero {zero message {value}} one {one message {value}} two {two message {value}} few {few message {value}} many {many message {value}} other {other message {value}}}`',
            '  String labelName(num count, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message \$valueString\',',
            '      one: \'one message \$valueString\',',
            '      two: \'two message \$valueString\',',
            '      few: \'few message \$valueString\',',
            '      many: \'many message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when description contains a new line', () {
      var label = Label('labelName',
          '{count, plural, one {one message} other {other message}}',
          description: 'Description with \n new line',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one message} other {other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\n new line\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when description contains a single quotation mark',
        () {
      var label = Label('labelName',
          '{count, plural, one {one message} other {other message}}',
          description: 'Description with \' single quotation mark',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one message} other {other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\' single quotation mark\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when description contains a dollar sign', () {
      var label = Label('labelName',
          '{count, plural, one {one message} other {other message}}',
          description: 'Description with \$ dollar sign',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one message} other {other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\$ dollar sign\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains an additional placeholder',
        () {
      var label = Label('labelName',
          '{count, plural, one {{name} has one item} other {{name} have {count} items}}',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {{name} has one item} other {{name} have {count} items}}`',
            '  String labelName(num count, Object name) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'\$name has one item\',',
            '      other: \'\$name have \$count items\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when content contains nested plural content',
        () {
      var label = Label('labelName',
          '{cats, plural, one {one cat runs {birds, plural, one {one bird.} other {{birds} birds.}}} other {{cats} cats run {birds, plural, one {one bird.} other {{birds} birds.}}}}',
          placeholders: [Placeholder('labelName', 'cats', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{cats, plural, one {one cat runs {birds, plural, one {one bird.} other {{birds} birds.}}} other {{cats} cats run {birds, plural, one {one bird.} other {{birds} birds.}}}}`',
            '  String labelName(num cats, Object birds) {',
            '    return Intl.plural(',
            '      cats,',
            '      one: \'one cat runs {birds, plural, one {one bird.} other {{birds} birds.}}\',',
            '      other: \'{cats} cats run {birds, plural, one {one bird.} other {{birds} birds.}}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [cats, birds],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when content contains nested gender content',
        () {
      var label = Label('labelName',
          '{cats, plural, one {one cat runs {gender, select, male {one man} female {one woman} other {one person}}} other {{cats} cats run {gender, select, male {one man} female {one woman} other {one person}}}}',
          placeholders: [Placeholder('labelName', 'cats', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{cats, plural, one {one cat runs {gender, select, male {one man} female {one woman} other {one person}}} other {{cats} cats run {gender, select, male {one man} female {one woman} other {one person}}}}`',
            '  String labelName(num cats, Object gender) {',
            '    return Intl.plural(',
            '      cats,',
            '      one: \'one cat runs {gender, select, male {one man} female {one woman} other {one person}}\',',
            '      other: \'{cats} cats run {gender, select, male {one man} female {one woman} other {one person}}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [cats, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test plural dart getter when content contains an additional plural form',
        () {
      var label = Label('labelName',
          '{count, plural, one {one message} unsupportedPluralForm {unsupported plural form message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one message} unsupportedPluralForm {unsupported plural form message} other {other message}}`',
            '  String get labelName {',
            '    return Intl.message(',
            '      \'{count, plural, one {one message} unsupportedPluralForm {unsupported plural form message} other {other message}}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [],',
            '    );',
            '  }'
          ].join("\n")));
    });

    test(
        'Test plural dart getter when content contains plural forms with the same meaning',
        () {
      var label = Label('labelName',
          '{count, plural, =0 {=0 message} zero {zero message} =1 {=1 message} one {one message} =2 {=2 message} two {two message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, =0 {=0 message} zero {zero message} =1 {=1 message} one {one message} =2 {=2 message} two {two message} other {other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      zero: \'zero message\',',
            '      one: \'one message\',',
            '      two: \'two message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test plural dart getter when content contains repeated plural forms',
        () {
      var label = Label('labelName',
          '{count, plural, one {one message} one {repeated one message} other {other message} other {repeated other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {one message} one {repeated one message} other {other message} other {repeated other message}}`',
            '  String labelName(num count) {',
            '    return Intl.plural(',
            '      count,',
            '      one: \'one message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Gender getters', () {
    test('Test gender dart getter with name and content set', () {
      var label = Label('labelName',
          '{gender, select, male {male message} female {female message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter with name, content and placeholders set', () {
      var label = Label('labelName',
          '{gender, select, male {male message} female {female message} other {other message}}',
          placeholders: [Placeholder('labelName', 'gender', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter with name, content and placeholders set when gender forms are empty',
        () {
      var label = Label(
          'labelName', '{gender, select, male {} female {} other {}}',
          placeholders: [Placeholder('labelName', 'gender', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {} female {} other {}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'\',',
            '      female: \'\',',
            '      other: \'\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: Tags are not supported in gender messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test gender dart getter when content contains a tag in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {<b>male</b> message} female {<b>female</b> message} other {<b>other</b> message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {<b>male</b> message} female {<b>female</b> message} other {<b>other</b> message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'<b>male</b> message\',',
            '      female: \'<b>female</b> message\',',
            '      other: \'<b>other</b> message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    // Note: Less-than sign is not supported in gender messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test gender dart getter when content contains a less-than sign in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message with < sign} female {female message with < sign} other {other message with < sign}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message with < sign} female {female message with < sign} other {other message with < sign}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message with < sign\',',
            '      female: \'female message with < sign\',',
            '      other: \'other message with < sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test gender dart getter when content contains a greater-than sign in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message with > sign} female {female message with > sign} other {other message with > sign}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message with > sign} female {female message with > sign} other {other message with > sign}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message with > sign\',',
            '      female: \'female message with > sign\',',
            '      other: \'other message with > sign\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a backtick in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male `message`} female {female `message`} other {other `message`}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male \'message\'} female {female \'message\'} other {other \'message\'}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male `message`\',',
            '      female: \'female `message`\',',
            '      other: \'other `message`\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a new line in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male \n message} female {female \n message} other {other \n message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male \\n message} female {female \\n message} other {other \\n message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \\n message\',',
            '      female: \'female \\n message\',',
            '      other: \'other \\n message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a single quotation mark in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male \' message} female {female \' message} other {other \' message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male \' message} female {female \' message} other {other \' message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \\\' message\',',
            '      female: \'female \\\' message\',',
            '      other: \'other \\\' message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a dollar sign in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male \$ message} female {female \$ message} other {other \$ message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male \$ message} female {female \$ message} other {other \$ message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \\\$ message\',',
            '      female: \'female \\\$ message\',',
            '      other: \'other \\\$ message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a placeholder that is linked with text at the ending in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male {gender}abc} female {female {gender}abc} other {other {gender}abc}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male {gender}abc} female {female {gender}abc} other {other {gender}abc}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \${gender}abc\',',
            '      female: \'female \${gender}abc\',',
            '      other: \'other \${gender}abc\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a placeholder that is linked with underscore sign at the ending in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male {gender}_} female {female {gender}_} other {other {gender}_}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male {gender}_} female {female {gender}_} other {other {gender}_}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \${gender}_\',',
            '      female: \'female \${gender}_\',',
            '      other: \'other \${gender}_\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a placeholder that is linked with number at the ending in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male {gender}357 .} female {female {gender}357 .} other {other {gender}357 .}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male {gender}357 .} female {female {gender}357 .} other {other {gender}357 .}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male \${gender}357 .\',',
            '      female: \'female \${gender}357 .\',',
            '      other: \'other \${gender}357 .\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a placeholder that is linked with text at the beginning and the ending in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male before{gender}after} female {female before{gender}after} other {other before{gender}after}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male before{gender}after} female {female before{gender}after} other {other before{gender}after}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male before\${gender}after\',',
            '      female: \'female before\${gender}after\',',
            '      other: \'other before\${gender}after\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: JSON strings are not supported in gender messages with the current parser implementation.
    test('Test gender dart getter when content contains a simple json string',
        () {
      var label = Label('labelName',
          '{gender, select, male {male { "firstName": "John", "lastName": "Doe" }} female {female { "firstName": "John", "lastName": "Doe" }} other {other { "firstName": "John", "lastName": "Doe" }}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male { "firstName": "John", "lastName": "Doe" }} female {female { "firstName": "John", "lastName": "Doe" }} other {other { "firstName": "John", "lastName": "Doe" }}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male { "firstName": "John", "lastName": "Doe" }\',',
            '      female: \'female { "firstName": "John", "lastName": "Doe" }\',',
            '      other: \'other { "firstName": "John", "lastName": "Doe" }\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test gender dart getter when placeholder has type DateTime and format is not provided',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'DateTime'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format is blank string',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format is invalid',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format d',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.d(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format E',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'E'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.E(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format EEEE',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'EEEE'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.EEEE(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format LLL',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.LLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format LLLL',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.LLLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format M',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'M'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.M(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format Md',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Md'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.Md(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMM',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMMd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMMEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMMM',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMMMd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format MMMMEEEEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'MMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format QQQ',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format QQQQ',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format y',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'y'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.y(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yM',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMM',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMMd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMMEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMMM',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMMMd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yMMMMEEEEd',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'yMMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yQQQ',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format yQQQQ',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format H',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'H'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.H(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format Hm',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.Hm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format Hms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.Hms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format j',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'j'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.j(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jm',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jmv',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jmv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jmz',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jmz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jv',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format jz',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.jz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format m',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.m(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format ms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'ms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.ms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type DateTime and format s',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 's'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(DateTime value, String gender) {',
            '    final DateFormat valueDateFormat = DateFormat.s(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format is not provided',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format is blank string',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type int and format is invalid',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type int and format compact',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format compactCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format compactLong',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format currency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format decimalPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format percentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format scientificPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(int value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format is not provided',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format is blank string',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type double and format is invalid',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type double and format compact',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format compactCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format compactLong',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format currency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format decimalPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format percentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format scientificPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(double value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format is not provided',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format is blank string',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type num and format is invalid',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test gender dart getter when placeholder has type num and format compact',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format compactCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format compactLong',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format currency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format decimalPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format percentPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format scientificPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(num value, String gender) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$valueString\',',
            '      female: \'female message \$valueString\',',
            '      other: \'other message \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [valueString, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter when placeholder has type Object', () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'Object'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(Object value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter when placeholder has type String', () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'String'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(String value, String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [value, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when placeholder has type String, the same as gender variable',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'gender', {'type': 'String'}),
            Placeholder('labelName', 'value', {'type': 'String'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message {value}} female {female message {value}} other {other message {value}}}`',
            '  String labelName(String gender, String value) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message \$value\',',
            '      female: \'female message \$value\',',
            '      other: \'other message \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter when description contains a new line', () {
      var label = Label('labelName',
          '{gender, select, male {male message} female {female message} other {other message}}',
          description: 'Description with \n new line');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\n new line\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when description contains a single quotation mark',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message} female {female message} other {other message}}',
          description: 'Description with \' single quotation mark');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\' single quotation mark\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter when description contains a dollar sign', () {
      var label = Label('labelName',
          '{gender, select, male {male message} female {female message} other {other message}}',
          description: 'Description with \$ dollar sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\$ dollar sign\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a placeholder in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message with {name} placeholder} female {female message with {name} placeholder} other {other message with {name} placeholder}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message with {name} placeholder} female {female message with {name} placeholder} other {other message with {name} placeholder}}`',
            '  String labelName(String gender, Object name) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message with \$name placeholder\',',
            '      female: \'female message with \$name placeholder\',',
            '      other: \'other message with \$name placeholder\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains two placeholders set in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message with {firstName} {lastName} placeholders} female {female message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message with {firstName} {lastName} placeholders} female {female message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}`',
            '  String labelName(String gender, Object firstName, Object lastName) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message with \$firstName \$lastName placeholders\',',
            '      female: \'female message with \$firstName \$lastName placeholders\',',
            '      other: \'other message with \$firstName \$lastName placeholders\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, firstName, lastName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains a plural content set in all gender forms',
        () {
      var label = Label('labelName',
          '{gender, select, male {He has {apples, plural, one {one apple} other {{apples} apples}}} female {She has {apples, plural, one {one apple} other {{apples} apples}}} other {Person has {apples, plural, one {one apple} other {{apples} apples}}}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {He has {apples, plural, one {one apple} other {{apples} apples}}} female {She has {apples, plural, one {one apple} other {{apples} apples}}} other {Person has {apples, plural, one {one apple} other {{apples} apples}}}}`',
            '  String labelName(String gender, Object apples) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'He has {apples, plural, one {one apple} other {{apples} apples}}\',',
            '      female: \'She has {apples, plural, one {one apple} other {{apples} apples}}\',',
            '      other: \'Person has {apples, plural, one {one apple} other {{apples} apples}}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, apples],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test gender dart getter when content contains an additional gender form',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message} unsupportedGenderForm {unsupported gender form message} female {female message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} unsupportedGenderForm {unsupported gender form message} female {female message} other {other message}}`',
            '  String labelName(Object gender) {',
            '    return Intl.select(',
            '      gender,',
            '      {',
            '        \'male\': \'male message\',',
            '        \'unsupportedGenderForm\': \'unsupported gender form message\',',
            '        \'female\': \'female message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test gender dart getter when content contains a repeated gender form',
        () {
      var label = Label('labelName',
          '{gender, select, male {male message} male {repeated male message} female {female message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {male message} male {repeated male message} female {female message} other {other message}}`',
            '  String labelName(String gender) {',
            '    return Intl.gender(',
            '      gender,',
            '      male: \'male message\',',
            '      female: \'female message\',',
            '      other: \'other message\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Select getters', () {
    test('Test select dart getter with name and content set', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} bar {bar message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter with name, content and placeholders set', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} bar {bar message} other {other message}}',
          placeholders: [Placeholder('labelName', 'choice', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter with name, content and placeholders set when select cases are empty',
        () {
      var label = Label('labelName', '{choice, select, foo {} bar {} other {}}',
          placeholders: [Placeholder('labelName', 'choice', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {} bar {} other {}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'\',',
            '        \'bar\': \'\',',
            '        \'other\': \'\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: Tags are not supported in select messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test select dart getter when content contains a tag in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {<b>foo</b> message} bar {<b>bar</b> message} other {<b>other</b> message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {<b>foo</b> message} bar {<b>bar</b> message} other {<b>other</b> message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'<b>foo</b> message\',',
            '        \'bar\': \'<b>bar</b> message\',',
            '        \'other\': \'<b>other</b> message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    // Note: Less-than sign is not supported in select messages with the current parser implementation. Use compound messages as an alternative.
    test(
        'Test select dart getter when content contains a less-than sign in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with < sign} bar {bar message with < sign} other {other message with < sign}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with < sign} bar {bar message with < sign} other {other message with < sign}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with < sign\',',
            '        \'bar\': \'bar message with < sign\',',
            '        \'other\': \'other message with < sign\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test select dart getter when content contains a greater-than sign in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with > sign} bar {bar message with > sign} other {other message with > sign}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with > sign} bar {bar message with > sign} other {other message with > sign}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with > sign\',',
            '        \'bar\': \'bar message with > sign\',',
            '        \'other\': \'other message with > sign\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a backtick in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo `message`} bar {bar `message`} other {other `message`}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo \'message\'} bar {bar \'message\'} other {other \'message\'}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo `message`\',',
            '        \'bar\': \'bar `message`\',',
            '        \'other\': \'other `message`\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a new line in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo \n message} bar {bar \n message} other {other \n message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo \\n message} bar {bar \\n message} other {other \\n message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \\n message\',',
            '        \'bar\': \'bar \\n message\',',
            '        \'other\': \'other \\n message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a single quotation mark in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo \' message} bar {bar \' message} other {other \' message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo \' message} bar {bar \' message} other {other \' message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \\\' message\',',
            '        \'bar\': \'bar \\\' message\',',
            '        \'other\': \'other \\\' message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a dollar sign in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo \$ message} bar {bar \$ message} other {other \$ message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo \$ message} bar {bar \$ message} other {other \$ message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \\\$ message\',',
            '        \'bar\': \'bar \\\$ message\',',
            '        \'other\': \'other \\\$ message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder that is linked with text at the ending in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo {choice}abc} bar {bar {choice}abc} other {other {choice}abc}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo {choice}abc} bar {bar {choice}abc} other {other {choice}abc}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \${choice}abc\',',
            '        \'bar\': \'bar \${choice}abc\',',
            '        \'other\': \'other \${choice}abc\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder that is linked with underscore sign at the ending in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo {choice}_} bar {bar {choice}_} other {other {choice}_}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo {choice}_} bar {bar {choice}_} other {other {choice}_}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \${choice}_\',',
            '        \'bar\': \'bar \${choice}_\',',
            '        \'other\': \'other \${choice}_\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder that is linked with number at the ending in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo {choice}357 .} bar {bar {choice}357 .} other {other {choice}357 .}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo {choice}357 .} bar {bar {choice}357 .} other {other {choice}357 .}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo \${choice}357 .\',',
            '        \'bar\': \'bar \${choice}357 .\',',
            '        \'other\': \'other \${choice}357 .\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder that is linked with text at the beginning and at the ending in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo before{choice}after} bar {bar before{choice}after} other {other before{choice}after}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo before{choice}after} bar {bar before{choice}after} other {other before{choice}after}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo before\${choice}after\',',
            '        \'bar\': \'bar before\${choice}after\',',
            '        \'other\': \'other before\${choice}after\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: JSON strings are not supported in select messages with the current parser implementation.
    test('Test select dart getter when content contains a simple json string',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message { "firstName": "John", "lastName": "Doe" }} bar {bar message { "firstName": "John", "lastName": "Doe" }} other {other message { "firstName": "John", "lastName": "Doe" }}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message { "firstName": "John", "lastName": "Doe" }} bar {bar message { "firstName": "John", "lastName": "Doe" }} other {other message { "firstName": "John", "lastName": "Doe" }}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message { "firstName": "John", "lastName": "Doe" }\',',
            '        \'bar\': \'bar message { "firstName": "John", "lastName": "Doe" }\',',
            '        \'other\': \'other message { "firstName": "John", "lastName": "Doe" }\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test select dart getter when placeholder has type DateTime and format is not provided',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'DateTime'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format is blank string',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format is invalid',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format d',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.d(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format E',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'E'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.E(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format EEEE',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'EEEE'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.EEEE(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format LLL',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.LLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format LLLL',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.LLLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format M',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'M'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.M(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format Md',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Md'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Md(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMM',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMMd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMMEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMMM',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMMMd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format MMMMEEEEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'MMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format QQQ',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format QQQQ',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format y',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'y'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.y(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yM',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMM',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMMd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMMEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMMM',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMMMd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yMMMMEEEEd',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'yMMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yQQQ',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format yQQQQ',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format H',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'H'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.H(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format Hm',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Hm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format Hms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.Hms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format j',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'j'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.j(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jm',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jmv',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jmv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jmz',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jmz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jv',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format jz',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.jz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format m',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.m(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format ms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'ms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.ms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type DateTime and format s',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 's'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, DateTime value) {',
            '    final DateFormat valueDateFormat = DateFormat.s(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format is not provided',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format is blank string',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type int and format is invalid',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type int and format compact',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format compactCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format compactLong',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format currency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format decimalPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format percentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format scientificPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, int value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format is not provided',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format is blank string',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type double and format is invalid',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type double and format compact',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format compactCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format compactLong',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format currency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format decimalPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format percentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format scientificPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, double value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format is not provided',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format is blank string',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type num and format is invalid',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test select dart getter when placeholder has type num and format compact',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format compactCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format compactLong',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format currency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format decimalPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format percentPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format scientificPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num and format simpleCurrency',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, num value) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$valueString\',',
            '        \'bar\': \'bar message \$valueString\',',
            '        \'other\': \'other message \$valueString\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter when placeholder has type Object', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'Object'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, Object value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter when placeholder has type String', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'String'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, String value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when placeholder has type Object, the same as select variable',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}',
          placeholders: [
            Placeholder('labelName', 'choice', {'type': 'Object'}),
            Placeholder('labelName', 'value', {'type': 'Object'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message {value}} bar {bar message {value}} other {other message {value}}}`',
            '  String labelName(Object choice, Object value) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message \$value\',',
            '        \'bar\': \'bar message \$value\',',
            '        \'other\': \'other message \$value\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter when description contains a new line', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} bar {bar message} other {other message}}',
          description: 'Description with \n new line');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'Description with \\n new line\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when description contains a single quotation mark',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} bar {bar message} other {other message}}',
          description: 'Description with \' single quotation mark');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\' single quotation mark\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter when description contains a dollar sign', () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} bar {bar message} other {other message}}',
          description: 'Description with \$ dollar sign');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'Description with \\\$ dollar sign\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with {name} placeholder} bar {bar message with {name} placeholder} other {other message with {name} placeholder}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with {name} placeholder} bar {bar message with {name} placeholder} other {other message with {name} placeholder}}`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with \$name placeholder\',',
            '        \'bar\': \'bar message with \$name placeholder\',',
            '        \'other\': \'other message with \$name placeholder\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a placeholder in all select forms and reverse placeholders order',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with {name} placeholder} bar {bar message with {name} placeholder} other {other message with {name} placeholder}}',
          placeholders: [
            Placeholder('labelName', 'name', {}),
            Placeholder('labelName', 'choice', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with {name} placeholder} bar {bar message with {name} placeholder} other {other message with {name} placeholder}}`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with \$name placeholder\',',
            '        \'bar\': \'bar message with \$name placeholder\',',
            '        \'other\': \'other message with \$name placeholder\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains two placeholders in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with {firstName} {lastName} placeholders} bar {bar message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with {firstName} {lastName} placeholders} bar {bar message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}`',
            '  String labelName(Object choice, Object firstName, Object lastName) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with \$firstName \$lastName placeholders\',',
            '        \'bar\': \'bar message with \$firstName \$lastName placeholders\',',
            '        \'other\': \'other message with \$firstName \$lastName placeholders\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, firstName, lastName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains two placeholders in all select forms and reverse placeholders order',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message with {firstName} {lastName} placeholders} bar {bar message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}',
          placeholders: [
            Placeholder('labelName', 'lastName', {}),
            Placeholder('labelName', 'firstName', {}),
            Placeholder('labelName', 'choice', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message with {firstName} {lastName} placeholders} bar {bar message with {firstName} {lastName} placeholders} other {other message with {firstName} {lastName} placeholders}}`',
            '  String labelName(Object choice, Object lastName, Object firstName) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message with \$firstName \$lastName placeholders\',',
            '        \'bar\': \'bar message with \$firstName \$lastName placeholders\',',
            '        \'other\': \'other message with \$firstName \$lastName placeholders\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, lastName, firstName],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test select dart getter when content contains a plural content in all select forms',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo {apples, plural, one {one apple} other {{apples} apples}}} bar {bar {apples, plural, one {one apple} other {{apples} apples}}} other {other {apples, plural, one {one apple} other {{apples} apples}}}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo {apples, plural, one {one apple} other {{apples} apples}}} bar {bar {apples, plural, one {one apple} other {{apples} apples}}} other {other {apples, plural, one {one apple} other {{apples} apples}}}}`',
            '  String labelName(Object choice, Object apples) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo {apples, plural, one {one apple} other {{apples} apples}}\',',
            '        \'bar\': \'bar {apples, plural, one {one apple} other {{apples} apples}}\',',
            '        \'other\': \'other {apples, plural, one {one apple} other {{apples} apples}}\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, apples],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test('Test select dart getter when content contains a repeated select form',
        () {
      var label = Label('labelName',
          '{choice, select, foo {foo message} foo {repeated foo message} bar {bar message} other {other message}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {foo message} foo {repeated foo message} bar {bar message} other {other message}}`',
            '  String labelName(Object choice) {',
            '    return Intl.select(',
            '      choice,',
            '      {',
            '        \'foo\': \'foo message\',',
            '        \'bar\': \'bar message\',',
            '        \'other\': \'other message\',',
            '      },',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Compound getters', () {
    test(
        'Test compound message of literal and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          'John has {count, plural, one {{count} apple} other {{count} apples}}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `John has {count, plural, one {{count} apple} other {{count} apples}}.`',
            '  String labelName(num count) {',
            '    return Intl.message(',
            '      \'John has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and plural dart getter with name, content and placeholders set',
        () {
      var label = Label('labelName',
          'John has {count, plural, one {{count} apple} other {{count} apples}}.',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `John has {count, plural, one {{count} apple} other {{count} apples}}.`',
            '  String labelName(num count) {',
            '    return Intl.message(',
            '      \'John has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and plural dart getter with name, content and placeholders set when content contains a tag',
        () {
      var label = Label('labelName',
          '<b>John</b> has {count, plural, one {{count} apple} other {{count} apples}}.',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<b>John</b> has {count, plural, one {{count} apple} other {{count} apples}}.`',
            '  String labelName(num count) {',
            '    return Intl.message(',
            '      \'<b>John</b> has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and plural dart getter with name, content and placeholders set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p><b>John</b> has {count, plural, one {{count} apple} other {{count} apples}}.</p>',
          placeholders: [Placeholder('labelName', 'count', {})]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p><b>John</b> has {count, plural, one {{count} apple} other {{count} apples}}.</p>`',
            '  String labelName(num count) {',
            '    return Intl.message(',
            '      \'<p><b>John</b> has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          'Welcome {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Welcome {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}.`',
            '  String labelName(String gender, Object name) {',
            '    return Intl.message(',
            '      \'Welcome \${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and gender dart getter with name, content and placeholders set',
        () {
      var label = Label('labelName',
          'Welcome {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}.',
          placeholders: [
            Placeholder('labelName', 'gender', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Welcome {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}.`',
            '  String labelName(String gender, Object name) {',
            '    return Intl.message(',
            '      \'Welcome \${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and gender dart getter with name, content and placeholders set when content contains a tag',
        () {
      var label = Label('labelName',
          'Welcome <b>{gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}</b>.',
          placeholders: [
            Placeholder('labelName', 'gender', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `Welcome <b>{gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}</b>.`',
            '  String labelName(String gender, Object name) {',
            '    return Intl.message(',
            '      \'Welcome <b>\${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')}</b>.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and gender dart getter with name, content and placeholders set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p>Welcome <b>{gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}</b>.</p>',
          placeholders: [
            Placeholder('labelName', 'gender', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>Welcome <b>{gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}}</b>.</p>`',
            '  String labelName(String gender, Object name) {',
            '    return Intl.message(',
            '      \'<p>Welcome <b>\${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')}</b>.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          'The {choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}.`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.message(',
            '      \'The \${Intl.select(choice, {\'admin\': \'admin \$name\', \'owner\': \'owner \$name\', \'other\': \'user \$name\'})}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and select dart getter with name, content and placeholders set',
        () {
      var label = Label('labelName',
          'The {choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}.',
          placeholders: [
            Placeholder('labelName', 'choice', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}.`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.message(',
            '      \'The \${Intl.select(choice, {\'admin\': \'admin \$name\', \'owner\': \'owner \$name\', \'other\': \'user \$name\'})}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and select dart getter with name, content and placeholders set when content contains a tag',
        () {
      var label = Label('labelName',
          'The <b>{choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}</b>.',
          placeholders: [
            Placeholder('labelName', 'choice', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The <b>{choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}</b>.`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.message(',
            '      \'The <b>\${Intl.select(choice, {\'admin\': \'admin \$name\', \'owner\': \'owner \$name\', \'other\': \'user \$name\'})}</b>.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of literal and select dart getter with name, content and placeholders set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p>The <b>{choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}</b>.</p>',
          placeholders: [
            Placeholder('labelName', 'choice', {}),
            Placeholder('labelName', 'name', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>The <b>{choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}</b>.</p>`',
            '  String labelName(Object choice, Object name) {',
            '    return Intl.message(',
            '      \'<p>The <b>\${Intl.select(choice, {\'admin\': \'admin \$name\', \'owner\': \'owner \$name\', \'other\': \'user \$name\'})}</b>.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{name} has {count, plural, one {{count} apple} other {{count} apples}} in the bag.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{name} has {count, plural, one {{count} apple} other {{count} apples}} in the bag.`',
            '  String labelName(Object name, num count) {',
            '    return Intl.message(',
            '      \'\$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in the bag.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and plural dart getter with name and content set when content contains a tag',
        () {
      var label = Label('labelName',
          '<b>{name}</b> has {count, plural, one {{count} apple} other {{count} apples}} in the bag.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<b>{name}</b> has {count, plural, one {{count} apple} other {{count} apples}} in the bag.`',
            '  String labelName(Object name, num count) {',
            '    return Intl.message(',
            '      \'<b>\$name</b> has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in the bag.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and plural dart getter with name and content set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p><b>{name}</b> has {count, plural, one {{count} apple} other {{count} apples}} in the bag.</p>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p><b>{name}</b> has {count, plural, one {{count} apple} other {{count} apples}} in the bag.</p>`',
            '  String labelName(Object name, num count) {',
            '    return Intl.message(',
            '      \'<p><b>\$name</b> has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in the bag.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the {device}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the {device}.`',
            '  String labelName(String gender, Object name, Object device) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')} has the \$device.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name, device],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and gender dart getter with name and content set when content contains a tag',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the <b>{device}</b>.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the <b>{device}</b>.`',
            '  String labelName(String gender, Object name, Object device) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')} has the <b>\$device</b>.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name, device],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and gender dart getter with name and content set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p>The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the <b>{device}</b>.</p>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>The {gender, select, male {Mr {name}} female {Mrs {name}} other {dear {name}}} has the <b>{device}</b>.</p>`',
            '  String labelName(String gender, Object name, Object device) {',
            '    return Intl.message(',
            '      \'<p>The \${Intl.gender(gender, male: \'Mr \$name\', female: \'Mrs \$name\', other: \'dear \$name\')} has the <b>\$device</b>.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name, device],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          'The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the {client}.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the {client}.`',
            '  String labelName(Object choice, Object name, Object client) {',
            '    return Intl.message(',
            '      \'The one \${Intl.select(choice, {\'coffee\': \'\$name coffee\', \'tea\': \'\$name tea\', \'other\': \'\$name drink\'})} please for the \$client.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name, client],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and select dart getter with name and content set when content contains a tag',
        () {
      var label = Label('labelName',
          'The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the <b>{client}</b>.');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the <b>{client}</b>.`',
            '  String labelName(Object choice, Object name, Object client) {',
            '    return Intl.message(',
            '      \'The one \${Intl.select(choice, {\'coffee\': \'\$name coffee\', \'tea\': \'\$name tea\', \'other\': \'\$name drink\'})} please for the <b>\$client</b>.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name, client],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of argument and select dart getter with name and content set when content is wrapped with tag',
        () {
      var label = Label('labelName',
          '<p>The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the <b>{client}</b>.</p>');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `<p>The one {choice, select, coffee {{name} coffee} tea {{name} tea} other {{name} drink}} please for the <b>{client}</b>.</p>`',
            '  String labelName(Object choice, Object name, Object client) {',
            '    return Intl.message(',
            '      \'<p>The one \${Intl.select(choice, {\'coffee\': \'\$name coffee\', \'tea\': \'\$name tea\', \'other\': \'\$name drink\'})} please for the <b>\$client</b>.</p>\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, name, client],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count1, plural, one {p1 one} other {p1 other}}{count2, plural, one {p2 one} other {p2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count1, plural, one {p1 one} other {p1 other}}{count2, plural, one {p2 one} other {p2 other}}`',
            '  String labelName(num count1, num count2) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count1, one: \'p1 one\', other: \'p1 other\')}\${Intl.plural(count2, one: \'p2 one\', other: \'p2 other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count1, count2],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural, literal and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count1, plural, one {p1 one} other {p1 other}} and {count2, plural, one {p2 one} other {p2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count1, plural, one {p1 one} other {p1 other}} and {count2, plural, one {p2 one} other {p2 other}}`',
            '  String labelName(num count1, num count2) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count1, one: \'p1 one\', other: \'p1 other\')} and \${Intl.plural(count2, one: \'p2 one\', other: \'p2 other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count1, count2],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count, plural, one {p one} other {p other}}{gender, select, male {g male} female {g female} other {g other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {p one} other {p other}}{gender, select, male {g male} female {g female} other {g other}}`',
            '  String labelName(num count, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count, one: \'p one\', other: \'p other\')}\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural, literal and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count, plural, one {p one} other {p other}} and {gender, select, male {g male} female {g female} other {g other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {p one} other {p other}} and {gender, select, male {g male} female {g female} other {g other}}`',
            '  String labelName(num count, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count, one: \'p one\', other: \'p other\')} and \${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [count, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count, plural, one {p one} other {p other}}{choice, select, foo {s foo} bar {s bar} other {s other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {p one} other {p other}}{choice, select, foo {s foo} bar {s bar} other {s other}}`',
            '  String labelName(Object choice, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count, one: \'p one\', other: \'p other\')}\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of plural, literal and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{count, plural, one {p one} other {p other}} and {choice, select, foo {s foo} bar {s bar} other {s other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{count, plural, one {p one} other {p other}} and {choice, select, foo {s foo} bar {s bar} other {s other}}`',
            '  String labelName(Object choice, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.plural(count, one: \'p one\', other: \'p other\')} and \${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender1, select, male {g1 male} female {g1 female} other {g1 other}}{gender2, select, male {g2 male} female {g2 female} other {g2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender1, select, male {g1 male} female {g1 female} other {g1 other}}{gender2, select, male {g2 male} female {g2 female} other {g2 other}}`',
            '  String labelName(String gender1, String gender2) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender1, male: \'g1 male\', female: \'g1 female\', other: \'g1 other\')}\${Intl.gender(gender2, male: \'g2 male\', female: \'g2 female\', other: \'g2 other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender1, gender2],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender, literal and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender1, select, male {g1 male} female {g1 female} other {g1 other}} and {gender2, select, male {g2 male} female {g2 female} other {g2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender1, select, male {g1 male} female {g1 female} other {g1 other}} and {gender2, select, male {g2 male} female {g2 female} other {g2 other}}`',
            '  String labelName(String gender1, String gender2) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender1, male: \'g1 male\', female: \'g1 female\', other: \'g1 other\')} and \${Intl.gender(gender2, male: \'g2 male\', female: \'g2 female\', other: \'g2 other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender1, gender2],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender, select, male {g male} female {g female} other {g other}}{count, plural, one {p one} other {p other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {g male} female {g female} other {g other}}{count, plural, one {p one} other {p other}}`',
            '  String labelName(String gender, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\${Intl.plural(count, one: \'p one\', other: \'p other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender, literal and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender, select, male {g male} female {g female} other {g other}} and {count, plural, one {p one} other {p other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {g male} female {g female} other {g other}} and {count, plural, one {p one} other {p other}}`',
            '  String labelName(String gender, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')} and \${Intl.plural(count, one: \'p one\', other: \'p other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender, select, male {g male} female {g female} other {g other}}{choice, select, foo {s foo} bar {s bar} other {s other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {g male} female {g female} other {g other}}{choice, select, foo {s foo} bar {s bar} other {s other}}`',
            '  String labelName(Object choice, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of gender, literal and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{gender, select, male {g male} female {g female} other {g other}} and {choice, select, foo {s foo} bar {s bar} other {s other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {g male} female {g female} other {g other}} and {choice, select, foo {s foo} bar {s bar} other {s other}}`',
            '  String labelName(Object choice, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')} and \${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice1, select, foo {s1 foo} bar {s1 bar} other {s1 other}}{choice2, select, foo {s2 foo} bar {s2 bar} other {s2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice1, select, foo {s1 foo} bar {s1 bar} other {s1 other}}{choice2, select, foo {s2 foo} bar {s2 bar} other {s2 other}}`',
            '  String labelName(Object choice2, Object choice1) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice1, {\'foo\': \'s1 foo\', \'bar\': \'s1 bar\', \'other\': \'s1 other\'})}\${Intl.select(choice2, {\'foo\': \'s2 foo\', \'bar\': \'s2 bar\', \'other\': \'s2 other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice2, choice1],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select, literal and select dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice1, select, foo {s1 foo} bar {s1 bar} other {s1 other}} and {choice2, select, foo {s2 foo} bar {s2 bar} other {s2 other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice1, select, foo {s1 foo} bar {s1 bar} other {s1 other}} and {choice2, select, foo {s2 foo} bar {s2 bar} other {s2 other}}`',
            '  String labelName(Object choice2, Object choice1) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice1, {\'foo\': \'s1 foo\', \'bar\': \'s1 bar\', \'other\': \'s1 other\'})} and \${Intl.select(choice2, {\'foo\': \'s2 foo\', \'bar\': \'s2 bar\', \'other\': \'s2 other\'})}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice2, choice1],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice, select, foo {s foo} bar {s bar} other {s other}}{count, plural, one {p one} other {p other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {s foo} bar {s bar} other {s other}}{count, plural, one {p one} other {p other}}`',
            '  String labelName(Object choice, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\${Intl.plural(count, one: \'p one\', other: \'p other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select, literal and plural dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice, select, foo {s foo} bar {s bar} other {s other}} and {count, plural, one {p one} other {p other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {s foo} bar {s bar} other {s other}} and {count, plural, one {p one} other {p other}}`',
            '  String labelName(Object choice, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})} and \${Intl.plural(count, one: \'p one\', other: \'p other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice, select, foo {s foo} bar {s bar} other {s other}}{gender, select, male {g male} female {g female} other {g other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {s foo} bar {s bar} other {s other}}{gender, select, male {g male} female {g female} other {g other}}`',
            '  String labelName(Object choice, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})}\${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message of select, literal and gender dart getter with name and content set',
        () {
      var label = Label('labelName',
          '{choice, select, foo {s foo} bar {s bar} other {s other}} and {gender, select, male {g male} female {g female} other {g other}}');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{choice, select, foo {s foo} bar {s bar} other {s other}} and {gender, select, male {g male} female {g female} other {g other}}`',
            '  String labelName(Object choice, String gender) {',
            '    return Intl.message(',
            '      \'\${Intl.select(choice, {\'foo\': \'s foo\', \'bar\': \'s bar\', \'other\': \'s other\'})} and \${Intl.gender(gender, male: \'g male\', female: \'g female\', other: \'g other\')}\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, gender],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter with name, content and placeholders set when content contains a less-than sign',
        () {
      var label = Label('labelName',
          '{gender, select, male {Mr} female {Mrs} other {User}} {name} has < {count, plural, one {{count} apple} other {{count} apples}}.',
          placeholders: [
            Placeholder('labelName', 'gender', {}),
            Placeholder('labelName', 'name', {}),
            Placeholder('labelName', 'count', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {Mr} female {Mrs} other {User}} {name} has < {count, plural, one {{count} apple} other {{count} apples}}.`',
            '  String labelName(String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'User\')} \$name has < \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter with name, content and placeholders set when content contains a greater-than sign',
        () {
      var label = Label('labelName',
          '{gender, select, male {Mr} female {Mrs} other {User}} {name} has > {count, plural, one {{count} apple} other {{count} apples}}.',
          placeholders: [
            Placeholder('labelName', 'gender', {}),
            Placeholder('labelName', 'name', {}),
            Placeholder('labelName', 'count', {})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `{gender, select, male {Mr} female {Mrs} other {User}} {name} has > {count, plural, one {{count} apple} other {{count} apples}}.`',
            '  String labelName(String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'\${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'User\')} \$name has > \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')}.\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    // Note: JSON strings are not supported in compound messages with the current parser implementation.
    test(
        'Test compound message dart getter when content contains a simple json string',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {User}} {name} ({choice, select, ADMIN {Admin} MANAGER {Manager} other {User}} with {count, plural, one {{count} badge} other {{count} badges}}): { "firstName": "John", "lastName": "Doe" }');

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {User}} {name} ({choice, select, ADMIN {Admin} MANAGER {Manager} other {User}} with {count, plural, one {{count} badge} other {{count} badges}}): { "firstName": "John", "lastName": "Doe" }`',
            '  String labelName(Object choice, String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'User\')} \$name (\${Intl.select(choice, {\'ADMIN\': \'Admin\', \'MANAGER\': \'Manager\', \'other\': \'User\'})} with \${Intl.plural(count, one: \'\$count badge\', other: \'\$count badges\')}): { "firstName": "John", "lastName": "Doe" }\','
                '      name: \'labelName\',\n'
                '      desc: \'\',\n'
                '      args: [choice, gender, name, count],\n'
                '    );\n'
                '  }'
          ].join('\n')));
    }, skip: true);

    test(
        'Test compound message dart getter when placeholder has type DateTime and format is not provided',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'DateTime'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format is blank string',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format is invalid',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format d',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.d(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format E',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'E'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.E(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format EEEE',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'EEEE'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.EEEE(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format LLL',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.LLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format LLLL',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'LLLL'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.LLLL(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format M',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'M'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.M(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format Md',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Md'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Md(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMM',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMMd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMMEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMMM',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMMMd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'MMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format MMMMEEEEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'MMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.MMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format QQQ',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format QQQQ',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'QQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.QQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format y',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'y'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.y(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yM',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMM',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMMd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMMEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMMM',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMM'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMMMd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yMMMMd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yMMMMEEEEd',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'DateTime', 'format': 'yMMMMEEEEd'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yQQQ',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format yQQQQ',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'yQQQQ'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.yQQQQ(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format H',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'H'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.H(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format Hm',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Hm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format Hms',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'Hms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.Hms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format j',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'j'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.j(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jm',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jm(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jms',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jmv',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jmv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jmz',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jmz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jmz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jv',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jv'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jv(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format jz',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'jz'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.jz(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format m',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'm'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.m(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format ms',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 'ms'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.ms(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type DateTime and format s',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'DateTime', 'format': 's'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, DateTime value, String gender, Object name, num count) {',
            '    final DateFormat valueDateFormat = DateFormat.s(Intl.getCurrentLocale());',
            '    final String valueString = valueDateFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format is not provided',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format is blank string',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'int', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format is invalid',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format compact',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format compactCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format compactLong',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format currency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'int', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format decimalPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format percentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format scientificPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int and format simpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'int', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type int, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'int',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, int value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format is not provided',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format is blank string',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'double', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format is invalid',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format compact',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format compactCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format compactLong',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format currency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'double', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format decimalPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format percentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format scientificPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double and format simpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'double', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type double, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'double',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, double value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format is not provided',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$value\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, value, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format is blank string',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {'type': 'num', 'format': ' '})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format is invalid',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'invalid'})
          ]);

      expect(label.generateDartGetter(),
          equals('  // skipped getter for the \'labelName\' key'));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format compact',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compact'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compact(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format compactCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format compactSimpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'compactSimpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format compactLong',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'compactLong'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactLong(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format currency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder(
                'labelName', 'value', {'type': 'num', 'format': 'currency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format decimalPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format decimalPercentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'decimalPercentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format percentPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'percentPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format scientificPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'scientificPattern'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.scientificPattern(Intl.getCurrentLocale());',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num and format simpleCurrency',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value',
                {'type': 'num', 'format': 'simpleCurrency'})
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      ',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format compactCurrency, and optionalParameters contains name, symbol, and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactCurrency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format compactSimpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'compactSimpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.compactSimpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format currency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format currency, and optionalParameters contains name, symbol, decimalDigits, and customPattern',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'currency',
              'optionalParameters': {
                'name': 'EUR',
                'symbol': '€',
                'decimalDigits': 2,
                'customPattern': '\u00A4#,##0.00'
              }
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.currency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      symbol: \'€\',',
            '      decimalDigits: 2,',
            '      customPattern: \'\u00A4#,##0.00\'',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format decimalPercentPattern, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'decimalPercentPattern',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.decimalPercentPattern(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });

    test(
        'Test compound message dart getter when placeholder has type num, format simpleCurrency, and optionalParameters contains name and decimalDigits',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}',
          placeholders: [
            Placeholder('labelName', 'value', {
              'type': 'num',
              'format': 'simpleCurrency',
              'optionalParameters': {'name': 'EUR', 'decimalDigits': 2}
            })
          ]);

      expect(
          label.generateDartGetter(),
          equals([
            '  /// `The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}} in {choice, select, fridge {fridge} pocket {pocket} other {bag}} - {value}`',
            '  String labelName(Object choice, num value, String gender, Object name, num count) {',
            '    final NumberFormat valueNumberFormat = NumberFormat.simpleCurrency(',
            '      locale: Intl.getCurrentLocale(),',
            '      name: \'EUR\',',
            '      decimalDigits: 2',
            '    );',
            '    final String valueString = valueNumberFormat.format(value);',
            '',
            '    return Intl.message(',
            '      \'The \${Intl.gender(gender, male: \'Mr\', female: \'Mrs\', other: \'user\')} \$name has \${Intl.plural(count, one: \'\$count apple\', other: \'\$count apples\')} in \${Intl.select(choice, {\'fridge\': \'fridge\', \'pocket\': \'pocket\', \'other\': \'bag\'})} - \$valueString\',',
            '      name: \'labelName\',',
            '      desc: \'\',',
            '      args: [choice, valueString, gender, name, count],',
            '    );',
            '  }'
          ].join('\n')));
    });
  });

  group('Label metadata', () {
    test('Test label metadata generator when label name is invalid', () {
      var label = Label('Invalid label name', 'Some content');

      expect(
        label.generateMetadata(),
        equals('    // skipped metadata for the \'Invalid label name\' key'),
      );
    });

    test('Test label metadata generator when label content is empty', () {
      var label = Label('labelName', '');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': []'),
      );
    });

    test(
        'Test label metadata generator when label content contains empty curly braces pair',
        () {
      var label = Label('labelName', '{}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': []'),
      );
    });

    test(
        'Test label metadata generator when label content contains number within curly braces',
        () {
      var label = Label('labelName', '{0}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': []'),
      );
    });

    test(
        'Test label metadata generator when label content contains hash within curly braces',
        () {
      var label = Label('labelName', '{#}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': []'),
      );
    });

    test(
        'Test label metadata generator when label content contains valid placeholder',
        () {
      var label = Label('labelName', '{name}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'name\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains few valid placeholders',
        () {
      var label = Label('labelName', 'Hi {firstName} {lastName}!');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'firstName\', \'lastName\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains plural message',
        () {
      var label = Label('labelName',
          '{count, plural, one {{count} item} other {{count} items}}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'count\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains gender message',
        () {
      var label = Label('labelName',
          '{gender, select, male {Mr {name}} female {Mrs {name}} other {user {name}}}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'gender\', \'name\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains select message',
        () {
      var label = Label('labelName',
          '{choice, select, admin {admin {name}} owner {owner {name}} other {user {name}}}');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'choice\', \'name\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains compound message',
        () {
      var label = Label('labelName',
          'The {gender, select, male {Mr} female {Mrs} other {user}} {name} has {count, plural, one {{count} apple} other {{count} apples}}.');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'gender\', \'name\', \'count\']'),
      );
    });

    test(
        'Test label metadata generator when label content contains invalid placeholder name',
        () {
      var label = Label('labelName', 'Hi {invalid-placeholder}!');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': []'),
      );
    });

    test(
        'Test label metadata generator when label content contains invalid placeholder declaration',
        () {
      var label = Label('labelName', 'Hi {{year}}!');

      expect(
        label.generateMetadata(),
        equals('    \'labelName\': [\'year\']'),
      );
    });
  });
}
