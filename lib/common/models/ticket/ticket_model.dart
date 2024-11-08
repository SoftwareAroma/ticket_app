import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class TicketModel with _$TicketModel {
  factory TicketModel({
    required String id,
    required String firstName,
    required String lastName,
    required String ticketId,
    required String ticketNumber,
    required int numberOfSeats,
    required int numberOfTables,
    required String qrCode,
    required String? image,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);
}
