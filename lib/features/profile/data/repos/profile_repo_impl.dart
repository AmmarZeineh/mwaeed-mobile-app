import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/profile/data/models/city_model.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final Api _api;

  ProfileRepoImpl(this._api);
  @override
  Future<Either<Failure, void>> updateUserData({
    required Map<String, dynamic> body,
    required int userId,
  }) async {
    try {
      await _api.patch(url: '$baseUrl/user/$userId', body: body);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString().substring(10)));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    try {
      var response = await _api.get(url: '$baseUrl/user/cities');
      List<CityEntity> cities = [];
      for (var i = 0; i < response.length; i++) {
        cities.add(CityModel.fromJson(response[i]).toEntity());
      }
      return Right(cities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      _api.post(url: '$baseUrl/auth/logout');
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
