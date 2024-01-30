import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../helpers/functions/check_internet.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    // Check for internet connectivity
    if (await checkInternet()) {
      // If online, make a POST request
      http.Response response = await http.post(Uri.parse(linkUrl), body: data);

      // Check the HTTP status code
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the status code is 200 or 201, the request was successful
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
        Map responseBody = json.decode(response.body);
        if (kDebugMode) {

          print(responseBody);
        }
        return Right(responseBody); // Return a Right containing the response body
      } else {
        // If the status code is not 200 or 201, there was a server failure
        return const Left(StatusRequest.serverFailure); // Return a Left with serverfailure
      }
    } else {
      // If there is no internet connectivity, return an offline failure
      return const Left(StatusRequest.offlineFailure); // Return a Left with offlinefailure
    }
  }
}
