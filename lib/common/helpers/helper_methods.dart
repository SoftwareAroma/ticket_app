import 'package:award_ticket/index.dart';
import 'package:flutter/material.dart';

class HelperMethods {
  static final HelperMethods _instance = HelperMethods();
  static HelperMethods get instance => _instance;

  // post method
  /// create employee
  Future createTicket({
    required Map<String, dynamic> data,
  }) async {
    try {
      Map<String, dynamic> response = await requestHelper.postRequest(
        path: createTicketEndpoint,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        data: data,
        builder: (data) => data,
      );
      // logger.i(response);
      TicketModel ticketModel = TicketModel.fromJson(response['data']);
      return ticketModel;
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      logger.e(errorMessage);
      return null;
    }
  }

  /// get product by id
  Future<TicketModel?> getTicket({required String id}) async {
    try {
      Map<String, dynamic> response = await requestHelper.getRequest(
        path: getTicketEndpoint(id),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        builder: (data) => data,
      );
      TicketModel ticketModel = TicketModel.fromJson(response['data']);
      return ticketModel;
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      logger.e(errorMessage);
      return null;
    }
  }

  /// get all [TicketModel]s from the server
  Future<List<TicketModel>> getTickets() async {
    try {
      Map<String, dynamic> response = await requestHelper.getRequest(
        path: getTicketsEndpoint,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        builder: (data) {
          Map<String, dynamic> responseData = data;
          if (responseData['success']) {
            List<Map<String, dynamic>> respData = [];
            for (Map<String, dynamic> value in responseData['data']) {
              respData.add(value);
            }
            return {
              "data": respData,
              "success": responseData['success'],
            };
          }
          return data;
        },
      );
      List<TicketModel> tickets = <TicketModel>[];
      for (Map<String, dynamic> element in response['data']) {
        TicketModel ticketModel = TicketModel.fromJson(element);
        // logger.i("response: $ticketModel");
        tickets.add(ticketModel);
      }
      ticketController.addTickets(tickets);
      // logger.i("tickets : ${ticketController.tickets}");
      return tickets;
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      logger.e(errorMessage);
      return [];
    }
  }

  /// update product
  Future<TicketModel?> updateTicket({
    required String id,
    Map<String, dynamic>? data,
  }) async {
    try {
      Map<String, dynamic> response = await requestHelper.patchRequest(
        path: updateTicketEndpoint(id),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        data: data,
        builder: (data) => data,
      );
      logger.i("Response from helper patch data: $response");
      TicketModel ticketModel = TicketModel.fromJson(response['data']);
      return ticketModel;
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      logger.e(errorMessage);
      return null;
    }
  }

  /// delete ticket
  Future<bool> deleteTicket({
    required String id,
  }) async {
    try {
      await requestHelper.deleteRequest(
        path: deleteTicketEndpoint(id),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        builder: (data) => data,
      );

      /// re-fetch the products
      await getTickets();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      logger.e(errorMessage);
      return false;
    }
  }
}
