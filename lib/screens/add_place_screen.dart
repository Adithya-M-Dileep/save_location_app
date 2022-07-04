import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/great_places.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routName = "/add-place";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _tittleContoller = TextEditingController();
  File _savedImage;
  PlaceLocation _location;

  void _selectImage(File pickedImage) {
    _savedImage = pickedImage;
  }

  void _selectLocation(PlaceLocation _pickedLocation) {
    _location = _pickedLocation;
  }

  void _saveInfos() {
    if (_tittleContoller.text.isEmpty ||
        _savedImage == null ||
        _location == null) return;
    Provider.of<GreatePlaces>(context, listen: false)
        .AddPlace(_tittleContoller.text, _savedImage, _location);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: _tittleContoller,
                ),
                SizedBox(
                  height: 15,
                ),
                ImageInput(_selectImage),
                SizedBox(
                  height: 15,
                ),
                LocationInput(_selectLocation),
              ],
            ),
          ),
        )),
        RaisedButton.icon(
          icon: Icon(Icons.add),
          label: Text("Add Place"),
          onPressed: _saveInfos,
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Theme.of(context).accentColor,
        )
      ]),
    );
  }
}
