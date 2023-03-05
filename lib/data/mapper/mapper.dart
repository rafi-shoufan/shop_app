import 'package:advanced/app/extension.dart';
import 'package:advanced/data/response/responses.dart';

import '../../app/constants.dart';
import '../../domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
        this?.id.orZero()   ??   Constants.zero,
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