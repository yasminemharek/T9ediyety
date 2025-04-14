class User {
  final int id;
  final String email;
  final String? createdAt;

  User({required this.id, required this.email, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (createdAt != null) 'created_at': createdAt,
    };
  }
}
