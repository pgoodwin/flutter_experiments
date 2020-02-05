import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_experiments/src/dependency_injection.dart' as DI;
import 'package:flutter_experiments/src/number_trivia/domain/bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: BlocProvider(
        builder: (_) => DI.injector.get<NumberTriviaBloc>(),
        child: Container(),
      ),
    );
  }
}
