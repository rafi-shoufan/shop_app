import 'dart:async';
import 'package:advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';


abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  final StreamController _inputStreamController = BehaviorSubject<FlowState>();
  @override
  void dispose(){
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;
  
  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
}
abstract class BaseViewModelInputs{

  void start();

  void dispose();

  Sink get inputState ;

}

abstract class BaseViewModelOutputs{
  Stream<FlowState> get outputState ;
}
