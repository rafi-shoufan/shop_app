import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

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

  _bind(){
    _loginViewModel.start();
    _userNameController.addListener(() { 
       _loginViewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  _getContentWidget(){
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
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
                          hintText: AppStrings.username ,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data??true)?null:AppStrings.usernameError,
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
                            hintText: AppStrings.password ,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data??true)?null:AppStrings.passwordError,
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
                              child: const Text(
                                AppStrings.login
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
                          AppStrings.forgetPassword,
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
                          AppStrings.registerText,
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
        ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
