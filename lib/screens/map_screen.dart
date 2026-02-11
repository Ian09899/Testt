
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String familyId = "family123";
  final FirestoreService _firestore = FirestoreService();
  final AuthService _auth = AuthService();

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Family Live Map")),
      body: StreamBuilder(
        stream: _firestore.getLocations(familyId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          _markers.clear();

          for (var doc in snapshot.data!.docs) {
            _markers.add(
              Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(doc['lat'], doc['lng']),
                infoWindow: InfoWindow(title: doc.id),
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(47.0, 28.8),
              zoom: 14,
            ),
            markers: _markers,
            myLocationEnabled: true,
          );
        },
      ),
    );
  }
}
