
class City {
  final String title;
  final int id;

  City({this.title, this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        title: json['Title'],
        id: json['ID']
    );
  }
}
