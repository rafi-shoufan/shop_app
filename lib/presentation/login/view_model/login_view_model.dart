import 'dart:async';

import 'package:advanced/domain/usecase/login_usecase.dart';
import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:advanced/presentation/common/freezed.dart';

class LoginViewModel extends BaseViewModel with ViewModelInputs , ViewModelOutputs{

  /// broadcast مشان ينبه كل يلي عميسمعوا يتنبهوا موش بس واحد
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _allInputsAreValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject('','');
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  /// inputs
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _allInputsAreValidStreamController.close();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    allInputsAreValid.add(null); /// حطينا null لانو الكونترولر فوق عملناه من نوع void
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    allInputsAreValid.add(null);  /// حطينا null لانو الكونترولر فوق عملناه من نوع void
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  // TODO: implement allInputsAreValid
  Sink get allInputsAreValid => _allInputsAreValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))).fold(
            (l) => {
              print(l.message)
            },
            (r) => {
              print(r.customer!.name)
            }
    );
  }

  /// outputs
  @override
  // TODO: implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  // TODO: implement outAllInputsAreValid
  Stream<bool> get outAllInputsAreValid => _allInputsAreValidStreamController.stream.map((event) => _allInputsAreValid());

  bool _isUserNameValid(String userName){
    return userName.isNotEmpty;
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _allInputsAreValid(){
    return _isUserNameValid(loginObject.userName) && _isPasswordValid(loginObject.password) ;
  }


}


abstract class ViewModelInputs{

  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get allInputsAreValid;

}

abstract class ViewModelOutputs{

  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAllInputsAreValid;

}