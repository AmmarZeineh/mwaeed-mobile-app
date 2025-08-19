import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryEntitiy>>> getCategories({
    required int skip,
    int limit = 10,
  });
}
