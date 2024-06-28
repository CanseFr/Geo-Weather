import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../models/geo-location-model.dart';

// TODO: bug mise a jour list dans le display de geoloc_page !!!

class FavoritCities extends ChangeNotifier{
  final List<Geolocation> _items = [];

  List<Geolocation> get items => List.unmodifiable(_items);

  void add(Geolocation loc) {
    _items.add(loc);
    notifyListeners();
  }

   bool contain(Geolocation newGeo ){
    for(var l in _items){
      if(l.state == newGeo.state &&  l.country == newGeo.country){
        return true;
      }
    }
    return false;
  }

  void remove(Geolocation loc) {
    _items.remove(loc);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}