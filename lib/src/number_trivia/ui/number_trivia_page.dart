import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_experiments/src/dependency_injection.dart';
import 'package:flutter_experiments/src/number_trivia/domain/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/ui/widgets/widgets.dart';

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
    final double widthInset =
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
              child: Center(
                child: StatusDisplay(),
              ),
            ),
            SizedBox(height: 20),
            // Bottom half
            TriviaControls(),
          ]),
        ),
      ),
    );
  }
}

class StatusDisplay extends BlocBuilder<NumberTriviaBloc, NumberTriviaState> {
  StatusDisplay()
      : super(builder: (context, numberTriviaState) {
          if (numberTriviaState is Empty) {
            return MessageDisplay(message: 'Start searching!');
          }
          if (numberTriviaState is Loading) {
            return CircularProgressIndicator();
          }
          if (numberTriviaState is Loaded) {
            return TriviaDisplay(trivia: numberTriviaState.trivia);
          }
          if (numberTriviaState is Error) {
            return MessageDisplay(message: numberTriviaState.message);
          }
          return MessageDisplay(message: 'Unknown State. You\'re on your own now.');
        });
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // TextField
      buildTextField(),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
          // Search concrete button
          child: buildSearchButton(),
        )
      ])
    ]);
  }

  Widget buildTextField() {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input a number',
      ),
      onChanged: (value) {
        inputStr = value;
      },
      onSubmitted: (_) {
        dispatchConcrete();
      },
    );
  }

  Widget buildSearchButton() {
    return RaisedButton(
      child: Text('Search'),
      color: Theme.of(context).accentColor,
      textTheme: ButtonTextTheme.primary,
      onPressed: dispatchConcrete,
    );
  }

  void dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputStr));
  }
}