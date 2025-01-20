import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_monitoring/data/model/vehicle_info.dart';
import 'package:vehicle_monitoring/utils/constants.dart';
import 'package:vehicle_monitoring/utils/local_storage_service.dart';

class VehicleRepo {
  Future getMyVehicle() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    var docId = await localStorageService.getStringFromDisk(DOCUMENT_ID);

    var vehicleData = await FirebaseFirestore.instance
        .collection("vehicles")
        .doc(docId)
        .get();

    VehicleInfo? vehicleInfo = vehicleData.data() != null
        ? VehicleInfo.fromJson(vehicleData.data()!)
        : null;

    return vehicleInfo;
  }

  Future updateVehicle(VehicleInfo vehicleInfo) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    var docId = await localStorageService.getStringFromDisk(DOCUMENT_ID);

    await FirebaseFirestore.instance.collection("vehicles").doc(docId).update({
      "name": vehicleInfo.name,
      "lastLocation": vehicleInfo.lastLocation,
      "batteryLevel": vehicleInfo.batteryLevel,
      "fuelLevel": vehicleInfo.fuelLevel,
      "mileAge": vehicleInfo.mileAge
    });

    var vehicleData = await FirebaseFirestore.instance
        .collection("vehicles")
        .doc(docId)
        .get();

    VehicleInfo? vehicle = vehicleData.data() != null
        ? VehicleInfo.fromJson(vehicleData.data()!)
        : null;

    return vehicle;
  }

  Future addVehicle(VehicleInfo vehicleInfo) async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();

    await FirebaseFirestore.instance.collection("vehicles").doc(docId).set({
      "name": vehicleInfo.name,
      "lastLocation": vehicleInfo.lastLocation,
      "batteryLevel": vehicleInfo.batteryLevel,
      "fuelLevel": vehicleInfo.fuelLevel,
      "mileAge": vehicleInfo.mileAge
    });

    var vehicleData = await FirebaseFirestore.instance
        .collection("vehicles")
        .doc(docId)
        .get();

    VehicleInfo? vehicle = vehicleData.data() != null
        ? VehicleInfo.fromJson(vehicleData.data()!)
        : null;

    if (vehicle != null) {
      LocalStorageService localStorageService =
          await LocalStorageService.getInstance();
      localStorageService.saveStringToDisk(DOCUMENT_ID, docId);
    }

    return vehicle;
  }
}
