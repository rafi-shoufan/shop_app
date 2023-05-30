import 'dart:async';
import 'dart:io';
import 'package:advanced/domain/usecase/register_usecase.dart';
import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:advanced/presentation/common/freezed.dart';
import 'package:advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInputs , RegisterViewModelOutputs{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
//  final StreamController _countryCodeStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController _allInputsAreValidStreamController = StreamController<String>.broadcast();
  final StreamController userIsRegisteredStreamController = StreamController<bool>();


  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);


  var registerObject = RegisterObject('', '', '', '', '', '');

  @override
  Sink get allInputsAreValid => _allInputsAreValidStreamController.sink;

  // @override
  // Sink get inputCountryCode => _countryCodeStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;


  @override
  Stream<bool> get outAllInputsAreValid => _allInputsAreValidStreamController.stream.map((_) => _allInputsAreValid());

  // @override
  // Stream<bool> get outIsCountryCodeValid => _countryCodeStreamController.stream.map((countryCode) => _isCountryCodeValid(countryCode));

  @override
  Stream<bool> get outIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outErrorEmail =>
      outIsEmailValid.map((isEmail) =>
      isEmail ? null : AppStrings.invalidEmail.tr()
      );

  @override
  Stream<bool> get outIsMobileNumberValid => _mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outErrorMobileNumber =>
      outIsMobileNumberValid.map((isMobileNumber) =>
      isMobileNumber ? null : AppStrings.invalidMobileNumber.tr()
      );

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outErrorPassword =>
      outIsPasswordValid.map((isPassword) =>
      isPassword ? null : AppStrings.invalidPassword.tr()
      );

  @override
  Stream<File> get outIsProfilePictureValid => _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outErrorUserName =>
      outIsUserNameValid.map((isUserName) =>
      isUserName ? null :  /// رجعنا null لانو لو رجعنا بال register view نص ما رح يعود زر ال register يشتغل متل ما بدنا
      AppStrings.userNameInvalid.tr());

  @override
  register() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState,));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.email,
      registerObject.password,
      registerObject.countryCode,
      registerObject.mobileNumber,
      registerObject.name,
      registerObject.profilePicture,
    ))).fold((l) {
      inputState.add(ErrorState(stateRendererType: StateRendererType.popupErrorStateRenderer, message: l.message));
    }, (r) {
      inputState.add(ContentState());
      userIsRegisteredStreamController.add(true);
    });

  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty){
      registerObject = registerObject.copyWith(countryCode: countryCode);
    }else{
      registerObject = registerObject.copyWith(countryCode: '');
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      /// update register view object
      registerObject = registerObject.copyWith(email: email);
    }else{
      /// reset email value in register view object
      registerObject = registerObject.copyWith(email: '');
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)){
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }else{
      registerObject = registerObject.copyWith(mobileNumber: '');
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      registerObject = registerObject.copyWith(password: password);
    }else{
      registerObject = registerObject.copyWith(password: '');
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    }else{
      registerObject = registerObject.copyWith(profilePicture: '');
    }
    validate();
  }

  @override
  setUserName(String name) {
    inputUserName.add(name);
    if(_isUserNameValid(name)){
      registerObject = registerObject.copyWith(name: name);
    }else{
      registerObject = registerObject.copyWith(name: '');
    }
    validate();
  }

  @override
  void start() {
    /// بالبداية اعرضلي البيانات
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
   // _countryCodeStreamController.close();
    _profilePictureStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _allInputsAreValidStreamController.close();
    userIsRegisteredStreamController.close();
  }

  bool _isUserNameValid(String userName){
    return userName.length >=8;
  }

  bool _isPasswordValid(String password){
    return password.length >= 6;
  }
  bool _isCountryCodeValid(String countryCode){
    return countryCode.isNotEmpty;
  }
  // bool _isEmailValid(String email){
  //   return email.isNotEmpty;
  // }
  bool _isMobileNumberValid(String mobileNumber){
    return mobileNumber.length >=10;
  }
  // bool _isProfilePictureValid(String profilePicture){
  //   return profilePicture.isNotEmpty;
  // }
  bool _allInputsAreValid(){
    return
      registerObject.name.isNotEmpty&&
      registerObject.profilePicture.isNotEmpty&&
      registerObject.mobileNumber.isNotEmpty&&
      registerObject.email.isNotEmpty&&
      registerObject.password.isNotEmpty&&
      registerObject.countryCode.isNotEmpty;

  }
  validate(){
    allInputsAreValid.add(null);
  }
}


abstract class RegisterViewModelInputs{

  register();
  setUserName(String name);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  //Sink get inputCountryCode;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get allInputsAreValid;

}

abstract class RegisterViewModelOutputs{

  Stream<bool> get outIsUserNameValid;
  Stream<String?> get outErrorUserName;

  Stream<bool> get outIsPasswordValid;
  Stream<String?> get outErrorPassword;

  //Stream<bool> get outIsCountryCodeValid;
  Stream<bool> get outIsMobileNumberValid;
  Stream<String?> get outErrorMobileNumber;

  Stream<bool> get outIsEmailValid;
  Stream<String?> get outErrorEmail;

  Stream<File> get outIsProfilePictureValid;

  Stream<bool> get outAllInputsAreValid;

}