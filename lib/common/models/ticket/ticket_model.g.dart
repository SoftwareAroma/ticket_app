// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketModelImpl _$$TicketModelImplFromJson(Map<String, dynamic> json) =>
    _$TicketModelImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      ticketId: json['ticketId'] as String,
      numberOfSeats: (json['numberOfSeats'] as num).toInt(),
      numberOfTables: (json['numberOfTables'] as num).toInt(),
      qrCode: json['qrCode'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$TicketModelImplToJson(_$TicketModelImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'ticketId': instance.ticketId,
      'numberOfSeats': instance.numberOfSeats,
      'numberOfTables': instance.numberOfTables,
      'qrCode': instance.qrCode,
      'image': instance.image,
    };
