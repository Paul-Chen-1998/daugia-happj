
class District {
  final String title;
  final int id;

  District({this.title, this.id});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        title: json['Title'],
        id: json['ID']
    );
  }
}
