class User {
   String id;
   String userName;
   String phoneUser;
   String email;
   String imageUser;
   String note;
   String create_at;
   User(
      {this.id,
      this.userName,
      this.phoneUser,
      this.email,
      this.imageUser,
      this.note,
      this.create_at});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['_id'],
      userName: json['userName'],
      phoneUser: json['phoneUser'],
      email: json['email'],
      imageUser: json['imageUser'],
      note: json['note'],
      create_at: json['create_at']);
}
