
import 'package:advanced/presentation/resources/assets_manager.dart';
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/font_manager.dart';
import 'package:advanced/presentation/resources/styles_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/strings_manager.dart';

enum StateRendererType{

  /// popup state renderer
  popupLoadingState,
  popupErrorStateRenderer,

  /// full screen state renderer
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyPopupState,

  /// content state
  contentState
}

class StateRenderer extends StatelessWidget {

  String message;
  String title;
  StateRendererType stateRendererType;
  Function  retryActionFunction;

  StateRenderer({
    this.message = AppStrings.loading,
    this.title = '',
    required this.stateRendererType,
    required this.retryActionFunction
});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);

  }

  Widget _getStateWidget(context){
    switch(stateRendererType){
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(
            context, [
          _getAnimatedImage(JsonAssets.loading)
        ]);
      case StateRendererType.popupErrorStateRenderer:
        return _getPopupDialog(
            context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr() , context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [
              _getAnimatedImage(JsonAssets.loading),
              _getMessage(message),
            ]
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(
            [
              _getAnimatedImage(JsonAssets.error),
              _getMessage(message),
              _getRetryButton(AppStrings.retryAgain.tr() , context),
            ]
        );
      case StateRendererType.fullScreenEmptyPopupState:
        return _getItemsColumn(
            [
              _getAnimatedImage(JsonAssets.empty),
              _getMessage(message),
            ]
        );
      case StateRendererType.contentState:
        return Container();
      default : return Container();
    }
  }

  Widget _getPopupDialog(context,List<Widget> children){
        return Dialog(
          elevation: AppSize.s1_5,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                color: ColorManager.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26
                  )
                ]
            ),
            child: _getDialogContent(context,children),
          ),
        );
  }
  Widget _getDialogContent(context,List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,  /// هاي مشان ياحد ال dialog ((((بس)))) حجم العناصر يلي بقلبو
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String jsonName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(jsonName),
    );
  }

  Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularTextStyle(color: ColorManager.black,fontSize: FontSize.s18),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle , context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed:(){
                if(stateRendererType == StateRendererType.fullScreenErrorState){
                  retryActionFunction.call();
                }else{
                  Navigator.pop(context);
                }
              }, child: Text(buttonTitle)
          ),
        ),
      ),
    );
  }
}
