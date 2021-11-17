import 'package:matelive/model/user_detail.dart';

class ProfileDetail implements UserDetail {
  ProfileDetail.instance();
  factory ProfileDetail() => _profileDetail;
  static final ProfileDetail _profileDetail = ProfileDetail.instance();

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
  Map<String, int> settings;

  ProfileDetail.fromJson(Map<String, dynamic> json) {
    _profileDetail.id = json["id"];
    _profileDetail.name = json["name"];
    _profileDetail.surname = json["surname"];
    _profileDetail.slug = json["slug"];
    _profileDetail.currentStatus = json["current_status"];
    _profileDetail.gender = json["gender"];
    _profileDetail.email = json["email"];
    _profileDetail.phone = json["phone"];
    _profileDetail.image = json["image"];
    _profileDetail.birthday = json["birthday"];
    _profileDetail.age = json["age"];
    _profileDetail.description = json["description"];
    _profileDetail.emailVerified = json["email_verified"];
    _profileDetail.lastActivity = DateTime.parse(json["last_activity"]);
    _profileDetail.isOnline = json["is_online"];
    _profileDetail.socialMedias = SocialMedias.fromJson(json["social_medias"]);
    _profileDetail.gallery = List<Gallery>.from(
        json["gallery"]?.map((x) => Gallery.fromJson(x)) ?? []);
    _profileDetail.settings = Map.from(json["settings"]);
  }
}

class Settings {
  Settings({
    this.permissionProfilePicture,
    this.permissionGallery,
    this.permissionSocialMedia,
    this.permissionDescription,
  });

  int permissionProfilePicture;
  int permissionGallery;
  int permissionSocialMedia;
  int permissionDescription;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        permissionProfilePicture: json["permission_profile_picture"] ?? "",
        permissionGallery: json["permission_gallery"] ?? "",
        permissionSocialMedia: json["permission_social_media"] ?? "",
        permissionDescription: json["permission_description"] ?? "",
      );
}
