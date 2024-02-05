import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 10, target: LatLng(31.03686361532399, 31.393837474529327));
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
        ),
        Positioned(
          top: 500,
          left: 200,
          child: ElevatedButton(
              onPressed: () {
                CameraPosition newCameraPosition = const CameraPosition(
                  zoom: 10,
                  target: LatLng(30.058698566337153, 31.227461368544287),
                );
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(newCameraPosition));
              },
              child: const Text("go")),
        ),
      ],
    );
  }
}
