class UserModel  {
  final String uid;
  final String email;
  final String name;
  final String? image;
  final DateTime lastActive;
  final bool isOnline;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      this.image,
      required this.lastActive,
      required this.isOnline});

  
}
