import 'package:get_it/get_it.dart';
import 'package:vehicle_monitoring/data/repository/vehicle_repo.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehicle_bloc.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  sl.registerFactory<VehicleBloc>(() => VehicleBloc(sl()));
  sl.registerFactory<VehicleRepo>(() => VehicleRepo());
}
