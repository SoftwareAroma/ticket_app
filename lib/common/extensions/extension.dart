import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

/// extension on [Date]
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}

/// custom extension on [String]
/// use [ReCase] package to convert text to to other cases
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => ReCase(this).titleCase;
  String toSnakeCase() => ReCase(this).snakeCase;
}

/// extension on [http.Response]
extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

/// extension on [http.StreamedResponse]
extension IsStreamOk on http.StreamedResponse {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}
