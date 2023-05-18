class Image {
  String? url;
  String? id;
  String? watermarkUrl;

  Image({this.url, this.id, this.watermarkUrl});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    watermarkUrl = json['watermark_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['id'] = id;
    data['watermark_url'] = watermarkUrl;
    return data;
  }
}
