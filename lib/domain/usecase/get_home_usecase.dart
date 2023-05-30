import 'package:advanced/app/dependency_injection.dart';
import 'package:advanced/data/network/failure.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/repository/repository.dart';

import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject> {
  /// TODO : try this line
 // final Repository _repository = instance<Repository>();
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.getHomeData();
  }

}