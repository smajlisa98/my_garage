import 'package:flutter/material.dart';
import 'package:my_garage/models/emission_type.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/models/vehicle_registration.dart';
import 'package:my_garage/models/vehicle_type.dart';
import 'package:uuid/uuid.dart';

class VehicleRepository {
  static final VehicleRepository _singleton = VehicleRepository._internal();

  factory VehicleRepository() {
    return _singleton;
  }

  VehicleRepository._internal();

  List<Vehicle> getInitialVehicles() {
    final vehicleId1 = const Uuid().v1();
    final vehicleId2 = const Uuid().v1();

    return [
      Vehicle(
          id: vehicleId1,
          seatCount: 4,
          kilometersDriven: 1250,
          brand: 'Mercedes',
          model: 'GLA',
          imageUrl:
              'https://www.mercedes-benz.co.uk/passengercars/mercedes-benz-cars/models/gla/gla-h247/specifications/model-lines/_jcr_content/swipeableteaserbox/par/swipeableteaser/asset.MQ6.12.20200226155615.png',
          color: Colors.grey,
          registration: VehicleRegistration(
              registration: 'BG-1234-AB',
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 365)),
              vehicleId: vehicleId1),
          type: VehicleType.suv,
          emissionType: EmissionType.gasoline,
          isAutomatic: true,
          power: 117,
          productionDate: DateTime(2020, 10, 3),
          fuelConsumption: 6.1),
      Vehicle(
          id: vehicleId2,
          seatCount: 2,
          kilometersDriven: 75000,
          brand: 'Opel',
          model: 'Cascada',
          imageUrl: 'https://www.automanijak.com/resources/images/variant/1376/cascada_1.jpg',
          color: Colors.orange,
          registration: VehicleRegistration(
              registration: 'NS-972-CD',
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 365)),
              vehicleId: vehicleId2),
          type: VehicleType.convertible,
          emissionType: EmissionType.diesel,
          isAutomatic: false,
          power: 130,
          productionDate: DateTime(2017, 5, 26),
          fuelConsumption: 8.3),
    ];
  }
}
