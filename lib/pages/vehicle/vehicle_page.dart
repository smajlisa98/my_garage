import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_garage/models/vehicle.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({required this.vehicle, required this.onDelete, Key? key}) : super(key: key);

  final Vehicle vehicle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: vehicle.color,
        title: Text(vehicle.model),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: vehicle.imageUrl,
                    width: 256,
                  ),
                  const Divider(
                    height: 32,
                    indent: 32,
                    endIndent: 32,
                    thickness: 1.5,
                  ),
                  Column(
                    children: [
                      Text(
                        vehicle.brand + " - " + vehicle.model,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        vehicle.registration.registration,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "General information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.airport_shuttle,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Vehicle type"),
                  subtitle: Text(vehicle.type.name),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.event_seat,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Seat count"),
                  subtitle: Text(vehicle.seatCount.toString()),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.add_road,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Mileage"),
                  subtitle: Text('${vehicle.kilometersDriven.toString()} km'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.cake,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Production date"),
                  subtitle: Text(DateFormat("dd/MM/yy").format(vehicle.productionDate)),
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Technical information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.air,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Emission type"),
                  subtitle: Text(vehicle.emissionType.name),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.power,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Power"),
                  subtitle: Text('${vehicle.power} kW'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Automatic transmission"),
                  subtitle: Text(vehicle.isAutomatic ? 'YES' : 'NO'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.local_gas_station,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Fuel consumption (l/100km)"),
                  subtitle: Text('${vehicle.fuelConsumption ?? 'N/A'}'),
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Registration information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.directions_car,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Vehicle registration"),
                  subtitle: Text(vehicle.registration.registration),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Registration start"),
                  subtitle: Text(DateFormat("dd/MM/yy").format(vehicle.registration.start)),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    size: 38,
                    color: vehicle.color,
                  ),
                  title: const Text("Registration end"),
                  subtitle: Text(DateFormat("dd/MM/yy").format(vehicle.registration.end)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MaterialButton(
              elevation: 6,
              height: 48,
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
              child: const Text(
                'DELETE VEHICLE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
