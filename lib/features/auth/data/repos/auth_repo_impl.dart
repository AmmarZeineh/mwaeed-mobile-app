import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final Api api;

  AuthRepoImpl(this.api);
  @override
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      await api.post(
        token: null,
        url: '$baseUrl/user',
        body: {
          'email': email,
          'password': password,
          'name': name,
          'phoneNumber': phone,
          'roleId': '2',
        },
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
