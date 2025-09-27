/*
 * UserEntity class
 * represents a user with name, email, and unique identifier (uId)
 * used in the authentication domain of the application
 */
class UserEntity {
  final String name;
  final String email;
  final String uId;

  UserEntity({required this.name, required this.email, required this.uId});
}
