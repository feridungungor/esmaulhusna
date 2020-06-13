
class Data {
  String name;
  String transliteration;
  int number;

  Data({this.name, this.transliteration, this.number});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    transliteration = json['transliteration'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['transliteration'] = this.transliteration;
    data['number'] = this.number;
    return data;
  }
}

