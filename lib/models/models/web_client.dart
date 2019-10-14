import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import 'package:login/classes/user.dart';


class WebClient {
  WebClient(this.auth);

  final User auth;

  Future<dynamic> post(String url, dynamic data ,
      {String bodyContentType}) async {
    if (auth == null) throw ('Auth Model Required');
    final http.Response response = await getHttpResponse(
      url,
      body: data,
      headers: {
        HttpHeaders.authorizationHeader:  "f2e25125db9926be9731678f5c5f05e4804a85d8",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return '${json.decode(response.body)['apiStatus']['code']}';
  }

  Future<http.Response> getHttpResponse(
      String url, {
        dynamic body,
        Map<String, String> headers,
        HttpMethod method = HttpMethod.post,
      }) async {
    final inner.IOClient _client = getClient();
    http.Response response;

    try {
      // ignore: unnecessary_statements
      HttpMethod.post;
      response = await _client.post(
        url,
        body: body,
        headers: headers,);


      print("URL: $url");
      print("Body: $body");
      print("Response Code: " + response.statusCode.toString());
      print("Response Code: " + response.body);
      //print('Response Body: -> ${json.decode(response.body)['apiStatus']['code']}');



      if (response.statusCode == 200 || response.statusCode == 201){
        if (response.statusCode == 401) {
          if (auth != null) {
            // Todo: Refresh Token !
            final String _token = auth?.token ?? "";
            //print(" Second Token => $_token");
            response = await getHttpResponse(
              url,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $_token",
              },
            );
          }
        } // Not Authorized
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
}

enum HttpMethod { get, post, put, delete }
