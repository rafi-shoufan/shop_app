import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';



@JsonSerializable()
class BaseResponse{
  @JsonKey(name: 'status_res1')   /// هاد مشان اذا الباك مسمي تسماية بتهوي
  int ? status;
  @JsonKey(name : 'msg')
  String ? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: 'id')
  int ? id;
  @JsonKey(name: 'name')
  String ? name;
  @JsonKey(name: 'num_of_notifications')
  int ? numOfNotifications;
  CustomerResponse(this.name,this.id,this.numOfNotifications);
  factory CustomerResponse.fromJson(Map<String , dynamic>json){
    return _$CustomerResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$CustomerResponseToJson(this);
  }
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: 'phone')
  String ? phone;
  @JsonKey(name: 'email')
  String ? email;
  @JsonKey(name: 'link')
  String ? link;
  ContactsResponse(this.email,this.link,this.phone);

  factory ContactsResponse.fromJson(Map<String , dynamic>json){
    return _$ContactsResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$ContactsResponseToJson(this);
  }
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: 'customer')
  CustomerResponse ? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse ? contacts;
  AuthenticationResponse(this.contacts,this.customer);

  factory AuthenticationResponse.fromJson(Map<String , dynamic>json){
    return _$AuthenticationResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$AuthenticationResponseToJson(this);
  }
}