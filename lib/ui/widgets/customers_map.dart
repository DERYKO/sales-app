import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solutech_sat/helpers/location_manager.dart';

class CustomersMap extends StatefulWidget {
  Set<Marker> markers;
  CustomersMap({
    this.markers,
  });
  @override
  State<CustomersMap> createState() => CustomersMapState();
}

class CustomersMapState extends State<CustomersMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _currentLocation = CameraPosition(
    target: LatLng(
      locationManager.position.latitude,
      locationManager.position.longitude,
    ),
    zoom: 14.4746,
  );

  /*Set<Marker> markers = Set()
    ..add(Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(-1.28333, 36.81667),
        infoWindow: InfoWindow(title: "Title", snippet: "Good\nMorning")));*/

  @override
  void initState() {
    super.initState();
    print("Markers ${widget.markers}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _currentLocation,
        markers: widget.markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
