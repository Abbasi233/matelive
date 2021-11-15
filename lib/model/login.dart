class Login {
  Login.instance();
  factory Login() => _login;
  static final Login _login = Login.instance();

  String status;
  String token;
  DateTime expire;
  User user;

  Login.fromJson(Map<String, dynamic> json) {
    _login.status = json["status"];
    _login.token = json["token"];
    _login.expire = DateTime.parse(json["expire"]);
    _login.user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "expire": expire.toString(),
        "user": user.toJson(),
      };
}

class User {
  User({
    this.name,
    this.surname,
    this.email,
    this.emailVerified,
  });

  String name;
  String surname;
  String email;
  bool emailVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "email_verified": emailVerified,
      };
}
