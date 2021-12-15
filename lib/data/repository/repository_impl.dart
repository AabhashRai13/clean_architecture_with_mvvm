import 'package:clean_architecture_with_mvvm/data/data_source/remote_data_source.dart';
import 'package:clean_architecture_with_mvvm/data/mapper/mapper.dart';
import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/domain/model.dart';
import 'package:clean_architecture_with_mvvm/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its safe to call the API
      final response = await _remoteDataSource.login(loginRequest);

      try {
        if (response.status == 0) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
