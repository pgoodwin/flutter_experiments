import 'package:flutter/material.dart';
import 'package:flutter_experiments/src/dependency_injection.dart'
    as DependencyInjection;
import 'package:flutter_experiments/src/number_trivia/ui/number_trivia_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
