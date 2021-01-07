

import 'package:dio/dio.dart';
import 'package:health_box/model/response_model/all_programs_response_model.dart';
import 'package:health_box/network/api_result.dart';
import 'package:health_box/network/network_exceptions.dart';

import '../constant.dart';
import 'dio_client.dart';

class APIRepository {
  DioClient dioClient;
  String _baseUrl = "https://www.eblock6.com/healthbox/webservices/api/";

  APIRepository() {
    var dio = Dio();

    dioClient = DioClient(_baseUrl, dio);
  }

  Future<ApiResult<GetAllProgramsResponseModel>> fetchMovieList() async {
    try {
      final response = await dioClient
          .get("GetPrograms.php");

      return ApiResult.success(data: GetAllProgramsResponseModel.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


}