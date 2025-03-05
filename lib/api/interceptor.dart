import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api/v1',
    // connectTimeout: const Duration(seconds: 5),
    // receiveTimeout: const Duration(seconds: 3), 
  )
);

void dioInterceptor() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest : (RequestOptions options, RequestInterceptorHandler handler) {
        return handler.next(options);
      },

      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },

      onError: (DioException err, ErrorInterceptorHandler handler) {
        print("Error: ${err.message}");
        return handler.next(err);
      }
    )
  );
}