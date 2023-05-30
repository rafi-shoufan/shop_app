import 'package:advanced/app/app_preferences.dart';
import 'package:advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../app/dependency_injection.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();


  _bind(){
    _appPreferences.setUserLoggedIn ();
    _loginViewModel.start();
    _userNameController.addListener(() { 
       _loginViewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() => _loginViewModel.setPassword(_passwordController.text));
    _loginViewModel.userIsLoggedInStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn){
         /// بما انو عندي context وبدي أستخدم ال navigator ضمن ال stream controller لازم حط السطر التالي
        SchedulerBinding.instance.addPostFrameCallback((_) {
          /// navigate to main screen
          _appPreferences.setUserLoggedIn();
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outputState,
        builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context ,
                _getContentWidget(),
                    (){
              _loginViewModel.login();
                    })??_getContentWidget();
         },
      ),
    );
  }

  _getContentWidget(){
    return Container(
          padding: const EdgeInsets.only(top: AppPadding.p100),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: StreamBuilder<bool>( /// عملنا الستريم بيلدر من نوع بوليان لانو outIsUserNameValid نوعو بوليان
                      stream: _loginViewModel.outIsUserNameValid,
                      builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: AppStrings.username.tr() ,
                          labelText: AppStrings.username.tr(),
                          errorText: (snapshot.data??true)?null:AppStrings.usernameError.tr(),
                        ),
                      );
                    },
                    ),
                  ),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: StreamBuilder<bool>( /// عملنا الستريم بيلدر من نوع بوليان لانو outIsPasswordValid نوعو بوليان
                      stream: _loginViewModel.outIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: AppStrings.password.tr() ,
                            labelText: AppStrings.password.tr(),
                            errorText: (snapshot.data??true)?null:AppStrings.passwordError.tr(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s28),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _loginViewModel.outAllInputsAreValid,
                      builder: (context, snapshot) {
                        return SizedBox( /// هاي الويدجت مشان أعطيه عرض
                          height: AppSize.s40,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed:
                                (snapshot.data??false)
                                    ? () {
                                  _loginViewModel.login();
                                }
                                    :null,
                              child:  Text(
                                AppStrings.login.tr()
                              )
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p8,left: AppPadding.p28, right: AppPadding.p28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.forgotPasswordRoute
                              );
                            }, child: Text(
                          AppStrings.forgetPassword.tr(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,)
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.registerRoute);
                            }, child: Text(
                          AppStrings.registerText.tr(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,)
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
