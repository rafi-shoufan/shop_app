
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
  String id;
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

  class Forgot{
  String support;
  Forgot(this.support);
  }

class Services {
  int id ;
  String title;
  String image;
  Services(this.id,this.title,this.image);
}


class Banners {
  int id ;
  String link;
  String title;
  String image;
  Banners(this.id,this.link,this.title,this.image);
}


class Stores {
  int id ;
  String title;
  String image;
  Stores(this.id,this.title,this.image);
}

class HomeData {
  List<Banners> banners;
  List<Services> services;
  List<Stores> stores;
  HomeData(this.services,this.banners,this.stores);
}

class HomeObject {
  HomeData ? data;
  HomeObject(this.data);
}