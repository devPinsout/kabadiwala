import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
class NetworkUtil {
   
  //static String imageUrl = "http://192.168.1.9/creditcode"; 
  //static String baseUrl = "http://192.168.1.9/creditcode/api/v1";
   static String baseUrl = "https://earnpie.com/api/v1";
   static String imageUrl = "https://earnpie.com";
  static Future<dynamic> networkGet(String url, String? token,
      {Map<String, dynamic>? headers, body, encoding}) {
    var dio = Dio();
    
    
    return dio.get(baseUrl + url, options: Options(headers: headers)).then(
      (response) {
        // print("Error ${response.statusCode}");
        if (response.statusCode! < 200 || response.statusCode! > 300) {

          // AppController().logout();
          return false;
        }
        return response;
      },
    ).catchError((e) {
      //print("")
      if (e is DioException) {
        return e.response;
      } else {
        // print(e.toString());
        throw Exception(e);
      }
    });
  }

static Future<dynamic> networkPost(String url,
      {Map<String, String>? headers, body, encoding}) async {
   headers ??= {};
    final response = await http.post(Uri.parse(baseUrl+url), body:body, headers: headers);
    if(response.statusCode==302 || response.statusCode == 401){
      // AppController().logout();
      return false;
    }
    else{
      return response;
    }
  }

static Future<dynamic> networkImagePost(String url,
  {Map<String, String>? headers,body,filePath}) async{
    headers ??={};

    return await http.MultipartRequest('POST', Uri.parse(url));
  }

  
static Future<dynamic> networkPatch(String url,
      {Map<String, String>? headers, body, encoding}) async {
   headers ??= {};
    return await http.patch(Uri.parse(baseUrl+url), body:body, headers: headers);
  }

  Future<dynamic> networkDelete(String url,
      {Map<String, dynamic>? headers, body, encoding}) {
    var dio = Dio();
    return dio.delete(url, data: body, options: Options(headers: headers)).then(
      (response) {
        print(response);
        print(response.data);
        return response;
      },
    ).catchError((e) {
      if (e is DioException) {
        return e.response;
      } else {
        // print(e.toString());
        throw Exception(e);
      }
    });
  }

  static Future<dynamic> uploadImage(File? imagePath) async {
  if (imagePath == null) return;

  final url = baseUrl+"/medias/create";
  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.headers.addAll({
    'Content-Type': 'multipart/form-data', 
    // 'Authorization': 'Bearer ${AppController.authToken}', 
  });

  request.files.add(await http.MultipartFile.fromPath('file', imagePath.path));

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);

}
  Future<dynamic> networkPut(String url,
      {Map<String, dynamic>? headers, body, encoding}) {
    var dio = Dio();
    return dio.put(url, data: body, options: Options(headers: headers)).then(
      (response) {
        if (response.statusCode! < 200 || response.statusCode! > 300) {
          throw Exception(response.data);
        }
        print(response);
        print(response.data);
        return response;
      },
    );
  }
}
