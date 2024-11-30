import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_pure/signalr_pure.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/models/car_class.dart';
import 'package:taxi_app/app/data/models/cobon.dart';
import 'package:taxi_app/app/data/models/driver.dart';
import 'package:taxi_app/app/data/models/order.dart';
import 'package:taxi_app/app/data/models/order_details.dart';
import 'package:taxi_app/app/data/models/payment_card.dart';
import 'package:taxi_app/app/data/models/place.dart';
import 'package:taxi_app/app/module/auth/controllers/auth_controller.dart';
import 'package:taxi_app/app/module/home/operation/map_operations.dart';
import 'package:taxi_app/app/provider/app/app_provider.dart';
import 'package:taxi_app/app/provider/customer/cobon/cobon_provider.dart';
import 'package:taxi_app/app/provider/customer/wallet/customer_cards_provider.dart';
import 'package:taxi_app/app/provider/order/order_provider.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';

class HomeController extends GetxController  {
  AuthController authController = Get.find<AuthController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var selectedIndex = 0.obs;
  void onTabSelected(int index) => selectedIndex.value = index;
  StreamSubscription<Position>? streamSubscription;
  TextEditingController cobonCode = TextEditingController();

  final RxBool _isReLoading = false.obs;
  RxBool get isReLoading => _isReLoading;

  final RxBool _isVerifyCobon = false.obs;
  bool get isVerifyCobon => _isVerifyCobon.value;

  final RxBool _isLoadingMap = true.obs;
  set isLoadingMap(bool value) {
    _isLoadingMap.value = value;
  }
  bool get isLoadingMap => _isLoadingMap.value;

  final RxBool _isLoadingOpenOrders = true.obs;
  bool get isLoadingOpenOrders => _isLoadingOpenOrders.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = true;

  final RxBool _isLoadingPreviusPlaces = true.obs;
  bool get isLoadingPreviusPlaces => _isLoadingPreviusPlaces.value;

  bool isSelectingOrigin = true;

  RxInt paymentType = 1.obs;
  RxBool isWalletPaymentEnabled = false.obs;
  Rx<Cobon> _cobon = Cobon().obs;
  set cobon(Cobon value) {
    _cobon.value = value;
  }

  Cobon get cobon => _cobon.value;

  Rx<OrderDetails> _orderDetails = OrderDetails().obs;
  OrderDetails get orderDetails => _orderDetails.value;
  Timer? _orderDetailsTimer = Timer(Duration.zero, () {});
  Timer? _nearDriverTimer = Timer(Duration.zero, () {});

  var currentLocation = LatLng(0, 0).obs;
  Rx<Position?> currentPosition = Rx<Position?>(null);
  var locationServiceEnabled = false.obs;
  var permissionGranted = false.obs;

  var carIcon = Rx<BitmapDescriptor?>(null);
  var currentocationIcon = Rx<BitmapDescriptor?>(null);
  var ProviderIcon = Rx<BitmapDescriptor?>(null);
  var destinationIcon = Rx<BitmapDescriptor?>(null);
  var originIcon = Rx<BitmapDescriptor?>(null);

  Rx<Place?> placeOrigin = Rx<Place?>(null);
  Rx<Place?> placeDestination = Rx<Place?>(null);

  var polylines = <Polyline>{}.obs;
  RxSet<Circle> _circles = RxSet<Circle>();
  Set<Circle> get circles => _circles;
  RxSet<Marker> driverMarkers = <Marker>{}.obs;
  Rx<Marker?> markerProvider = Rx<Marker?>(null);
  Rx<Marker?> markerOrigin = Rx<Marker?>(null);
  Rx<Marker?> markerDestination = Rx<Marker?>(null);
  Rx<Marker?> currentLocationMarkers = Rx<Marker?>(Marker(markerId: MarkerId('directionMarker'),position: LatLng(0,0)));
  RxSet<Marker> carMarkers = <Marker>{}.obs;
  GoogleMapController? myMapController;

  RxList<DriverModel> drivers = <DriverModel>[].obs;
  final RxString status = "selecting places".obs;

  RxList<Place> _previosPlaces = <Place>[].obs;
  RxList<Place> get previosPlaces => _previosPlaces;

  RxList<CarClass> _carClasses = <CarClass>[].obs;
  List<CarClass> get carClasses => _carClasses.value;
  Rx<CarClass> _selectedCarClass = CarClass().obs;

  set selectedCarClass(CarClass value) {
    _selectedCarClass.value = value;
  }

  CarClass get selectedCarClass => _selectedCarClass.value;

  RxList<PaymentCard> _paymentCards = <PaymentCard>[].obs;
  List<PaymentCard> get paymentCards => _paymentCards.value;

  Rx<PaymentCard> _selectedPaymentCard = PaymentCard().obs;
  set selectedPaymentCard(PaymentCard value) {
    _selectedPaymentCard.value = value;
  }

  PaymentCard get selectedPaymentCard => _selectedPaymentCard.value;

  int selectedRide = 0;

