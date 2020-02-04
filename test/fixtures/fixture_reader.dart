import 'dart:convert';
import 'dart:io';

import "package:path/path.dart";

Map<String, dynamic> jsonFromFixture(String name) {
  return json.decode(stringFromFixture(name));
}

String stringFromFixture(String name) {
  var scriptPath = dirname(Platform.script.path).replaceAll('test','');
  return File(join(scriptPath, 'test/fixtures/$name'))
      .readAsStringSync();
}
