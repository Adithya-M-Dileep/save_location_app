import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helpers.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place FindById(String Id) {
    return _items.firstWhere((element) => element.Id == Id);
  }

  void AddPlace(String title, File selectedImage, PlaceLocation location) {
    final newPlace = Place(
      Id: DateTime.now().toString(),
      title: title,
      location: location,
      image: selectedImage,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert("user_places", {
      "id": newPlace.Id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": location.latitude,
      "log": location.longitude,
      "address": location.address,
    });
  }

  Future<void> FectAndSeyPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((item) => Place(
            Id: item["id"],
            title: item["title"],
            location: PlaceLocation(
              latitude: item["lat"],
              longitude: item["log"],
              address: item["address"],
            ),
            image: File(
              item["image"],
            )))
        .toList();
  }
}
