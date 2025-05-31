import 'package:dio/dio.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:office_buddy/src/data/model/post/feed_model.dart';

class FeedRepositories {
  final Dio _dio = ApiProvider.getDio();
  final String baseUrl = AppConstant.dynamicBaseUrl;
  Future<List<FeedModel>> getFeed() async {
    try {
      final response = await _dio.get(AppConstant.feedPost);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => FeedModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }
}
