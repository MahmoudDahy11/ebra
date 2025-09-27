import 'package:dartz/dartz.dart';
import 'package:ebra/core/error/failure.dart';
import 'package:ebra/features/auth/domain/entity/user_entity.dart';

/*
 * FirebaseAuthRepo interface
 * defines the contract for Firebase authentication repository
 * includes methods for user creation, sign-in, sign-out, and social authentication
 */
abstract class FirebaseAuthRepo {
  /* 
   * Method to create a user with email and password
   * returns Either a CustomFailure or UserEntity
   */
  Future<Either<CustomFailure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  /* 
   * Method to sign in a user with email and password
   * returns Either a CustomFailure or UserEntity
   */
  Future<Either<CustomFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  /* 
   * Method to sign out the current user
   * returns Either a CustomFailure or Unit
   */
  Future<Either<CustomFailure, Unit>> signOut();
}
