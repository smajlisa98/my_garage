class VehicleRegistration {

  const VehicleRegistration({
    required this.registration,
    required this.start,
    required this.end,
    required this.vehicleId,
  });

  final String registration;

  final DateTime start;
  final DateTime end;

  final String vehicleId;
}
