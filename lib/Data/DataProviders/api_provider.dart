import 'package:http/http.dart' as http;
import 'package:task_manager/Data/DataProviders/cached_data.dart';
import 'package:task_manager/Data/Models/user.dart';
import 'package:task_manager/Data/constants/url.dart';
import 'dart:convert';

import 'package:task_manager/Utilities/exceptions.dart';

class APIProvider {
  Future<dynamic> refreshSession() async {
    final url = Uri.parse('$baseURL/auth/refresh');
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization": "Bearer ${CachedData.getData(key: 'token')}",
    };

    final response = await http
        .post(
      url,
      headers: headers,
    )
        .timeout(Duration(seconds: 10), onTimeout: () {
      throw ServerException(message: 'Time out');
    });

    Map<String, dynamic> userData = json.decode(response.body);
    User user = User.fromJson(userData);

    await CachedData.saveData(key: 'token', data: user.token);
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> get({required String URL, String? token}) async {
    var headers = token == null
        ? {
            "Accept": "application/json",
            "Content-type": "application/json",
          }
        : {
            "Accept": "application/json",
            "Content-type": "application/json",
            "Authorization": "Bearer $token",
          };

    final url = Uri.parse(URL);
    final response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ServerException(message: 'Time out');
      },
    );
    if (response.statusCode > 201) {
      if (response.statusCode == 404) {
        throw EmptyException(message: 'Not Found');
      }
      if (response.statusCode == 401) {
        print("-----------   Unauthorized   -----------");
        try {
          refreshSession();
          return get(URL: URL, token: token);
        } catch (e) {
          throw UnauthorizedException(message: 'Unauthorized');
        }
      }
      if (response.statusCode >= 500) {
        throw ServerException(
            message: 'Internal Server Error \n code: ${response.statusCode}');
      }
      throw ServerException(message: response.body);
    }
    return json.decode(response.body);
  }

  Future<dynamic> post(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    final headers = token == null
        ? {
            "Accept": "application/json",
            "Content-type": "application/json",
          }
        : {
            "Accept": "application/json",
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          };
    final url = Uri.parse(URL);
    final response =
        await http.post(url, body: json.encode(body), headers: headers).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ServerException(message: 'Time out');
      },
    );
    if (response.statusCode > 201) {
      if (response.statusCode == 404) {
        return {};
      }
      if (response.statusCode >= 500) {
        throw ServerException(
            message: 'Internal Server Error \n code: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        print("-----------   Unauthorized   -----------");
        try {
          refreshSession();
          return post(URL: URL, body: body, token: token);
        } catch (e) {
          throw UnauthorizedException(message: 'Unauthorized');
        }
      } else {
        throw ServerException(message: json.decode(response.body)['message']);
      }
    }
    return json.decode(response.body);
  }

  Future<dynamic> delete(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    // final headers = token == null
    //     ? {
    //         "Accept": "application/json",
    //         "Content-type": "application/json",
    //       }
    //     : {
    //         "Accept": "application/json",
    //         "Content-type": "application/json",
    //         "Authorization": "Bearer $token"
    //       };
    final url = Uri.parse(URL);
    final response = await http
        .delete(
      url,
      body: json.encode(body),
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ServerException(message: 'Time out');
      },
    );
    if (response.statusCode > 201) {
      if (response.statusCode == 404) {
        return {};
      }
      if (response.statusCode >= 500) {
        throw ServerException(
            message: 'Internal Server Error \n code: ${response.statusCode}');
      }
      throw ServerException(message: json.decode(response.body));
    }
    return json.decode(response.body);
  }

  Future<dynamic> put(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    final headers = token == null
        ? {
            "Accept": "application/json",
            "Content-type": "application/json",
          }
        : {
            "Accept": "application/json",
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          };
    final url = Uri.parse(URL);
    final response =
        await http.put(url, body: json.encode(body), headers: headers).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ServerException(message: 'Time out');
      },
    );
    if (response.statusCode > 201) {
      if (response.statusCode == 404) {
        return {};
      }
      if (response.statusCode >= 500) {
        throw ServerException(
            message: 'Internal Server Error \n code: ${response.statusCode}');
      }
      throw ServerException(message: json.decode(response.body));
    }
    return json.decode(response.body);
  }
}
