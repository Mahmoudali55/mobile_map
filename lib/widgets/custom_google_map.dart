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
    initMarkers();
  }

  @override
  void dispose() {
    googleMapController.dispose();

    super.dispose();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        markers: markers,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
        });
  }

  void initMapStyle() async {
    var nightmapstyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightmapstyle);
  }

  void initMarkers() {
    var marker = const Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.03686361532399, 31.393837474529327),
    );
    markers.add(marker);
  }
}
