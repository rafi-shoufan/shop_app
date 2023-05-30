import 'package:advanced/data/network/failure.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/requests.dart';
import '../repository/repository.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{

  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) {
    return _repository.register(RegisterRequest(
      input.email,
      input.password,
      input.name,
      input.profilePicture,
      input.countryCode,
      input.mobileNumber,
    ));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String name;
  String profilePicture;
  String countryCode;
  String mobileNumber;

  RegisterUseCaseInput(
      this.email,
      this.password,
      this.countryCode,
      this.mobileNumber,
      this.name,
      this.profilePicture
      );
}