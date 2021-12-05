class Person {
  Person({
    this.id,
    this.name,
    this.surname,
    this.type,
    this.currentStatus,
    this.slug,
    this.gender,
    this.email,
    this.phone,
    this.image,
    this.birthday,
    this.description,
    this.emailVerifiedAt,
    this.lastActivity,
    this.isBlocked,
  });

  int id;
  String name;
  String surname;
  int type;
  String currentStatus;
  String slug;
  int gender;
  String email;
  String phone;
  String image;
  String birthday;
  String description;
  DateTime emailVerifiedAt;
  DateTime lastActivity;
  int isBlocked;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        type: json["type"],
        currentStatus: json["current_status"].toString(),
        slug: json["slug"],
        gender: json["gender"] == null ? null : json["gender"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        description: json["description"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        lastActivity: json["last_activity"] == null
            ? null
            : DateTime.parse(json["last_activity"]),
        isBlocked: json["is_blocked"],
      );
}
