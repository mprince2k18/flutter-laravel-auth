class User{
  int? id;
  String? name;
  String? email;
  String? image;
  String? token;

  User({
      this.id,
      this.name,
      this.email,
      this.image,
      this.token,
  });

  // function convert to json data to user model
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      image: json['user']['image'],
      token: json['user']['token'],
    );
  }

}