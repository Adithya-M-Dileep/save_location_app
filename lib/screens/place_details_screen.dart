import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../helpers/location_helper.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = "/place-detail";

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  String _previewImageUrl;

  Future<void> LoadMap(double lat, double log) async {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: log);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatePlaces>(context, listen: false).FindById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Address",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            selectedPlace.location.address,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _previewImageUrl == null
              ? FlatButton.icon(
                  onPressed: () {
                    LoadMap(selectedPlace.location.latitude,
                        selectedPlace.location.longitude);
                  },
                  icon: Icon(Icons.location_on),
                  label: Text("View on Map"),
                  textColor: Theme.of(context).primaryColor,
                )
              : Container(
                  alignment: Alignment.center,
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ],
      )),
    );
  }
}
