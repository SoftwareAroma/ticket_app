import 'package:award_ticket/index.dart';

// call services
class CallServices {
  void callDriver(String phoneNumber) async {
    String url = "tel:$phoneNumber";
    HelperFunctions.iLaunchUrl(url);
  }
}

class EmailServices {
  void sendEmail(String email) async {
    String url = "mailto:$email";
    HelperFunctions.iLaunchUrl(url);
  }
}

// sms services
class SmsServices {
  void sendSms(String phoneNumber) async {
    String url = "sms:$phoneNumber";
    HelperFunctions.iLaunchUrl(url);
  }
}

class WebServices {
  void openWebPage(String url) async {
    HelperFunctions.iLaunchUrl(url);
  }
}
