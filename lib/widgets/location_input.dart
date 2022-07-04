import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../models/place.dart';

class LocationInput extends StatefulWidget {
  Function pickLocation;

  LocationInput(this.pickLocation);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locationData.latitude, longitude: locationData.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    final gecodingAddress = await LocationHelper.getPlaceAddress(
        longitude: locationData.longitude, latitude: locationData.latitude);
    final address =
        "${gecodingAddress["county"]}, ${gecodingAddress["state"]}, ${gecodingAddress["postcode"]}, ${gecodingAddress["country"]}";

    widget.pickLocation(PlaceLocation(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
      address: address,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  "Choose a Location",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
