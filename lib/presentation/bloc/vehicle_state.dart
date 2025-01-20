import 'package:equatable/equatable.dart';
import 'package:vehicle_monitoring/data/model/vehicle_info.dart';

class VehicleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends VehicleState {}

class LoadingState extends VehicleState {
  @override
  List<Object> get props => [];
}

class LoadedTrackState extends VehicleState {
  final VehicleInfo? vehicle;
  LoadedTrackState(this.vehicle);
  @override
  List<Object> get props => [vehicle!];
}

class ErrorState extends VehicleState {
  final String message;

  ErrorState({required this.message});
  List<Object> get props => [message];
}
