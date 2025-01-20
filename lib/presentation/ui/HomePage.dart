import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_monitoring/data/model/vehicle_info.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehicle_state.dart';
import 'package:vehicle_monitoring/presentation/bloc/vehucle_event.dart';
import 'package:vehicle_monitoring/presentation/ui/widgets/title_description_row.dart';
import 'package:vehicle_monitoring/utils/constants.dart';
import 'package:vehicle_monitoring/utils/local_storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String?> documentId;

  @override
  void initState() {
    context.read<VehicleBloc>().add(LoadVehicle());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vehicle Monitoring"),
        centerTitle: true,
      ),
      body:
          // FutureBuilder<String?>(
          //   future: documentId,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }

          // final docId = snapshot.data;
          // if (docId == null) {
          //   return ;
          // }

          //   Column(
          // children: [
          BlocBuilder<VehicleBloc, VehicleState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedTrackState) {
            if (state.vehicle == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No vehicle found. Please add your vehicle.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _showAddVehicleDialog(context);
                      },
                      child: const Text("Add Vehicle"),
                    ),
                  ],
                ),
              );
            } else {
              final vehicle = state.vehicle!;
              return _buildVehicleInfo(context, vehicle);
            }
          } else if (state is ErrorState) {
            return Center(
              child: Text("Error: ${state.message}"),
            );
          }

          return const Center(
            child: Text("Unknown state. Please try again later."),
          );
        },
      ),
      //   ],
      // )
      // },
      // ),
    );
  }

  // Future<String?> _checkVehicleAdded() async {
  //   final localStorageService = await LocalStorageService.getInstance();
  //   return localStorageService.getStringFromDisk(DOCUMENT_ID);
  // }

  Widget _buildVehicleInfo(BuildContext context, VehicleInfo vehicle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/image/vehicle_illustration.png",
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Vehicle Info",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700)),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  _showEditVehicleDialog(context, vehicle);
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          TitledescriptionRow(title: "Name", description: vehicle.name!),
          const SizedBox(height: 10),
          TitledescriptionRow(
              title: "Location", description: vehicle.lastLocation!),
          const SizedBox(height: 10),
          TitledescriptionRow(
              title: "Mileage", description: "${vehicle.mileAge!}%"),
          const SizedBox(height: 10),
          TitledescriptionRow(
              title: "Fuel Level", description: "${vehicle.fuelLevel!}%"),
          const SizedBox(height: 10),
          TitledescriptionRow(
              title: "Battery Level", description: "${vehicle.batteryLevel}%"),
        ],
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context) {
    _showVehicleDialog(
      context,
      onSave: (vehicleInfo) {
        context.read<VehicleBloc>().add(AddVehicle(vehicleInfo: vehicleInfo));
      },
    );
  }

  void _showEditVehicleDialog(BuildContext context, VehicleInfo vehicle) {
    _showVehicleDialog(
      context,
      vehicle: vehicle,
      onSave: (updatedVehicleInfo) {
        context
            .read<VehicleBloc>()
            .add(UpdateVehicle(vehicleInfo: updatedVehicleInfo));
      },
    );
  }

  void _showVehicleDialog(BuildContext context,
      {VehicleInfo? vehicle, required Function(VehicleInfo) onSave}) {
    final nameController = TextEditingController(text: vehicle?.name);
    final locationController =
        TextEditingController(text: vehicle?.lastLocation);
    final mileageController =
        TextEditingController(text: vehicle?.mileAge?.toString());
    final fuelController =
        TextEditingController(text: vehicle?.fuelLevel?.toString());
    final batteryController =
        TextEditingController(text: vehicle?.batteryLevel?.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vehicle == null ? "Add Vehicle" : "Edit Vehicle"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Last Location"),
                ),
                TextField(
                  controller: mileageController,
                  decoration: const InputDecoration(labelText: "Mileage (km)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: fuelController,
                  decoration:
                      const InputDecoration(labelText: "Fuel Level (%)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: batteryController,
                  decoration:
                      const InputDecoration(labelText: "Battery Level (%)"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newVehicle = VehicleInfo(
                  name: nameController.text,
                  lastLocation: locationController.text,
                  mileAge: double.tryParse(mileageController.text) ?? 0,
                  fuelLevel: double.tryParse(fuelController.text) ?? 0,
                  batteryLevel: double.tryParse(batteryController.text) ?? 0,
                );
                onSave(newVehicle);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
