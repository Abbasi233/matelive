import '/model/user_detail.dart';
import '/model/notifications.dart';
import '/model/Call/previous_call.dart';

class PagedResponse {
  PagedResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<dynamic> data;
  Links links;
  Meta meta;

  factory PagedResponse.fromJson(Map<String, dynamic> json, Type dataType) {
    var data;
    switch (dataType) {
      case UserDetail:
        data = List<UserDetail>.from(
          json["data"].map((x) => UserDetail.fromJson(x)).toList(),
        );
        break;
      case Notification:
        data = List<Notification>.from(
          json["data"].map((x) => Notification.fromJson(x)).toList(),
        );
        break;
      case PreviousCall:
        data = List<PreviousCall>.from(
          json["data"].map((x) => PreviousCall.fromJson(x)).toList(),
        );
        break;
    }
    return PagedResponse(
      data: data,
      links: Links.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
    );
  }
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  dynamic from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  dynamic to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );
}
