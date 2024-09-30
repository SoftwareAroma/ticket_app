import 'package:award_ticket/index.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ServiceInitializer {
  ServiceInitializer._();
  static final ServiceInitializer instance = ServiceInitializer._();

  initializeSettings() async {
    await initializeDataLayer();
    initializeOrientationPreferences();
    setupUrlLauncherServices();
  }

// register services and factories
  setupUrlLauncherServices() {
    // register service
    locator.registerSingleton<CallServices>(CallServices());
    locator.registerSingleton<SmsServices>(SmsServices());
    locator.registerSingleton<EmailServices>(EmailServices());
    locator.registerSingleton<WebServices>(WebServices());
  }

  // set up call services

  // initialize data layer
  initializeDataLayer() async {
    Get.lazyPut(() => TicketController());
    Get.lazyPut(() => AppController());
  }

  /// initialize orientation preferences
  initializeOrientationPreferences() {
    // handle display orientation on various devices
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);

    // system ui mode
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }
}
