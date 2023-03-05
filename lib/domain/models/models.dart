import 'package:advanced/data/response/responses.dart';

class SliderObject{
  String title;
  String subTitle;
  String image;
  SliderObject(this.title,this.subTitle,this.image);
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject,this.currentIndex,this.numOfSlides);
}

class Customer{
  int id;
  String name;
  int numOfNotification;
  Customer(this.id,this.name,this.numOfNotification);
}

class Contacts{
  String phone;
  String email;
  String link;
  Contacts(this.phone,this.email,this.link);
}

class Authentication {
  Customer ? customer;
  Contacts ? contacts;
  Authentication(this.contacts,this.customer);
}