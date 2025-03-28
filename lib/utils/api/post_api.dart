
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

 postData({context, url,requestBody}) async {
  // print(requestBody);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String authToken = prefs.getString("authToken") ?? "";
  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $authToken"
    },
    body: json.encode(requestBody)
  );
  if (response.statusCode == 200) {
    dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
      if (responseBody.runtimeType.toString() != "List<dynamic>") {
        log("Its a Map Data");
          return jsonDecode(response.body);
      }
      else  if (responseBody.containsKey("error")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('authToken', "");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
        return null;
      }
      else {
        log("Its a List");
        return null;
      }
    } catch (e) {
      log(e.toString());
      return {};
    }
  } else {
    log("++++++++++Status Code +++++++++++++++");
    log(response.statusCode.toString());
  }
}




// Update API.
Future updateData(String url, dynamic requestBody) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String basicAuth=prefs.getString('basicAuth')??"";

  final response = await http.patch(
    Uri.parse(url),
    headers: {
      "content-type": "application/json;charset=utf-8",
      // 'authorization': basicAuth
    },
    body: jsonEncode(requestBody),
  );
  try {
    if (response.statusCode == 200) {
      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
        if (responseBody.runtimeType.toString() != "List<dynamic>") {
          log("Its a Map Data");
          if (responseBody.containsKey("status")) {
            log(response.body);
            return jsonDecode(response.body);
          } else {
            return null;
          }
        }
        else  if (responseBody.containsKey("error")) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', "");
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
          return null;
        }
        else {
          log("Its a List");
          return null;
        }
      } catch (e) {
        log(e.toString());
        return {};
      }
    } else {
      log("++++++++++Status Code +++++++++++++++");
      log(response.statusCode.toString());
      return null;
    }
  }
  catch(e){
        return null;
  }

}

Future deleteApi(String url) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String basicAuth=prefs.getString('basicAuth')??"";

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      "content-type": "application/json;charset=utf-8",
      // 'authorization': basicAuth
    },
  );
  try {
    if (response.statusCode == 200) {
      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
        if (responseBody.runtimeType.toString() != "List<dynamic>") {
          log("Its a Map Data");
          if (responseBody.containsKey("status")) {
            log(response.body);
            return jsonDecode(response.body);
          } else {
            return null;
          }
        }
        else  if (responseBody.containsKey("error")) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', "");
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
          return null;
        }
        else {
          log("Its a List");
          return null;
        }
      } catch (e) {
        log(e.toString());
        return {};
      }
    } else {
      log("++++++++++Status Code +++++++++++++++");
      log(response.statusCode.toString());
      return null;
    }
  }
  catch(e){
    return null;
  }

}



logOutApi({dynamic response, context, exception}) async {
  if (response.containsKey("error")) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', "");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
  }
  log(exception);
}
