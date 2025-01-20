class VehicleInfo {
  VehicleInfo(
      {this.name,
      this.batteryLevel,
      this.fuelLevel,
      this.lastLocation,
      this.mileAge});
  String? name;
  String? lastLocation;
  double? mileAge;
  double? fuelLevel;
  double? batteryLevel;

  factory VehicleInfo.fromJson(Map<String, dynamic> json) => VehicleInfo(
      name: json["name"],
      lastLocation: json['lastLocation'],
      mileAge: json['mileAge'],
      fuelLevel: json['fuelLevel'],
      batteryLevel: json['batteryLevel']);
  Map<String, dynamic> toJson(VehicleInfo vehicleInfo) => {
        "name": vehicleInfo.name,
        "lastLocation": vehicleInfo.lastLocation,
        "mileAge": vehicleInfo.mileAge,
        "fuelLevel": vehicleInfo.fuelLevel,
        "batteryLevel": vehicleInfo.batteryLevel
      };
}
