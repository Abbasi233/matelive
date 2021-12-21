class UserDetail {
  UserDetail({
    this.id,
    this.name,
    this.surname,
    this.slug,
    this.currentStatus,
    this.gender,
    this.email,
    this.phone,
    this.image,
    this.birthday,
    this.age,
    this.description,
    this.emailVerified,
    this.lastActivity,
    this.isOnline,
    this.socialMedias,
    this.gallery,
    this.userPermissions,
  });

  int id;
  String name;
  String surname;
  String slug;
  int currentStatus;
  int gender;
  String email;
  dynamic phone;
  String image;
  String birthday;
  String age;
  String description;
  bool emailVerified;
  DateTime lastActivity;
  bool isOnline;
  SocialMedias socialMedias;
  List<Gallery> gallery;
  UserPermissions userPermissions;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        slug: json["slug"],
        currentStatus: json["current_status"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        birthday: json["birthday"],
        age: json["age"],
        description: json["description"],
        emailVerified: json["email_verified"],
        lastActivity: json["last_activity"] == null
            ? null
            : DateTime.parse(json["last_activity"]),
        isOnline: json["is_online"],
        socialMedias: json["social_medias"] != null
            ? SocialMedias.fromJson(json["social_medias"])
            : null,
        gallery: List<Gallery>.from(
            json["gallery"]?.map((x) => Gallery.fromJson(x)) ?? []),
        userPermissions: json["can_auth_see_details"] != null
            ? UserPermissions.fromJson(json["can_auth_see_details"])
            : null,
      );
}

class Gallery {
  Gallery({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        image: json["image"],
      );
}

class SocialMedias {
  SocialMedias({
    this.facebook,
    this.instagram,
    this.twitter,
    this.pinterest,
    this.website,
  });

  String facebook;
  String instagram;
  String twitter;
  String pinterest;
  String website;

  factory SocialMedias.fromJson(Map<String, dynamic> json) => SocialMedias(
        facebook: json["facebook"] ?? "",
        instagram: json["instagram"] ?? "",
        twitter: json["twitter"] ?? "",
        pinterest: json["pinterest"] ?? "",
        website: json["website"] ?? "",
      );
}

class UserPermissions {
  UserPermissions({
    this.gallery,
    this.socialMedias,
    this.description,
  });

  bool gallery;
  bool socialMedias;
  bool description;

  factory UserPermissions.fromJson(Map<String, dynamic> json) =>
      UserPermissions(
        gallery: json["gallery"] ?? true,
        socialMedias: json["social_medias"] ?? true,
        description: json["description"] ?? true,
      );
}
