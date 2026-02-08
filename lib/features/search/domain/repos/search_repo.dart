import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProviderEntity>>> search({
    required String searchString,
    required int searchId,
    required int skip, // إضافة skip parameter
    required int limit, // إضافة limit parameter
  });
}
