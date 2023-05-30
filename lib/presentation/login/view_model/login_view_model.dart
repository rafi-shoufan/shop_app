import 'dart:async';
import 'package:advanced/domain/usecase/login_usecase.dart';
import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:advanced/presentation/common/freezed.dart';
import 'package:advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs , LoginViewModelOutputs{

  /// broadcast مشان ينبه كل يلي عميسمعوا يتنبهوا موش بس واحد
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController userIsLoggedInStreamController = StreamController<bool>();
  final StreamController _allInputsAreValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject('','');
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  /// inputs
  @override
  void start() {
    /// view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _allInputsAreValidStreamController.close();
    userIsLoggedInStreamController.close();
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
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (
        await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))
    ).fold(
            (l) => {
              inputState.add(ErrorState(stateRendererType: StateRendererType.popupErrorStateRenderer, message: l.message)),
              print(l.message)
            },
            (r) => {
              /// content
              inputState.add(ContentState()),
              print(r.customer!.name),
              /// navigate to main screen
              userIsLoggedInStreamController.add(true)
            }
    );
  }

  /// outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAllInputsAreValid => _allInputsAreValidStreamController.stream.map((event) =>  _allInputsAreValid());

  bool _isUserNameValid(String userName){
    return userName.length >=8;
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _allInputsAreValid(){
    return _isUserNameValid(loginObject.userName) && _isPasswordValid(loginObject.password) ;
  }
}


abstract class LoginViewModelInputs{

  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get allInputsAreValid;

}

abstract class LoginViewModelOutputs{

  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAllInputsAreValid;

}