import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/clinic_location_model.dart';

class GoogleMapPickerView extends StatefulWidget {
  const GoogleMapPickerView({super.key});

  @override
  State<GoogleMapPickerView> createState() => _GoogleMapPickerViewState();
}

class _GoogleMapPickerViewState extends State<GoogleMapPickerView> {
  late LatLng selectedLocation;
  late String selectedAddress;
  bool resolvingAddress = false;

  @override
  void initState() {
    super.initState();
    final initial = Get.arguments as ClinicLocationModel?;
    selectedLocation = LatLng(
      initial?.latitude ?? 24.7136,
      initial?.longitude ?? 46.6753,
    );
    selectedAddress = initial?.address ?? '';
  }

  Future<void> _selectLocation(LatLng location) async {
    setState(() {
      selectedLocation = location;
      resolvingAddress = true;
    });
    var address =
        '${location.latitude.toStringAsFixed(6)}, '
        '${location.longitude.toStringAsFixed(6)}';
    try {
      final places = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (places.isNotEmpty) {
        final place = places.first;
        address = [
          place.street,
          place.subLocality,
          place.locality,
          place.country,
        ].where((part) => part?.trim().isNotEmpty ?? false).join(', ');
      }
    } catch (_) {
      // Coordinates remain valid when reverse geocoding is unavailable.
    }
    if (!mounted) return;
    setState(() {
      selectedAddress = address;
      resolvingAddress = false;
    });
  }

  void _confirm() {
    Get.back(
      result: ClinicLocationModel(
        address: selectedAddress,
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('settings.map_picker.title'))),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 14,
            ),
            onTap: _selectLocation,
            markers: {
              Marker(
                markerId: const MarkerId('clinic_location'),
                position: selectedLocation,
              ),
            },
          ),
          PositionedDirectional(
            start: 16,
            end: 16,
            bottom: 20,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      resolvingAddress
                          ? tr('settings.map_picker.resolving')
                          : selectedAddress,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: resolvingAddress ? null : _confirm,
                      icon: const Icon(Icons.check),
                      label: Text(tr('settings.map_picker.confirm')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
