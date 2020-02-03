import 'dart:convert';
import 'dart:io';
import "package:path/path.dart";

Map<String, dynamic> jsonFromFixture(String name) {
  var scriptPath = dirname(Platform.script.path).replaceAll('test','');
  return json.decode(File(join(scriptPath, 'test/fixtures/$name'))
        .readAsStringSync());
}
