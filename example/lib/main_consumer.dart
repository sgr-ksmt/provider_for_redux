import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_for_redux/provider_for_redux.dart';

import 'actions.dart';
import 'app_state.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/provider_for_redux

Store<AppState> store;

/// This example shows how to use `Consumer` to access the Redux store.
///
void main() {
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AsyncReduxProvider<AppState>.value(
        value: store,
        child: MaterialApp(home: MyHomePage()),
      );
}

///////////////////////////////////////////////////////////////////////////////

/// The screen has a counter, a text description, and a button.
/// When the button is tapped, the counter will increment synchronously,
/// while an async process downloads some text description.
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Consumer<Store<AppState>>(
        //
        builder: (ctx, store, child) => Scaffold(
            appBar: AppBar(title: Text('Increment Example (2)')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You've pushed the button:"),
                  Text('${store.state.counter}', style: TextStyle(fontSize: 30)),
                  Text('${store.state.description}', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => store.dispatch(IncrementAndGetDescriptionAction()),
              child: Icon(Icons.add),
            )));
  }
}
