import 'package:hashmicro_test_apps/config/dio_config.dart';
import 'package:hashmicro_test_apps/model/standart_response.dart';
import 'package:hashmicro_test_apps/pages/attendance/model/locations_response.dart';

abstract class LocationRepository {
  Future<LocationsResponse?> getLocations();
  Future<StandartResponse?> addLocation({required dynamic body});
}

class LocationRepositoryImpl extends LocationRepository {
  @override
  Future<LocationsResponse?> getLocations() async {
    final dio = await DioConfig.dioInstance();

    try {
      final response = await dio.get('/api/location');
      return LocationsResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<StandartResponse?> addLocation({required dynamic body}) async {
    final dio = await DioConfig.dioInstance();

    try {
      final response = await dio.post('/api/location', data: body);
      return StandartResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
