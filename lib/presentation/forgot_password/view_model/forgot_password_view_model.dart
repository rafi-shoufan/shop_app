
import 'dart:async';

import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:advanced/presentation/common/freezed.dart';

import '../../../app/functions.dart';

class ForgotPasswordViewModel extends BaseViewModel with PasswordViewModelInputs , PasswordViewModelOutputs{

  final StreamController _emailStreamController = StreamController.broadcast();

  var forgotPasswordObject = ForgotPasswordObject('');

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _emailStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream get outIsEmailValid => _emailStreamController.stream.map(( email) => isEmail(email));

  @override
  resetPassword() {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
    if(isEmailValid(email)){
      forgotPasswordObject.copyWith(email: email);
    }else{
      forgotPasswordObject.copyWith(email: '');
    }
  }

  bool isEmail(String email){
    return isEmailValid( email)&&(email.isNotEmpty);
  }
}


abstract class PasswordViewModelInputs{
    resetPassword();
    Sink get inputEmail;
    setEmail(String email);
}

abstract class PasswordViewModelOutputs{

  Stream get outIsEmailValid;
}