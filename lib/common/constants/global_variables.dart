import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

late PageController pageController;

const supportedLocales = <Locale>[
  Locale('en'),
  Locale('fr'),
  Locale('sw'),
  Locale('af'),
  Locale('zu'),
  Locale('ar'),
];

const globalDelegates = <LocalizationsDelegate<dynamic>>[
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const String backendUrl = "https://ticket-api-production-cc6f.up.railway.app";
const String getTicketsEndpoint = "$backendUrl/ticket/all";
const String createTicketEndpoint = "$backendUrl/ticket";
String getTicketEndpoint(String id) => "$backendUrl/ticket/$id"; // get ticket by id
String updateTicketEndpoint(String id) => "$backendUrl/ticket/$id"; // update ticket by id
String deleteTicketEndpoint(String id) => "$backendUrl/ticket/$id"; // delete ticket by id
String verifyTicketEndpoint(String id) => "$backendUrl/ticket/verify/$id"; // verify ticket by ticket id

String defaultAvatarUrl =
    "https://firebasestorage.googleapis.com/v0/b/ipv-ghana.appspot.com/o/account.png?alt=media&token=b645ba47-7c94-46ed-9204-73a54e3756dd";

const String defaultImagePlaceholder = "http://via.placeholder.com/350x150";

final logger = Logger();
