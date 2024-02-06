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
    // initMarkers();
    //initPlylines();
    initPloygons();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();

    super.dispose();
  }

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        polygons: polygons,
        polylines: polylines,
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

  // Future<Uint8List> getBytesFromRowData(String image, int width) async {
  //   var imageData = await rootBundle.load(image);
  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());

  //   var imageFrameinfo = await imageCodec.getNextFrame();
  //   var imageBytDate =
  //       await imageFrameinfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageBytDate!.buffer.asUint8List();
  // }

  void initMarkers() async {
    // var customMarkerIcon = BitmapDescriptor.fromBytes(
    //     await getBytesFromRowData('assets/images/location.png', 50));
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/location.png');

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

  void initPlylines() {
    Polyline polyline =
        const Polyline(polylineId: PolylineId('1'), color: Colors.red, points: [
      LatLng(31.01568770514533, 31.38832825260846),
      LatLng(31.037901296576674, 31.35467695670655),
      LatLng(31.038598678394862, 31.34497258810785),
      LatLng(31.11834713379703, 31.450770721973228),
    ]);
    polylines.add(polyline);
  }

  void initPloygons() {
    Polygon polygon = Polygon(
        polygonId: const PolygonId('1'),
        fillColor: Colors.black.withOpacity(.5),
        strokeWidth: 2,
        //بتشيل بعض الاماكن
        holes: const [
          [
            LatLng(31.082031894074294, 31.418896639342616),
            LatLng(31.085398370341775, 31.409619717862228),
            LatLng(31.095128276334805, 31.409230232973673),
          ]
        ],
        points: const [
          LatLng(31.01568770514533, 31.38832825260846),
          LatLng(31.037901296576674, 31.35467695670655),
          LatLng(31.038598678394862, 31.34497258810785),
          LatLng(31.11834713379703, 31.450770721973228),
        ]);
    polygons.add(polygon);
  }
}
