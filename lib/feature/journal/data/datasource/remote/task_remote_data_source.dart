

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:studenda_mobile_student/core/data/datasource/datasource.dart';
import 'package:studenda_mobile_student/core/data/error/exception.dart';
import 'package:studenda_mobile_student/core/network/api_config.dart';
import 'package:studenda_mobile_student/core/network/simplified_uri.dart';
import 'package:studenda_mobile_student/feature/journal/data/model/api/task_student_request_model.dart';
import 'package:studenda_mobile_student/feature/journal/data/model/task/task_model.dart';

class TaskRemoteDataSource
    extends RemoteDataSource<List<TaskModel>, TaskStudentRequestModel> {
      
  final http.Client client;

  TaskRemoteDataSource({required this.client});
  @override
  Future<List<TaskModel>> load(TaskStudentRequestModel request)async  {
    try {
      
      final Map<String, dynamic> queryParameters = {
        'asigneeUserIds': request.asigneeUserIds,
        'disciplineId': request.disciplineId,
        'subjectTypeId': request.subjectTypeId,
        'academicYear': request.academicYear,
      };
      final uri =
          SimplifiedUri.uri('$BASE_URL/journal/task/asignee', queryParameters);
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as List<dynamic>;
        final responseModel = decoded
            .map(
              (dynamic value) =>
                  TaskModel.fromJson(value as Map<String, dynamic>),
            )
            .toList();
        return responseModel;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
