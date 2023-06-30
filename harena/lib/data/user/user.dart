class User {
  String id;
  String username;
  String age;
  String phoneNumber;
  String email;
  String region;
  String city; 
  User(
    {
      required this.id,
      required this.username,
      this.email='',
      this.age='',
      required this.phoneNumber,
      this.city='',
      this.region=''
      }
  );
}
