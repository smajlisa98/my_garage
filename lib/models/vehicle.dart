import 'package:flutter/material.dart';
import 'package:my_garage/models/emission_type.dart';
import 'package:my_garage/models/vehicle_registration.dart';
import 'package:my_garage/models/vehicle_type.dart';
import 'package:uuid/uuid.dart';

class Vehicle {
  const Vehicle({
    required this.id,
    required this.seatCount,
    required this.kilometersDriven,
    required this.brand,
    required this.model,
    required this.imageUrl,
    required this.color,
    required this.registration,
    required this.type,
    required this.emissionType,
    required this.isAutomatic,
    required this.power,
    required this.productionDate,
    this.fuelConsumption,
  });

  final int seatCount;
  final int kilometersDriven;
  final int power;

  final String id;
  final String brand;
  final String model;
  final String imageUrl;

  final Color color;

  final bool isAutomatic;

  final VehicleRegistration registration;

  final VehicleType type;
  final EmissionType emissionType;

  final DateTime productionDate;

  final double? fuelConsumption;
}
