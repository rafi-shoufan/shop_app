
import 'dart:async';
import 'dart:ffi';

import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/usecase/get_home_usecase.dart';
import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel with ViewModelInputs , ViewModelOutputs{

  final HomeUseCase _homeUseCase ;
  HomeViewModel(this._homeUseCase);

  final StreamController _bannersStreamController = BehaviorSubject<List<Banners>>();
  final StreamController _servicesStreamController = BehaviorSubject<List<Services>>();
  final StreamController _storesStreamController = BehaviorSubject<List<Stores>>();
  @override
  void start() {
    _getHomeData();

  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  @override
  Stream<List<Banners>> get outputBanners => _bannersStreamController.stream.map((banners) => banners );

  @override
  Stream<List<Services>> get outputServices => _servicesStreamController.stream.map((services) => services );

  @override
  Stream<List<Stores>> get outputStores => _storesStreamController.stream.map((stores) => stores );

  _getHomeData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (
        await _homeUseCase.execute(Void)
    ).fold(
            (l) => {
          inputState.add(ErrorState(stateRendererType: StateRendererType.fullScreenErrorState, message: l.message)),
        },
            (homeObject)  {
          /// content
          inputState.add(ContentState());
          inputBanners.add(homeObject.data!.banners);
          inputServices.add(homeObject.data!.services);
          inputStores.add(homeObject.data!.stores);
        }
    );
  }
}

abstract class ViewModelInputs {

  Sink get inputBanners;
  Sink get inputServices;
  Sink get inputStores;

}

abstract class ViewModelOutputs {

  Stream <List<Banners>> get  outputBanners;
  Stream <List<Services>> get  outputServices;
  Stream <List<Stores>> get  outputStores;
}