class People {
  String? name;
  String? email;
  String? phone;
  double? commission;
  String? role;

  People({this.name, this.email, this.phone, this.commission, this.role});

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    commission = json['commission'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['commission'] = commission;
    data['role'] = role;
    return data;
  }
}
