import 'dart:io';

import 'package:advanced/app/app_preferences.dart';
import 'package:advanced/app/constants.dart';
import 'package:advanced/app/dependency_injection.dart';
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final key = GlobalKey<FormState>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  void _bind() {
    _registerViewModel.start();
    _userNameController.addListener(() {
      _registerViewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text);
    });
    _mobileNumberController.addListener(() {
      _registerViewModel.setMobileNumber(_mobileNumberController.text);
    });
    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text);
    });
    _registerViewModel.userIsRegisteredStreamController.stream.listen((isRegistered) {
      if(isRegistered){
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _appPreferences.setUserLoggedIn();
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
            color: ColorManager.primary
        ),
        elevation: AppSize.s0,
      ),
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context,
              _getContentWidget(),
                  () {
                _registerViewModel.register();
              }) ?? _getContentWidget();
        },
      ),
    );
  }

  _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p28),
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(

                  /// عملنا الستريم بيلدر من نوع سترينغ لانو outIsUserNameValid نوعو سترينغ
                  stream: _registerViewModel.outErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Row(
                    children: [

                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            _registerViewModel.setCountryCode(
                                country.dialCode ?? Constants.token);
                          },
                          hideMainText: true,
                          initialSelection: '+02',
                          favorite: const ['+39', 'FR', '+966'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),

                      ),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(

                          /// عملنا الستريم بيلدر من نوع سترينغ لانو outIsUserNameValid نوعو سترينغ
                          stream: _registerViewModel.outErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber.tr(),
                                labelText: AppStrings.mobileNumber.tr(),
                                errorText: snapshot.data,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _registerViewModel.outErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _registerViewModel.outErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18),

              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                        border: Border.all(
                            color: ColorManager.grey
                        )
                    ),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
                  )
              ),
              const SizedBox(height: AppSize.s40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _registerViewModel.outAllInputsAreValid,
                  builder: (context, snapshot) {
                    return SizedBox(

                      /// هاي الويدجت مشان أعطيه عرض
                      height: AppSize.s40,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed:
                          (snapshot.data ?? false)
                              ? () {
                            _registerViewModel.register();
                          }
                              : null,
                          child:  Text(
                              AppStrings.register.tr()
                          )
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, child: Text(
                      AppStrings.alreadyHaveAccount.tr(),
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
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppStrings.profilePicture.tr(),

            ),
          ),
          Flexible(child: StreamBuilder<File>(
            stream: _registerViewModel.outIsProfilePictureValid,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc)),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File ? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(   ///  هاي مشان السطر يلي بيكون بسفل الموبايلات بالعادة تبع الرجوع و ....
              child: Wrap(   ///  هي عبارة عن column بس حسب ال direction
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera) ,
                    trailing: const Icon(Icons.arrow_forward),
                    title:  Text(AppStrings.photoGallery.tr()),
                    onTap: (){
                      _imageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined) ,
                    trailing: const Icon(Icons.arrow_forward),
                    title:  Text(AppStrings.photoCamera.tr()),
                    onTap: (){
                      _imageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
          ) ;
        },
    );
  }
   _imageFromGallery() async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image?.path ?? ''));
  }

   _imageFromCamera() async{
     var image = await _imagePicker.pickImage(source: ImageSource.camera);
     _registerViewModel.setProfilePicture(File(image?.path ?? ''));

   }

}