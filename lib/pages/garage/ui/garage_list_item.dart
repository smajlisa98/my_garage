import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/pages/vehicle/vehicle_page.dart';

class GarageListItem extends StatelessWidget {
  const GarageListItem({required this.vehicle, required this.onDelete, Key? key}) : super(key: key);

  final Vehicle vehicle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VehiclePage(
            vehicle: vehicle,
            onDelete: onDelete,
          ),
        ));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.brand,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    vehicle.model,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        vehicle.registration.registration,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: vehicle.color, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CachedNetworkImage(
                  imageUrl: vehicle.imageUrl,
                  width: 160,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
