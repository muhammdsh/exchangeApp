
import 'package:geocoding/geocoding.dart';

class LocationService {

  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  Future<List<Location>> getLocationFromAddress(String address) {
    return locationFromAddress(address);
  }

  Future<List<Placemark>> getPlaceFromCoordinates(
  double latitude,double longitude) {
    return placemarkFromCoordinates(latitude, longitude);
  }

}