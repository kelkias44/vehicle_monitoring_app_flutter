import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_monitoring/data/repository/vehicle_repo.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehicle_state.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehucle_event.dart';
import 'package:vehicle_monitoring/utils/constants.dart';
import 'package:vehicle_monitoring/utils/local_storage_service.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepo vehicleRepository;

  // VehicleBloc(this.vehicleRepository) : super(InitialState());

  VehicleBloc(this.vehicleRepository) : super(InitialState()) {
    on<LoadVehicle>(_onFetchVehicle);
    on<UpdateVehicle>(_onUpdateVehicle);
    on<AddVehicle>(_onAddVehicle);
  }

  Future<void> _onFetchVehicle(
      LoadVehicle event, Emitter<VehicleState> emit) async {
    emit(LoadingState());
    try {
      String? documentId =
          await LocalStorageService.instance?.getStringFromDisk(DOCUMENT_ID);
      var vehicle =
          documentId != null ? await vehicleRepository.getMyVehicle() : null;
      emit(LoadedTrackState(vehicle));
    } catch (e) {
      emit(ErrorState(message: 'Failed to fetch vehicle data.'));
    }
  }

  Future<void> _onUpdateVehicle(
      UpdateVehicle event, Emitter<VehicleState> emit) async {
    emit(LoadingState());
    try {
      var vehicle = await vehicleRepository.updateVehicle(event.vehicleInfo);
      emit(LoadedTrackState(vehicle));
    } catch (e) {
      emit(ErrorState(message: 'Failed to update vehicle data.'));
    }
  }

  Future<void> _onAddVehicle(
      AddVehicle event, Emitter<VehicleState> emit) async {
    emit(LoadingState());
    try {
      var vehicle = await vehicleRepository.addVehicle(event.vehicleInfo);
      emit(LoadedTrackState(vehicle));
    } catch (e) {
      emit(
          ErrorState(message: 'Failed to add vehicle data.\n ${e.toString()}'));
    }
  }
}
