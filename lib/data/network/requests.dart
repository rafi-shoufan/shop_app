class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email,this.password);
}

class RegisterRequest{
  String email;
  String password;
  String name;
  String profilePicture;
  String countryCode;
  String mobileNumber;

  RegisterRequest(
      this.email,
      this.password,
      this.countryCode,
      this.mobileNumber,
      this.name,
      this.profilePicture
      );
}

