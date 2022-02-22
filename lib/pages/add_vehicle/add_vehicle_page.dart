import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_garage/models/emission_type.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/models/vehicle_registration.dart';
import 'package:my_garage/models/vehicle_type.dart';
import 'package:uuid/uuid.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _brandController, _modelController, _imageUrlController, _productionDateController;
  late TextEditingController _seatCountController, _kilometersDrivenController, _powerController;
  late TextEditingController _registrationController, _registrationStartController, _registrationEndController;
  late TextEditingController _fuelConsumptionController;

  bool _isAutomatic = false;
  VehicleType _vehicleType = VehicleType.sedan;
  EmissionType _emissionType = EmissionType.gasoline;
  Color _color = Colors.green;

  DateTime? _productionDate, _registrationStartDate, _registrationEndDate;

  @override
  void initState() {
    super.initState();

    _brandController = TextEditingController();
    _modelController = TextEditingController();
    _imageUrlController = TextEditingController();
    _productionDateController = TextEditingController();

    _seatCountController = TextEditingController();
    _kilometersDrivenController = TextEditingController();
    _powerController = TextEditingController();

    _registrationController = TextEditingController();
    _registrationStartController = TextEditingController();
    _registrationEndController = TextEditingController();

    _fuelConsumptionController = TextEditingController();
  }

  void _onAddVehicleClicked(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final id = const Uuid().v1();
      final vehicle = Vehicle(
        id: id,
        seatCount: int.parse(_seatCountController.text),
        kilometersDriven: int.parse(_kilometersDrivenController.text),
        brand: _brandController.text,
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        color: _color,
        registration: VehicleRegistration(
          vehicleId: id,
          registration: _registrationController.text,
          start: _registrationStartDate!,
          end: _registrationEndDate!,
        ),
        type: _vehicleType,
        emissionType: _emissionType,
        isAutomatic: _isAutomatic,
        power: int.parse(_powerController.text),
        productionDate: _productionDate!,
        fuelConsumption: _emissionType == EmissionType.electric ? null : double.parse(_fuelConsumptionController.text),
      );

      Navigator.of(context).pop(vehicle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "General information:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.directions_car),
                    label: Text('Brand'),
                  ),
                  controller: _brandController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.directions_car),
                    label: Text('Model'),
                  ),
                  controller: _modelController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _productionDate = pickedDate;
                        _productionDateController.text = DateFormat("dd/MM/yy").format(pickedDate);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.cake),
                    label: Text('Production date'),
                  ),
                  controller: _productionDateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.event_seat),
                    label: Text('Seat count'),
                  ),
                  controller: _seatCountController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Invalid number format';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.add_road),
                    label: Text('Mileage (km)'),
                  ),
                  controller: _kilometersDrivenController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Invalid number format';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<VehicleType>(
                  value: _vehicleType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.airport_shuttle),
                    label: Text('Vehicle type'),
                  ),
                  items: VehicleType.values
                      .map((value) => DropdownMenuItem<VehicleType>(
                            value: value,
                            child: Text(value.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _vehicleType = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.image_search),
                    label: Text('Image URL'),
                  ),
                  controller: _imageUrlController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  title: Row(
                    children: [
                      Icon(
                        Icons.color_lens,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Vehicle color',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  subtitle: MaterialColorPicker(
                    selectedColor: _color,
                    circleSize: 32,
                    onColorChange: (color) {
                      setState(() {
                        _color = color;
                      });
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Engine information:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.power),
                    label: Text('Power (kW)'),
                  ),
                  controller: _powerController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Invalid number format';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<EmissionType>(
                  value: _emissionType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.air),
                    label: Text('Emission type'),
                  ),
                  items: EmissionType.values
                      .map((value) => DropdownMenuItem<EmissionType>(
                            value: value,
                            child: Text(value.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _emissionType = value!;
                    });
                  },
                ),
              ),
              if (_emissionType != EmissionType.electric)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        prefixIcon: Icon(Icons.local_gas_station),
                        label: Text('Fuel consumption (l/100 km)'),
                      ),
                      controller: _fuelConsumptionController,
                      validator: (value) {
                        if (_emissionType == EmissionType.electric) {
                          return null;
                        }
                        if (value == null || value.trim().isEmpty) {
                          return 'Required field';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid number format';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CheckboxListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.grey)),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Automatic transmission',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  value: _isAutomatic,
                  onChanged: (value) => setState(() {
                    _isAutomatic = value!;
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Registration information:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.directions_car),
                    label: Text('Vehicle registration'),
                  ),
                  controller: _registrationController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 366)),
                      lastDate: DateTime.now().add(const Duration(days: 366)),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _registrationStartDate = pickedDate;
                        _registrationStartController.text = DateFormat("dd/MM/yy").format(pickedDate);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.date_range),
                    label: Text('Registration start'),
                  ),
                  controller: _registrationStartController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                title: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 366)),
                      lastDate: DateTime.now().add(const Duration(days: 2 * 366)),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _registrationEndDate = pickedDate;
                        _registrationEndController.text = DateFormat("dd/MM/yy").format(pickedDate);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.date_range),
                    label: Text('Registration end'),
                  ),
                  controller: _registrationEndController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        elevation: 6,
                        height: 48,
                        onPressed: () {
                          _onAddVehicleClicked(context);
                        },
                        child: const Text(
                          'ADD VEHICLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
