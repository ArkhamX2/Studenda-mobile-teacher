import 'package:dartz/dartz.dart';
import 'package:studenda_mobile_student/core/data/error/failure.dart';
import 'package:studenda_mobile_student/feature/schedule/data/models/week_type_model.dart';

abstract class WeekTypeRepository {
  Future<Either<Failure, WeekTypeModel>> getCurrent(
    void request, [
    bool remote = true,
  ]);
  Future<Either<Failure, List<WeekTypeModel>>> getAll(
    void request, [
    bool remote = true,
  ]);
}
