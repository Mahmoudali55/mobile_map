import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_map/models/place_model.dart';
import 'dart:ui' as ui;

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

  Future<Uint8List> getBytesFromRowData(String image, int width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());

    var imageFrameinfo = await imageCodec.getNextFrame();
    var imageBytDate =
        await imageFrameinfo.image.toByteData(format: ui.ImageByteFormat.png);
    return imageBytDate!.buffer.asUint8List();
  }

  void initMarkers() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
        await getBytesFromRowData('assets/images/location.png', 50));

    var myMarkers = places
        .map((PlaceModel) => Marker(
            markerId: MarkerId(PlaceModel.id.toString()),
            position: PlaceModel.latLng,
            infoWindow: InfoWindow(title: PlaceModel.name)))
        .forEach((element) {
      markers.add(element);
      setState(() {});
    });
  }
}
