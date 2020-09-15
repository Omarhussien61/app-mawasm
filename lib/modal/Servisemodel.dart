class ServiseModel {
  int id;
  String name;
  int priority;
  List<Fields> fields;

  ServiseModel({this.id, this.name, this.priority, this.fields});

  ServiseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    if (json['fields'] != null) {
      fields = new List<Fields>();
      json['fields'].forEach((v) {
        fields.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['priority'] = this.priority;
    if (this.fields != null) {
      data['fields'] = this.fields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String name;
  String titleFormat;
  int descriptionEnable;
  String description;
  String type;
  String display;
  int position;
  int required;
  int restrictions;
  String restrictionsType;
  int adjustPrice;
  String priceType;
  String price;
  int min;
  int max;
  List<Options> options;

  Fields(
      {this.name,
        this.titleFormat,
        this.descriptionEnable,
        this.description,
        this.type,
        this.display,
        this.position,
        this.required,
        this.restrictions,
        this.restrictionsType,
        this.adjustPrice,
        this.priceType,
        this.price,
        this.min,
        this.max,
        this.options});

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    titleFormat = json['title_format'];
    descriptionEnable = json['description_enable'];
    description = json['description'];
    type = json['type'];
    display = json['display'];
    position = json['position'];
    required = json['required'];
    restrictions = json['restrictions'];
    restrictionsType = json['restrictions_type'];
    adjustPrice = json['adjust_price'];
    priceType = json['price_type'];
    price = json['price'];
    min = json['min'];
    max = json['max'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title_format'] = this.titleFormat;
    data['description_enable'] = this.descriptionEnable;
    data['description'] = this.description;
    data['type'] = this.type;
    data['display'] = this.display;
    data['position'] = this.position;
    data['required'] = this.required;
    data['restrictions'] = this.restrictions;
    data['restrictions_type'] = this.restrictionsType;
    data['adjust_price'] = this.adjustPrice;
    data['price_type'] = this.priceType;
    data['price'] = this.price;
    data['min'] = this.min;
    data['max'] = this.max;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String label;
  String price;
  String image;
  String priceType;

  Options({this.label, this.price, this.image, this.priceType});

  Options.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    price = json['price'];
    image = json['image'];
    priceType = json['price_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['price'] = this.price;
    data['image'] = this.image;
    data['price_type'] = this.priceType;
    return data;
  }
}
