import 'package:gymfinder/data/cities.dart';

List<String> getProvinces() {
  var cities = getCities();
  var provinces = cities.keys.toList();
  provinces.sort();
  return provinces;
}

List<String> getProvinceDistricts(String province) {
  var cities = getCities();
  var districts = cities[province];
  if (districts == null) return [];
  var _districts = cities[province]!.keys.toList();
  _districts.sort();
  return _districts;
}

List<String> getDistrictMahalle(String province, String district) {
  var cities = getCities();
  var districts = cities[province];
  if (districts == null) return [];
  var mahalle = districts[district];
  if (mahalle == null) return [];
  mahalle.sort();
  return mahalle;
}
