import 'package:dartz/dartz.dart';
import 'package:ebra/core/error/custom_excption.dart';
import 'package:ebra/core/error/failure.dart';
import 'package:ebra/features/auth/data/model/user_model.dart';
import 'package:ebra/features/auth/data/service/firebase_auth.dart';
import 'package:ebra/features/auth/domain/entity/user_entity.dart';
import 'package:ebra/features/auth/domain/repo/auth_repo.dart';

/*
 * FirebaseAuthRepoImplement class
 * implements FirebaseAuthRepo interface
 * uses FirebaseService to perform authentication operations
 */
class FirebaseAuthRepoImplement extends FirebaseAuthRepo {
  final FirebaseService _firebaseService;

  FirebaseAuthRepoImplement(this._firebaseService);

  @override
  Future<Either<CustomFailure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var user = await _firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      UserModel userModel = UserModel.fromFireBase(user);

      userModel = UserModel(
        uId: userModel.uId,
        email: userModel.email,
        name: name,
      );

      return right(userModel.toEntity());
    } on CustomException catch (ex) {
      return left(CustomFailure(errMessage: ex.errMessage));
    }
  }

  @override
  Future<Either<CustomFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await _firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel.fromFireBase(user);

      userModel = UserModel(
        uId: userModel.uId,
        email: userModel.email,
        name: userModel.name,
      );

      return right(userModel.toEntity());
    } on CustomException catch (ex) {
      return left(CustomFailure(errMessage: ex.errMessage));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> signOut() async {
    try {
      await _firebaseService.signOut();
      return right(unit);
    } on CustomException catch (ex) {
      return left(CustomFailure(errMessage: ex.errMessage));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> forgetPassword({
    required String newPassword,
  }) async {
    try {
      await _firebaseService.forgetPassword(newPassword: newPassword);
      return right(unit);
    } catch (e) {
      return left(CustomFailure(errMessage: e.toString()));
    }
  }
}
