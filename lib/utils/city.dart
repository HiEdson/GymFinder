import 'package:gymfinder/data/cities.dart';

List<String> getProvinces() {
  var cities = getCities();
  return cities.keys.toList();
}

List<String> getProvinceDistricts(String province) {
  var cities = getCities();
  var districts = cities[province];
  if (districts == null) return [];
  return cities[province]!.keys.toList();
}

List<String> getProvinceRegions(String province, String district) {
  var cities = getCities();
  var districts = cities[province];
  if (districts == null) return [];
  var mahalle = districts[district];
  if (mahalle == null) return [];
  return mahalle;
}
