import 'package:bloc_provider_bootcamp/constants/enums.dart';
import 'package:bloc_provider_bootcamp/logic/cubit/counter_cubit.dart';
import 'package:bloc_provider_bootcamp/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'WIFI',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.green),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'MOBILE',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.red),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'DISCONNECTED',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.teal),
                  );
                }
                return const CircularProgressIndicator();
              }),
              const SizedBox(height: 20),
              const Text(
                'You have pushed the button this many times:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Builder(builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'counter: ${counterState.counterValue} Internet: Mobile',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'counter: ${counterState.counterValue} Internet: Wifi',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                } else {
                  return Text(
                    'counter: ${counterState.counterValue} Internet: Disconnected',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'Btn 1',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: 'Btn 2',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: const Text('Go to Second Screen'),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: const Text('Go to Third Screen'),
              ),
              const SizedBox(height: 20),
              // const Text(
              //   'Counter Value',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blueAccent,
                        duration: const Duration(milliseconds: 700),
                        content: Text(
                          'Incremented: ${state.counterValue}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: widget.color,
                        duration: const Duration(milliseconds: 200),
                        content: Text(
                          'Decremented: ${state.counterValue}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRRR Negative value${state.counterValue}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAYYYY${state.counterValue}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMMM value is = ${state.counterValue}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
