import 'package:dio/dio.dart';
import '../model/endemik.dart';

class EndemikService {
  final Dio _dio = Dio();

  Future<List<Endemik>> getData() async {
    try {
      final response = await _dio.get('https://hendroprwk08.github.io/data_endemik/endemik.json');
      final List<dynamic> data = response.data;
      return data.map((json) => Endemik.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      print(e);
      return [];
    }
  }
}