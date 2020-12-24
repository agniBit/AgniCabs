import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

login(String username, String password) async {
  try {
    Dio dio = new Dio();
    return await dio.post("http://10.0.2.2:3000/authUser",
        data: {
          "password": password,
          "username": username
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  } on DioError catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16);
  }
}
