import 'dart:async';

import 'package:restaurants_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  // shared variables and functions that will be used through any view model
  StreamController _inputStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInput {
  void start(); // start view model jop

  void dispose(); // will be called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}
