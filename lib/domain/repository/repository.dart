
import 'package:advanced/data/network/requests.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
abstract class Repository{
   Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);

}

