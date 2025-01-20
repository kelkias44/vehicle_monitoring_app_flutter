import 'package:equatable/equatable.dart';
import 'package:vehicle_monitoring/data/model/vehicle_info.dart';

class VehicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialVehicle extends VehicleEvent {
  @override
  List<Object> get props => [];
}

class LoadVehicle extends VehicleEvent {

  @override
  List<Object> get props => [];
}

class AddVehicle extends VehicleEvent {
  VehicleInfo vehicleInfo;
  AddVehicle({required this.vehicleInfo});

  @override
  List<Object> get props => [vehicleInfo];
}

class UpdateVehicle extends VehicleEvent {
  VehicleInfo vehicleInfo;
  UpdateVehicle({required this.vehicleInfo});

  @override
  List<Object> get props => [vehicleInfo];
}
