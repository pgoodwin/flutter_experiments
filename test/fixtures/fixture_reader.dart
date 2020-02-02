import 'dart:convert';
import 'dart:io';

Map<String, dynamic> jsonFromFixture(String name) =>
    json.decode(File('test/fixtures/$name').readAsStringSync());
