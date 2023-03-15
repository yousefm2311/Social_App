// import 'package:dio/dio.dart';

// class Dio_Helper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://fcm.googleapis.com',
//         receiveDataWhenStatusError: true,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//               'key=AAAAUA5nIoE:APA91bFS5930Gt94z8IA6DzylewCpolug7aDmLStpV8PjxlNHIeY323i9iRQu8uM19IGr2YrOfxJPLeFrMJfGN4J92uOgLN3r3MJt6u7bl728lUizHPJmyZHCBPPRORHSTqMdD-Qh64T'
//         },
//       ),
//     );
//   }

//   // static Future<Response> getData({
//   //   required String url,
//   //   Map<String, dynamic>? query,
//   //   String? lang = 'en',
//   //   String? token,
//   // }) async {
//   //   dio!.options.headers = {
//   //     'lang': lang,
//   //     'Authorization': token,
//   //     'Content-Type': 'application/json'
//   //   };
//   //   return await dio!.get(url, queryParameters: query);
//   // }

//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? token,
//     required Map<String, dynamic> data,
//   }) async {
//     dio!.options.headers = {
//       'Content-Type': 'application/json'
//     };
//     return dio!.post(url, queryParameters: query, data: data);
//   }


// }
