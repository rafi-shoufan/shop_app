import 'package:advanced/app/extension.dart';
import 'package:advanced/data/response/responses.dart';
import 'package:flutter/foundation.dart';

import '../../app/constants.dart';
import '../../domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
        this?.id.orEmpty()   ??   Constants.emptyString,
        this?.name.orEmpty()   ??   Constants.emptyString,
        this?.numOfNotifications.orZero()   ??   Constants.zero
    );
  }
}


extension ContactsResponseMapper on ContactsResponse?{
  Contacts toDomain(){
    return Contacts(
        this?.phone.orEmpty()   ??   Constants.emptyString,
        this?.email.orEmpty()   ??   Constants.emptyString,
        this?.link .orEmpty()   ??   Constants.emptyString,
    );
  }
}




extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
      this?.contacts.toDomain(),
      this?.customer.toDomain(),
    );
  }
}

extension ServicesResponseMapper on ServicesResponse?{
  Services toDomain(){
    return Services(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.emptyString,
        this?.image.orEmpty() ?? Constants.emptyString
    );
  }
}

extension BannersResponseMapper on BannersResponse?{
  Banners toDomain(){
    return Banners(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.emptyString,
        this?.title.orEmpty() ?? Constants.emptyString,
        this?.image.orEmpty() ?? Constants.emptyString
    );
  }
}

extension StoresResponseMapper on StoresResponse?{
  Stores toDomain(){
    return Stores(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.emptyString,
        this?.image.orEmpty() ?? Constants.emptyString
    );
  }
}

extension HomeResponeMapper on HomeResponse?{
  HomeObject toDomain(){
    List<Services> services = (this?.homeDataResponse?.serviceResponse?.map((serviceResponse) =>
        serviceResponse.toDomain())?? const Iterable.empty()).cast<Services>().toList();
    List<Banners> banners = (this?.homeDataResponse?.bannersResponse?.map((bannersResponse) =>
    bannersResponse.toDomain()) ?? const Iterable.empty()).cast<Banners>().toList();
    List<Stores> stores = (this?.homeDataResponse?.storesResponse?.map((storesResponse) =>
    storesResponse.toDomain()) ?? const Iterable.empty()).cast<Stores>().toList();
    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension ForgotPasswordMapper on ForgotPasswordResponse?{
  String toDomain(){
    return  this?.support.orEmpty()??Constants.emptyString;
  }
}