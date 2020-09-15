class Slider_model {
  String image;
  String title;

  Slider_model({this.image, this.title});

  Slider_model.fromJson(Map<String, dynamic> json) {
    image = json['image'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
