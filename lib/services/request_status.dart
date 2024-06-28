import 'package:geolocator/geolocator.dart';

class RequestStatus {

  static isLocationDisabled(bool serviceEnabled){
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  static locationPermition(LocationPermission permission){
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  static permissionDenied( LocationPermission permission) async {
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }
}