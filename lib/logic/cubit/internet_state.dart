part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;
  InternetConnected({required this.connectionType});

  String toString() {
    print('InternetConnected(connectionType : $connectionType)');
    return super.toString();
  }
}

class InternetDisconnected extends InternetState {}
