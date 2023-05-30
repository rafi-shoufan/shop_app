import 'package:advanced/app/constants.dart';
import 'package:advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();

  String getMessage();
}

/// loading state (popup , full screen)

class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String ? message ;
  LoadingState({
    required this.stateRendererType,
    String message = AppStrings.loading
});

  @override
  String getMessage() {
    return message ?? AppStrings.loading.tr();
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }

}

/// error state (popup , full screen)

class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String  message ;
  ErrorState({
    required this.stateRendererType,
    required this.message
  });

  @override
  String getMessage() {
    return message ;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }

}


/// content state

class ContentState extends FlowState{

  ContentState();

  @override
  String getMessage() {
    return Constants.emptyString;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.contentState;
  }

}

/// empty state

class EmptyState extends FlowState{

  String message;
  EmptyState(this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.fullScreenEmptyPopupState;
  }

}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context , Widget contentScreenWidget,Function retryActionFunction){
    switch(runtimeType){
      case LoadingState :
        if(getStateRendererType() == StateRendererType.popupLoadingState){
          print('loading popup');
          /// show popup loading
          showPopup(context, getStateRendererType(), getMessage());
          /// show screen content
          return contentScreenWidget;
        }else{
          /// full screen loading state
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType:getStateRendererType() ,
            message: getMessage(),
          );
        }
      case ErrorState :
        dismissDialog( context);
        if(getStateRendererType() == StateRendererType.popupErrorStateRenderer){
          /// show popup error
          print('popup error state');
          showPopup(context, getStateRendererType(), getMessage());
          /// show screen content
          return contentScreenWidget;
        }else{
          /// full screen loading state
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType:getStateRendererType(),
            message: getMessage(),
          );
        }
      case EmptyState :
          return StateRenderer(
            retryActionFunction: (){}, /// (){} هاي الحركة عملناها لانو التابع required بس انا ما بدي أبعت تابع
            stateRendererType:getStateRendererType() ,
            message: getMessage(),
          );

      case ContentState :
        dismissDialog( context);
        return contentScreenWidget;
      default :
        dismissDialog( context);
        return contentScreenWidget;
    }
  }

  showPopup(BuildContext context , StateRendererType stateRendererType , String message){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(context: context, builder: (context) =>
            StateRenderer(stateRendererType: stateRendererType, retryActionFunction: (){}),
        )
    );
  }

  bool _isCurrentDialogShowing(BuildContext context){
    return ModalRoute.of(context)?.isCurrent != true;   /// اذا رجعت true معناها في daialog مفتوح
  }
  dismissDialog(BuildContext context){
    print('_isCurrentDialogShowing is : '  );
    print( _isCurrentDialogShowing(context) );
    if(_isCurrentDialogShowing(context)){

      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}