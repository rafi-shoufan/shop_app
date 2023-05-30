import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed.freezed.dart';

@freezed
class LoginObject with _$LoginObject{

  factory LoginObject (String userName , String password) = _LoginObject;

}

@freezed
class RegisterObject with _$RegisterObject{

  factory RegisterObject (
  String email,
  String password,
  String name,
  String profilePicture,
  String countryCode,
  String mobileNumber,
  ) = _RegisterObject;
}


@freezed
class ForgotPasswordObject with _$ForgotPasswordObject{

  factory ForgotPasswordObject (String email) = _ForgotPasswordObject;

}
