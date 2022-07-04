import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  PlaceLocation(
      {@required this.latitude, @required this.longitude, this.address});
}

class Place {
  final String Id;
  final String title;
  final PlaceLocation location;
  final File image;
  Place({
    @required this.Id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
