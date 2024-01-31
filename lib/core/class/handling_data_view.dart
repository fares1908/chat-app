import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(
        child: Lottie.asset("assets/lotties/loading.json", width: 250, height: 250),
      );
    } else if (statusRequest == StatusRequest.offlineFailure) {
      return Center(
        child: Lottie.asset("assets/lotties/offline.json", width: 250, height: 250),
      );
    } else if (statusRequest == StatusRequest.serverFailure) {
      return Center(
        child: Lottie.asset("assets/lotties/server.json", width: 250, height: 250),
      );
    } else if (statusRequest == StatusRequest.failure) {
      return Center(
        child: Lottie.asset('assets/lotties/nodata.json', width: 250, height: 250, repeat: true),
      );
    } else {
      return widget;
    }
  }
}