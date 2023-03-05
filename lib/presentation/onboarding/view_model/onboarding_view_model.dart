import 'dart:async';

import 'package:advanced/domain/models/models.dart';
import 'package:advanced/presentation/base/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{

  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list ;
  int currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = currentIndex ++ ;
    if(nextIndex == _list.length){
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  goPrevious() {
    int previousIndex = --currentIndex  ;
    if(previousIndex == -1){
      previousIndex = _list.length-1;
    }
    return previousIndex;
  }

  @override
  onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }


  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((event) => event);


  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubtitle1, ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubtitle2, ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubtitle3, ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubtitle4, ImageAssets.onBoardingLogo4),
  ];

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(
            _list[currentIndex],
            currentIndex,
            _list.length
        )
    );
  }
}


abstract class OnBoardingViewModelInputs{
  int goNext();
  int goPrevious();
  onPageChanged(int index);
  Sink get inputSliderViewObject;

}


abstract class OnBoardingViewModelOutputs{

  Stream<SliderViewObject> get outputSliderViewObject;

}