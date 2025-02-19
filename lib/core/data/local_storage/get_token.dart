import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:studenda_mobile_student/core/data/error/exception.dart';
import 'package:studenda_mobile_student/core/data/error/failure.dart';
import 'package:studenda_mobile_student/feature/auth/data/models/token_model.dart';

Future<Either<Failure, TokenModel>> getTokenFromLocalStorage(
  FlutterSecureStorage storage,
) async {
  try {
    final token = await storage.read(key: 'jwt_access_token');
    final refreshToken = await storage.read(key: 'jwt_refresh_token');
    if (token != null && refreshToken != null) {
      return Right(TokenModel(token: token, refreshToken: refreshToken));
    } else {
      throw CacheException();
    }
  } on CacheException {
    return const Left(
      CacheFailure(message: "Ошибка локального хранилища данных"),
    );
  }
}
