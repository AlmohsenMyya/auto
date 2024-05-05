import 'dart:async';

import 'package:auto/core/enums/connectivity_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((event) {
      connectivityStatusController.add(getStatus(event.last));
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult value) {
    switch (value) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.onLine;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.onLine;
      case ConnectivityResult.ethernet:
        return ConnectivityStatus.onLine;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.onLine;
      case ConnectivityResult.none:
        return ConnectivityStatus.offLine;
      case ConnectivityResult.vpn:
        return ConnectivityStatus.onLine;
      case ConnectivityResult.other:
        return ConnectivityStatus.onLine;
    }
  }
}