  late HubConnection connection;
  var isConnected = false.obs;
  var connectionState = HubConnectionState.disconnected.obs;
  final String url = 'https://api.faster.sa:7080/providerHubs';
  late final MapOperation mapOperation;

  @override
  void onInit() async {
    mapOperation = MapOperation(this);
       // await updateDeviceInfo();

    await  mapOperation.initializeIcons();
    await  mapOperation.checkLocationPermission(isFirstLaunch: true);
    await getOpenOrdersIds();
     // _nearDriverTimer=Timer.periodic(Duration(seconds: 10),(_)async=>await GetNearProviderToCustomer());
   await getCustomerPreviousTaxiLocations();
    // _listenToLocationChanges();
    super.onInit();
  }

  Future<void> _initSignalR() async {

    final token = CommonVariables.userData.read("token");
    if (token == null) {
      print('Token is null, cannot establish SignalR connection.');
      return;
    }
    final httpOptions = HttpConnectionOptions(
      skipNegotiation: false,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final builder = HubConnectionBuilder()
      ..url = url
      ..logLevel = LogLevel.information
      ..httpConnectionOptions = httpOptions
      ..reconnect = true;

    connection = builder.build();

    // Handling all connection states
    connection.onclose((error) {
      connectionState.value = HubConnectionState.disconnected;
      print('Connection closed: ${error?.toString() ?? "No error"}');
    });
    connection.onreconnected((connectionId) {
      connectionState.value = HubConnectionState.connected;
      print('Reconnected with ID: $connectionId');
    });
    connection.onreconnecting((error) {
      connectionState.value = HubConnectionState.reconnecting;
      print('Reconnecting due to: ${error?.toString() ?? "No error"}');
    });
    try {
      await connection.startAsync();
      connectionState.value = HubConnectionState.connected;
      print('Connection status is connected');
      _nearDriverTimer!.cancel();
    } catch (e) {
      connectionState.value = HubConnectionState.disconnected;
      print('Failed to start the connection: $e');
      return;
    }
    if (connection.state == HubConnectionState.connected) {
      await connection.sendAsync('CheckConnection', []);
      // Listening for events from the server
      connection.on('ConnectionStatues', (args) {
        print('Received from ConnectionStatues: $args');
      });
      await connection.sendAsync('trackingProvider', [_orderDetails.value.providerData!.provderId!]);
      connection.on("BroadcastLocation", (location) {
        mapOperation.setProviderMarker(LatLng(location[1], location[0]));
      });
    } else {
      print('Failed to connect, current state: ${connection.state}');
    }
    print('---------------------------- SignalR Initialization Complete ----------------------------');
  }
  Future<void>GetNearProviderToCustomer()async{
    final result = await OrderProvider.GetNearProviderToCustomer(
      lat: currentPosition.value!.latitude,
      lng: currentPosition.value!.longitude,
    );
    result.fold((ifLeft)async{
      mapOperation.setDriversMarkers(ifLeft);
      update();
    }, (ifRight){

    });
  }
  Future<void> getCarClassesWithPrices() async {
    _isReLoading(true);
    final result = await OrderProvider.getCarClassWithPrice(
        origin: placeOrigin.value != null
            ? LatLng(
                placeOrigin.value!.latitude!, placeOrigin.value!.longitude!)
            : LatLng(currentPosition.value!.latitude,
                currentPosition.value!.longitude),
        destination: LatLng(placeDestination.value!.latitude!,
            placeDestination.value!.longitude!));
    _isReLoading(false);
    result.fold((l) {
      _carClasses(l);
      status.value = "selecting vehicle";
      update();
    }, (r) {
      print(r);
    });
  }
  Future<void> getCustomerPreviousTaxiLocations() async {
    _isLoadingPreviusPlaces(true);
    final result = await OrderProvider.getCustomerPreviousTaxiLocations();
    _isLoadingPreviusPlaces(false);
    result.fold((l) {
      _previosPlaces(l);
      update();
    }, (r) {
      print(r);
    });
  }
  Future<void> getPaymentCards() async {
    _isReLoading(true);
    final result = await CustomerCardsProvider.getPaymentCards();
    _isReLoading(false);
    result.fold((l) {
      _paymentCards(l);
      if (_paymentCards.length != 0) {
        _selectedPaymentCard.value = _paymentCards.value.first;
      }
      status.value = "selecting payment";
      // // controller.  status.value = "selecting places";

      update();
    }, (r) {
      print(r);
    });
  }

  Future<void> checkCobon() async {
    _isVerifyCobon(true);
    final result = await CobonProvider.checkCobon(
        code: cobonCode.text,
        orderAmount: _selectedCarClass.value.offerPrice!,
        shopBranchId: 0);
    _isVerifyCobon(false);
    result.fold((l) {
      _cobon(l);
    }, (r) {
      showSnackbar(
          title: "Error",
          message: r != "Cobone Not Found"
              ? "Cobone Not Found".tr
              : "Connection error".tr,
          isError: true);
    });
  }

  Future<void> addOrder() async {
    if(_orderDetails.value.id != null) {
      await  recurringPayments(orderId: _orderDetails.value.id);
      return;
    }
    final order = TripOrder(
      orderLatitude: placeDestination.value!.latitude!,
      orderLongitude: placeDestination.value!.longitude!,
      orderDescriptionLocation: placeDestination.value!.address!,
      customerLatitude: placeOrigin.value!.latitude!,
      customerLongitude: placeOrigin.value!.longitude!,
      customerDescriptionLocation: placeOrigin.value!.address!,
      orderType: 2,
      payType: paymentType.value,
      gender: 1,
      bookingDate: DateTime.now().toString(),
      customerId: 1,
      carClassId: _selectedCarClass.value.id!,
      coboneId: _cobon.value.id ?? 0,
      total: selectedCarClass.offerPrice,
      // total:1,
      coboneValue: _cobon.value.amount ?? 0.0,
      statues: 1,
    );
    final data = order.toJson();
    _isLoading(true);
    final result = await OrderProvider.addOrder(data: data);
    result.fold((l) async {

      if( paymentType.value == 1) {
        await getTransportOrderById(id: l);
        _isLoading(false);
      } else if  ( paymentType.value == 2) {
        await recurringPayments(orderId: l);
      }
      update();
    }, (r) {
      _isLoading(false);
      if (r == "You have opened order try again after it completed") {
        showSnackbar(title: "", message: r, isError: true);
      } else
        showSnackbar(title: "", message: r);
    });
  }
  Future<void> recurringPayments({int? orderId}) async {
    // _isLoading(true);
    // final result = await OrderProvider.recurringPayments(
    //   // amount: (selectedCarClass.offerPrice ?? 0) - (cobon.amount ?? 0),
    //   amount:0,
    //   orderId: orderId,
    //   token: _selectedPaymentCard.value.token!,
    // );
    // _isLoading(false);
    // result.fold((l) async{
    //   await getTransportOrderById(id: orderId);
    // }, (r) async{
    //    await cancelOrderCustomer();
    //   showSnackbar(title: "", message: "Payment error".tr, isError: true);
    // });
  }
  Future<void> getOpenOrdersIds() async {
    _isLoadingOpenOrders(true);
    final result = await OrderProvider.getOpenOrdersIds();
    result.fold((l) async {
      if (l.length != 0) {
        status.value = "order details";
        showSnackbar(title: "", message: l.toString());
        await getTransportOrderById(id: l.elementAt(0));
      } else
        _isLoadingOpenOrders(false);
      update();
    }, (r) {
      _isLoadingOpenOrders(false);
      print(r);
    });
  }

  Future<void> getTransportOrderById({int? id}) async {
    final result = await OrderProvider.getTransportOrderById(id: id);
    _isLoadingOpenOrders(false);
       result.fold((l) async {
         status.value = "order details";
         _orderDetails(l);
         mapOperation.setOriginMarker(LatLng(_orderDetails.value.customerLatitude!,
          _orderDetails.value.customerLongitude!));
         mapOperation. setDestinationMarker(LatLng(_orderDetails.value.orderLatitude!,
          _orderDetails.value.orderLongitude!));
         // showSnackbar(title: "", message: l.toJson().toString());

         if (_orderDetails.value.providerData != null) {
        _orderDetailsTimer!.cancel();
        await _initSignalR();
      }
      else {
        if (!_orderDetailsTimer!.isActive) {
          _orderDetailsTimer = Timer.periodic(Duration(seconds: 7), (timer) async {
            getTransportOrderById(id: id); // Call the function every 7 seconds
          });
        }
      }
         mapOperation.focusCameraOnMarkers();
      update();
    }, (r) {
      showSnackbar(
        title: "",
        message: r,
      );
    });
  }

  Future<void> cancelOrderCustomer() async {
    _isLoading(true);
    final result =
        await OrderProvider.cancelOrderCustomer(orderId: orderDetails.id!);
    _isLoading(false);
    result.fold((l) {
         clearMarkersAndOrderDetails();
         // _nearDriverTimer=Timer.periodic(Duration(seconds: 10),(_)async=>await GetNearProviderToCustomer());
    }, (r) {

         showSnackbar(title: "", message: r, isError: true);
    });
  }

  Future<void> updateDeviceInfo() async {
    String? token = await FirebaseMessaging.instance.getToken();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? name;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      name = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      name = iosInfo.name;
    }

    final result = await AppProvider.updateFireBaseToken(
        token: token, frontEndDevice: name);

    result.fold((l) {}, (r) {
      print(r);
    });
  }
  // Function to clear markers
  Future<void> clearMarkersAndOrderDetails() async {
    _orderDetailsTimer!.cancel();
    _orderDetails(null);
    status.value = "selecting places";
    markerOrigin.value = null;
    markerDestination.value = null;
    placeDestination.value = null;
    polylines.clear();
    _selectedPaymentCard(null);
    _selectedCarClass(null);
    _cobon(null);
    paymentType.value = 1;
    isWalletPaymentEnabled.value = false;
    cobonCode.clear();
  //  mapOperation.focusCameraOnMarkers();
    mapOperation.updateLocation(currentPosition.value!);
    update();
  }
}
