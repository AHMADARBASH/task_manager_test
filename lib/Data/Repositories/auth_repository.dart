import 'package:task_manager/Data/DataProviders/api_provider.dart';
import 'package:task_manager/Data/constants/url.dart';
import 'package:task_manager/Utilities/locator.dart';

class AuthRepository {
  var apiProvider = locator.get<APIProvider>();

  Future<Map<String, dynamic>> signIn(Map<String, dynamic> credentials) async {
    final url = '$baseURL/auth/login';
    return await apiProvider.post(URL: url, body: credentials);
  }
}
