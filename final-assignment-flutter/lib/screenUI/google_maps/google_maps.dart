import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng mylocation = const LatLng(27.690037, 85.329458);

  @override
  void initState() {
    markers.add(
      Marker(
        // add marker on google map
        markerId: MarkerId(mylocation.toString()),
        position: mylocation,
        infoWindow: const InfoWindow(
          title: 'HireX',
          snippet: 'wwww.hirex.com.np',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: mylocation,
          zoom: 10,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          mapController = mapController;
        },
      ),
    );
  }
}
