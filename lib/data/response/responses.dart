import 'package:advanced/presentation/base/base_view_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';



@JsonSerializable()
class BaseResponse{
  @JsonKey(name: 'status')   /// هاد مشان اذا الباك مسمي تسماية بتهوي
  int ? status;
  @JsonKey(name : 'message')
  String ? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: 'id')
  String ? id;
  @JsonKey(name: 'name')
  String ? name;
  @JsonKey(name: 'numOfNotifications')
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


@JsonSerializable()
class ServicesResponse{
  @JsonKey(name: 'id')
  int ? id ;
  @JsonKey(name: 'title')
  String ? title;
  @JsonKey(name: 'image')
  String ? image;
  ServicesResponse(this.id,this.title,this.image);
  factory ServicesResponse.fromJson(Map<String , dynamic>json){
    return _$ServicesResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$ServicesResponseToJson(this);
  }
}


@JsonSerializable()
class BannersResponse{
  @JsonKey(name: 'id')
  int ? id ;
  @JsonKey(name: 'link')
  String ? link;
  @JsonKey(name: 'title')
  String ? title;
  @JsonKey(name: 'image')
  String ? image;
  BannersResponse(this.id,this.link,this.title,this.image);
  factory BannersResponse.fromJson(Map<String , dynamic>json){
    return _$BannersResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$BannersResponseToJson(this);
  }
}


@JsonSerializable()
class StoresResponse{
  @JsonKey(name: 'id')
  int ? id ;
  @JsonKey(name: 'title')
  String ? title;
  @JsonKey(name: 'image')
  String ? image;
  StoresResponse(this.id,this.title,this.image);
  factory StoresResponse.fromJson(Map<String , dynamic>json){
    return _$StoresResponseFromJson(json);
  }

  Map<String , dynamic> toJson(){
    return _$StoresResponseToJson(this);
  }
}


@JsonSerializable()
class HomeDataResponse {

  @JsonKey(name: 'services')
  List<ServicesResponse> ? serviceResponse;
  @JsonKey(name: 'banners')
  List<BannersResponse> ? bannersResponse;
  @JsonKey(name: 'stores')
  List<StoresResponse> ? storesResponse;

  HomeDataResponse(this.serviceResponse,this.bannersResponse,this.storesResponse);
  factory HomeDataResponse.fromJson(Map<String,dynamic> json){
    return _$HomeDataResponseFromJson(json);
  }

  Map<String,dynamic> toJson(){
    return _$HomeDataResponseToJson(this);
  }
}


@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: 'data')
  HomeDataResponse ? homeDataResponse;
  HomeResponse(this.homeDataResponse);

  factory HomeResponse.fromJson(Map<String , dynamic> json){
    return _$HomeResponseFromJson(json);
  }

  Map<String,dynamic> toJson(){
    return _$HomeResponseToJson(this);
  }
}


@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse{
  @JsonKey(name: 'support')
  String ? support;
  ForgotPasswordResponse(this.support);
  factory ForgotPasswordResponse.fromJson(Map<String , dynamic> json){
    return _$ForgotPasswordResponseFromJson(json);
  }

  Map<String,dynamic> toJson(){
    return _$ForgotPasswordResponseToJson(this);
  }
}