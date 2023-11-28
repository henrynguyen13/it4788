
class User {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? imageUrl;
  final String? coins;
  final String? active;

  const User({
    this.email,
    this.password,
    this.id,
    this.name,
    this.imageUrl,
    this.coins,
    this.active
  });

  static const empty = User();
}