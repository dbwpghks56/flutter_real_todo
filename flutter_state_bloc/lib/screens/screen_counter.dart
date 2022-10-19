import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_bloc/blocs/counter/counter_bloc.dart';

class ScreenCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Screen"),
      ),
      body: BlocBuilder<CounterBloc, CounterState> (
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Count : " + state.count.toString()),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).add(CounterIncrement());
                    },
                    child: const Text("[+] increment")),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).add(CounterDecrement());
                    },
                    child: const Text("[-] decrement")),
              ],
            ),
          );
        },
      ),
    );
  }
}
