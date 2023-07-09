// import 'dart:async';
// import 'dart:ffi';

// import 'package:mvvm_app/domain/model/models.dart';
// import 'package:mvvm_app/presentation/base/baseviewmodel.dart';

// import '../../../../../domain/usecase/home_usecase.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../../../common/state_renderer/state_renderer.dart';
// import '../../../../common/state_renderer/state_renderer_impl.dart';

// class HomeViewModel extends BaseViewModel
//     with HomeViewModelInput, HomeViewModelOutput {
//   final StreamController _bannersStreamController =
//       BehaviorSubject<List<BannerAd>>();
//   final StreamController _servicesStreamController =
//       BehaviorSubject<List<Service>>();
//   final StreamController _storesStreamController =
//       BehaviorSubject<List<Store>>();

//   final HomeUseCase _homeUseCase;
//   HomeViewModel(this._homeUseCase);

//   @override
//   void start() {
//     _getHomeData();
//   }

//   _getHomeData() async {
//     inputState.add(LoadingState(
//         stateRendererType: StateRendererType.fullScreenLoadingState));
//     (await _homeUseCase.execute(Void)).fold(
//         (failure) => {
//               // left -> failure
//               inputState.add(ErrorState(
//                   StateRendererType.popupErrorState, failure.message))
//             }, (homeObject) {
//       // right -> data (success)
//       // content
//       inputState.add(ContentState());
//       inputBanners.add(homeObject.data?.banners);
//       inputServices.add(homeObject.data?.services);
//       inputStores.add(homeObject.data?.stores);
//     });
//   }

//   @override
//   void dispose() {
//     _bannersStreamController.close();
//     _servicesStreamController.close();
//     _storesStreamController.close();
//     super.dispose();
//   }

//   // --inputs
//   @override
//   Sink get inputBanners => _bannersStreamController.sink;

//   @override
//   Sink get inputServices => _servicesStreamController.sink;

//   @override
//   Sink get inputStores => _storesStreamController.sink;

//   // --outputs
//   @override
//   Stream<List<BannerAd>> get outputBanner =>
//       _bannersStreamController.stream.map((banners) => banners);

//   @override
//   Stream<List<Service>> get outputService =>
//       _servicesStreamController.stream.map((services) => services);
//   @override
//   Stream<List<Store>> get outputStores =>
//       _storesStreamController.stream.map((stores) => stores);
// }

// abstract class HomeViewModelInput {
//   Sink get inputStores;
//   Sink get inputServices;
//   Sink get inputBanners;
// }

// abstract class HomeViewModelOutput {
//   Stream<List<Store>> get outputStores;
//   Stream<List<Service>> get outputService;
//   Stream<List<BannerAd>> get outputBanner;
// }

// ways 2
import 'dart:async';
import 'dart:ffi';

import 'package:restaurants_app/domain/model/models.dart';
import 'package:restaurants_app/presentation/base/baseviewmodel.dart';

import '../../../../../domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popupErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  // --inputs
  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // --outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
