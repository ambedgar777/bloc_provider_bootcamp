part of 'counter_cubit.dart';

//this class will be the blue print of all the possible states which will be imitated by the cubit//

class CounterState {
  int counterValue;
  bool? wasIncremented;

  CounterState({required this.counterValue, this.wasIncremented});

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CounterState(counterValue: 0);

    return CounterState(
        counterValue: map['counterValue'],
        wasIncremented: map['wasIncremented']);
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() =>
      'CounterState (counterValue: $counterValue, wasIncremented: $wasIncremented)';
}
