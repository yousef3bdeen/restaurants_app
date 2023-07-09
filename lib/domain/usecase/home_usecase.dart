import 'package:restaurants_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurants_app/domain/model/models.dart';
import 'package:restaurants_app/domain/repository/repository.dart';
import 'package:restaurants_app/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
