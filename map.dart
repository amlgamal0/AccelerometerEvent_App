// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapScreen({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    LatLng position = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('location')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 15,
        ),
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('position'),
            position: position,
          ),
        },
      ),
    );
  }
}