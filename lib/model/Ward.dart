
class Ward {
  final String title;
  final int id;

  Ward({this.title, this.id});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
        title: json['Title'],
        id: json['ID']
    );
  }
}
