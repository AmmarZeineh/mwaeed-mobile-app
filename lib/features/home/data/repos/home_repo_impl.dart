import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/home/data/models/category_model.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final Api _api;

  HomeRepoImpl(this._api);
  @override
  Future<Either<Failure, List<CategoryEntitiy>>> getCategories({
    required int skip,
    int limit = 10,
  }) async {
    try {
      var data = await _api.get(
        url: '$baseUrl/jobs/with-provider?skip=$skip&limit=$limit',
        token: null,
      );
      List<CategoryEntitiy> categories = [];
      for (var i = 0; i < data['data'].length; i++) {
        categories.add(CategoryModel.fromJson(data['data'][i]).toEntity());
      }
      return Right(categories);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
