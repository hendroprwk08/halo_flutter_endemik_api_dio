import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

// import file endemik_service yang berisi function
// untuk mengakses API
import 'package:EndemikDB/service/endemik_service.dart';

// endemik.dart
import 'package:EndemikDB/model/endemik.dart';

// Interceptor
class TestInterceptor extends Interceptor {
  final List<DioError> dioErrors = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Simpan request untuk verifikasi
    print('Request: ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    dioErrors.add(err);
    handler.next(err);
  }
}

void main(){
  test('Mengambil data endemikDB', () async {
    // menguji function _getData()
    // didalam file home_page.dart
    final dio = Dio();
    final interceptor = TestInterceptor();
    dio.interceptors.add(TestInterceptor());
    final service = EndemikService();

    final result = await service.getData();

    // Verifikasi request dan response
    expect(interceptor.dioErrors, isEmpty);

    // Pastikan hasil adalah List<Endemik>
    expect(result, isA<List<Endemik>>());

    // Pastikan hasil tidak kosong
    expect(result.isNotEmpty, true);
  });
}
