// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status_res1'] as int?
  ..message = json['msg'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status_res1': instance.status,
      'msg': instance.message,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['name'] as String?,
      json['id'] as int?,
      json['num_of_notifications'] as int?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'num_of_notifications': instance.numOfNotifications,
    };

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      json['email'] as String?,
      json['link'] as String?,
      json['phone'] as String?,
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'link': instance.link,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['contacts'] == null
          ? null
          : ContactsResponse.fromJson(json['contacts'] as Map<String, dynamic>),
      json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
    )
      ..status = json['status_res1'] as int?
      ..message = json['msg'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status_res1': instance.status,
      'msg': instance.message,
      'customer': instance.customer,
      'contacts': instance.contacts,
    };
