import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props {
    return [];
  }
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int numActive;
  final int numCompleted;

  const StatsLoaded(this.numActive, this.numCompleted);

  @override
  List<Object> get props {
    return [numActive, numCompleted];
  }

  @override
  String toString() {
    return 'StateLoaded{numActive: $numActive, numCompleted: $numCompleted}';
  }
}
