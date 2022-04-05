import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';
import 'package:softgrow/widget/custom_shadow.dart';

class MapBox extends StatelessWidget {
  const MapBox({@required this.markLocation, @required this.size, Key key})
      : super(key: key);

  /// mark location
  final LatLng markLocation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          constraints: BoxConstraints.loose(size),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: markLocation,
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {},
            zoomControlsEnabled: false,
            markers: <Marker>{
              Marker(
                markerId: const MarkerId('location'),
                position: markLocation,
                infoWindow: InfoWindow(
                  title: 'Delivery Location',
                  snippet: markLocation.toString(),
                ),
              )
            },
          ),
        ),
      ),
    );
  }
}
