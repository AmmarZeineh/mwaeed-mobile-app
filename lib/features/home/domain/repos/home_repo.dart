import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryEntitiy>>> getCategories({
    required int skip,
    int limit = 10,
  });
  Future<Either<Failure, List<ProviderEntity>>> getProviders({
    required int skip,
    int limit = 10,
  });
}
