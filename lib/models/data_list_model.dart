class MyData {
  List<HeliverseList>? heliverseList;

  MyData.fromJson(Map<String, dynamic> json) {
    if (json['heliverse_list'] != null) {
      heliverseList = <HeliverseList>[];
      json['heliverse_list'].forEach((v) {
        heliverseList!.add(HeliverseList.fromJson(v));
      });
    }
  }
}

class HeliverseList {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? avatar;
  String? domain;
  bool? available;

  HeliverseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    avatar = json['avatar'];
    domain = json['domain'];
    available = json['available'];
  }
}
