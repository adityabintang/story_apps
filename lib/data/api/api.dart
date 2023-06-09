import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:storys_apps/data/model/add_story_response.dart';
import 'package:storys_apps/data/model/stories.dart';
import 'package:storys_apps/data/model/user.dart';
import 'package:storys_apps/data/preference.dart';
import 'package:storys_apps/utils/constant.dart';

class Api {
  Future<String> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      var body = {
        'name': name,
        'email': email,
        'password': password,
      };

      var url = endPointRegister;
      debugPrint("register API POST: $url");

      var client = http.Client();

      final response = await client.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );

      client.close();
      if (response.statusCode == 201) {
        return json.decode(response.body)['message'];
      } else {
        debugPrint(json.decode(response.body)['message']);
        throw json.decode(response.body)['message'];
      }
    } catch (e) {
      throw Exception('Api register error : $e');
    }
  }

  Future<User> login(String email, String password) async {
    try {
      var body = {
        'email': email,
        'password': password,
      };

      var url = endPointLogin;
      debugPrint("login API POST: $url");

      var client = http.Client();

      final response = await client.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );

      client.close();

      if (response.statusCode == 200) {
        await putStorageBoolean(loginData, true);
        saveOAuthData(response.body);
        return User.fromJson(json.decode(response.body));
      } else {
        debugPrint(response.body);
        throw User.fromJson(json.decode(response.body)).message!;
      }
    } catch (e) {
      debugPrint('$e');
      throw Exception('Api register error : $e');
    }
  }

  Future<StoriesResults> getStoriesList(
      [int page = 1, int size = 20, int location = 0]) async {
    try {
      var url = '$endPointGetStory?page=$page&size=$size&location=$location';
      debugPrint("list stories API GET: $url");

      var client = http.Client();

      final response = await client.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await getOAuthData()}"
        },
      );

      client.close();
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return StoriesResults.fromJson(json.decode(response.body));
      } else {
        throw StoriesResults.fromJson(json.decode(response.body));
      }
    } catch (e) {
      debugPrint('$e');
      throw Exception('Api get data error : $e');
    }
  }

  Future<AddStoryResponse> addStory(
    List<int> bytes,
    String fileName,
    String description, [
    double lat = 0.0,
    double lon = 0.0,
  ]) async {
    try {
      var url = endPointAddStory;
      debugPrint("detail stories API GET: $url");

      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      final multiPartFile = http.MultipartFile.fromBytes(
        "photo",
        bytes,
        filename: fileName,
      );

      final Map<String, String> fields = {
        "description": description,
        "lat": lat.toString(),
        "lon": lon.toString(),
      };
      final Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getOAuthData()}"
      };

      request.files.add(multiPartFile);
      request.fields.addAll(fields);
      request.headers.addAll(headers);

      final http.StreamedResponse streamedResponse = await request.send();
      final int statusCode = streamedResponse.statusCode;

      final Uint8List responseList = await streamedResponse.stream.toBytes();
      final String responseData = String.fromCharCodes(responseList);

      if (statusCode == 201) {
        final AddStoryResponse addStoryResponse = AddStoryResponse.fromJson(
          json.decode(responseData),
        );
        return addStoryResponse;
      } else {
        throw AddStoryResponse.fromJson(json.decode(responseData));
      }
    } catch (e) {
      debugPrint('$e');
      throw Exception('Api add story error : $e');
    }
  }

  Future<void> saveOAuthData(String token) async {
    await putStorage(authData, token);
  }

  Future<String> getOAuthData() async {
    var data = await getStorage(authData);
    var token = json.decode(data!);
    debugPrint(token['loginResult']['token']);
    return token['loginResult']['token'];
  }
}

final api = Api();
