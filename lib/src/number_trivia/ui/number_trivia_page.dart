import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_experiments/src/dependency_injection.dart';
import 'package:flutter_experiments/src/number_trivia/domain/bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }

  // A [BlocProvider] is a provider of [Widgets] that get their data from BLoCs.
  // It is itself a [Widget]
  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final widthInset =
        screenSize.width < 740 ? 20 : (screenSize.width - 700) / 2;

    return BlocProvider(
      builder: (_) => injector<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: widthInset),
          child: Column(children: <Widget>[
            SizedBox(height: 10),
            // Top half
            Container(
              // Third of the size of the screen
              height: screenSize.height / 3,
              child: StatusDisplay(),
            ),
            SizedBox(height: 20),
            // Bottom half
            Column(children: <Widget>[
              // TextField
              Placeholder(fallbackHeight: 40),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(
                  // Search concrete button
                  child: Placeholder(fallbackHeight: 30),
                )
              ])
            ])
          ]),
        ),
      ),
    );
  }
}

class StatusDisplay extends BlocBuilder<NumberTriviaBloc, NumberTriviaState> {
  StatusDisplay()
      : super(builder: (context, state) {
          if (state is Empty) {
            return MessageDisplay(message: 'Start searching!');
          } else {
            return Placeholder();
          }
          // We're going to also check for the other states
        });
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
