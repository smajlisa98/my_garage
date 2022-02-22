import 'package:flutter/material.dart';
import 'package:my_garage/models/emission_type.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/models/vehicle_registration.dart';
import 'package:my_garage/models/vehicle_type.dart';
import 'package:my_garage/pages/add_vehicle/add_vehicle_page.dart';
import 'package:my_garage/pages/garage/ui/garage_list_item.dart';
import 'package:my_garage/repository/vehicle_repository.dart';
import 'package:uuid/uuid.dart';

class GaragePage extends StatefulWidget {
  const GaragePage({Key? key}) : super(key: key);

  @override
  State<GaragePage> createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  late List<Vehicle> vehicles;

  @override
  void initState() {
    super.initState();

    vehicles = VehicleRepository().getInitialVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('My Garage'),
      ),
      body: ListView(
        children: [
          for (final vehicle in vehicles)
            GarageListItem(
              vehicle: vehicle,
              onDelete: () => _onVehicleDeleted(vehicle),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final vehicle = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddVehiclePage()),
          );

          if (vehicle != null) {
            _onVehicleAdded(vehicle);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onVehicleDeleted(Vehicle vehicle) {
    setState(() {
      vehicles.remove(vehicle);
    });
  }

  void _onVehicleAdded(Vehicle vehicle) {
    setState(() {
      vehicles.insert(0, vehicle);
    });
  }
}
