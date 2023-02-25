import 'package:bloc_provider_bootcamp/logic/cubit/counter_cubit.dart';
import 'package:bloc_provider_bootcamp/logic/cubit/internet_cubit.dart';
import 'package:bloc_provider_bootcamp/logic/cubit/settings_cubit.dart';
import 'package:bloc_provider_bootcamp/logic/utility/app_bloc_observer.dart';
import 'package:bloc_provider_bootcamp/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  final CounterState counterState1 = CounterState(counterValue: 1);
  final CounterState counterState2 = CounterState(counterValue: 1);
  //This should return true!
  print(counterState1 == counterState2);
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  Bloc.observer = AppBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({super.key, required this.appRouter, required this.connectivity});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (counterCubitContext) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          lazy: false,
          create: (settingsCubitContext) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Demo',
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
