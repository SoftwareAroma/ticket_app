import 'dart:async';

import 'package:http/http.dart' as http;

abstract class HttpExceptions {
  static String errorMessage(dynamic e, {String? server}) {
    if (e is TimeoutException) {
      return 'Looks like the server is taking to long to respond.';
    }

    if (e is http.ClientException) {
      return e.message.toString();
    } else {
      return e.toString().substring(0, e.toString().length < 30 ? e.toString().length : 30);
    }
  }
}
