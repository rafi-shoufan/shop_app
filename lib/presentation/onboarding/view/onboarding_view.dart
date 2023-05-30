import 'package:advanced/presentation/resources/assets_manager.dart';
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/app_preferences.dart';
import '../../../app/dependency_injection.dart';
import '../../../domain/models/models.dart';
import '../../resources/constants_manager.dart';
import '../view_model/onboarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  PageController controller = PageController();
  OnBoardingViewModel viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();


  _bind(){
    _appPreferences.setOnBoardingScreenViewed();
   viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject ? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          // systemOverlayStyle:const SystemUiOverlayStyle(
          //   //  statusBarColor: Colors.transparent,
          //   //  statusBarBrightness: Brightness.dark
          // ),

        ),
        body: PageView.builder(
          onPageChanged: (index) {
            viewModel.onPageChanged(index);
          },
          controller: controller,
          itemBuilder: (context, index) => OnBoardingPage(sliderViewObject.sliderObject),
          itemCount: sliderViewObject.numOfSlides,
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          //width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    }, child: Text(
                  AppStrings.skip.tr(),
                  textAlign: TextAlign.end,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,)
                ),
              ),
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }
  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject){
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              onTap: (){
                controller.animateToPage(
                    viewModel.goPrevious(),
                    duration: const Duration(
                      milliseconds:AppConstants.sliderAnimationTime
                    ),
                    curve: Curves.bounceInOut
                );
              },
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(
                      ImageAssets.leftArrowIc
                  ),
                )
            ),
          ),
          Row(
            children: [
              for(int i = 0 ; i< sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i,sliderViewObject.currentIndex ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
                onTap: (){
                  controller.animateToPage(
                      viewModel.goNext(),
                      duration: const Duration(
                          milliseconds:AppConstants.sliderAnimationTime
                      ),
                      curve: Curves.bounceInOut
                  );
                },
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(
                      ImageAssets.rightArrowIc
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }


  Widget _getProperCircle(int index , int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  // int _getPreviousIndex() {
  //   int previousIndex = --currentIndex  ;
  //   if(previousIndex == -1){
  //     previousIndex = _list.length-1;
  //   }
  //   return previousIndex;
  // }

  // int _getNextIndex() {
  //   int nextIndex = currentIndex ++ ;
  //   if(nextIndex == _list.length){
  //     nextIndex = 0;
  //   }
  //   return nextIndex;
  // }
}

class OnBoardingPage extends StatelessWidget {

  final SliderObject  _sliderObject;
  const OnBoardingPage(this._sliderObject, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.displayLarge ,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            style:Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSize.s60,),
        SvgPicture.asset(_sliderObject.image),

      ],
    );
  }
}

