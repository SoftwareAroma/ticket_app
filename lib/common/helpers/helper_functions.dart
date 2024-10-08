import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  HelperFunctions._();

  static Future<void> iLaunchUrl(String url) async {
    // convert the url to a Uri
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
    await launchUrl(uri);
  }

  static String generateTicketId() {
    String ticketId = '';
    String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String numbers = '0123456789';
    // generate a random 8 charactors ticket id with a mixture of letters and numbers
    for (int i = 0; i < 8; i++) {
      if (i.isEven) {
        ticketId += letters[Random().nextInt(letters.length)];
      } else {
        ticketId += numbers[Random().nextInt(numbers.length)];
      }
    }
    return ticketId;
  }

  static String generateTicketNumber({required String tableNo, required String seatNo}) {
    // the ticket number is a combination of the table number and the seat number (e.g. T1S#2)
    return 'T${tableNo}S#$seatNo';
  }
}
