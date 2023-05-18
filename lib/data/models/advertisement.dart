class Ad {
  String? title;
  String? description;
  String? displayAddress;
  String? transactionType;

  Ad({this.title, this.description, this.displayAddress, this.transactionType});

  Ad.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    displayAddress = json['display_address'];
    transactionType = json['transaction_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['display_address'] = displayAddress;
    data['transaction_type'] = transactionType;
    return data;
  }
}
