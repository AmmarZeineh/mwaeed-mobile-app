import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/home/data/models/provider_model.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/search/domain/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final Api _api;
  SearchRepoImpl(this._api);

  @override
  Future<Either<Failure, List<ProviderEntity>>> search({
    required String searchString,
    required int searchId,
    required int skip,
    required int limit,
  }) async {
    try {
      var response = await _api.post(
        url: '$baseUrl/user/search?skip=$skip&limit=$limit',
        token: null,
        body: {'search': searchString, 'number': searchId},
      );
      List<ProviderEntity> providers = [];
      for (var i = 0; i < response['data'].length; i++) {
        providers.add(ProviderModel.fromJson(response['data'][i]).toEntity());
      }
      return Right(providers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
