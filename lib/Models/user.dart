class User {
  final String id;
  final String name;
  final String email;
  final String? role;
  final String? profilePhotoUrl;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.profilePhotoUrl,
    this.token,
  });
}
