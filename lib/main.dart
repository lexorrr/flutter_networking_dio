import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() async {
  final dio = Dio();
  final url = 'https://website.com';

  try {
    final response1 = await dio.get<String>(url, queryParameters: {
      "param1": 1,
      "param2": 2
    });
    print('${response1.data}');

    final response2 = await dio.post<String>(url, data: {
      "key1": "1",
      "key2": 2
    });
    print('${response2.data}');

    // The timeout is expressed in milliseconds
    final options = BaseOptions(
      baseUrl: 'https://website.com/api/',
      connectTimeout: 3000, // 3 seconds
    );

    final dio2 = Dio(options);

    // Executes 3 requests concurrently and waits for all of them
    // to complete
    final response = await Future.wait([
      dio2.get<String>('/versions'),
      dio2.get<String>('/products/list'),
      dio2.post<String>('/login',
          options: Options(
              headers: {
                'Authentication': 'auth-key'
              }
          )
      )
    ]);

  } on DioError catch (e) {
    print(e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

