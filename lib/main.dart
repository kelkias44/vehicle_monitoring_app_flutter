import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_monitoring/firebase_options.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehucle_event.dart';
import 'package:vehicle_monitoring/presentation/ui/HomePage.dart';
import 'package:vehicle_monitoring/service_locator.dart';
import 'package:vehicle_monitoring/utils/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await serviceLocatorInit();
  await LocalStorageService.getInstance();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<VehicleBloc>()..add(LoadVehicle())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
