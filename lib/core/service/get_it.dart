import 'package:ebra/features/auth/data/repo/auth_repo_implement.dart';
import 'package:ebra/features/auth/data/repo/otp_repo_implement.dart';
import 'package:ebra/features/auth/data/service/firebase_auth.dart';
import 'package:ebra/features/auth/data/service/otp_service.dart';
import 'package:ebra/features/auth/domain/repo/otp_repo.dart';
import 'package:ebra/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/cubits/signout_cubit/signout_cubit.dart';
import '../../features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';

/*
 * this file is responsible for setting up the GetIt service locator
 * it registers services, repositories, and cubits for dependency injection
 * to use, call getIt<T>() to retrieve an instance of type T
 * for example, getIt<ApiService>() returns the registered ApiService instance
 * make sure to call getItSetup() during app initialization
 */
final getIt = GetIt.instance;

Future<void> getItSetup() async {
  // services
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
  getIt.registerLazySingleton<OtpService>(() => OtpService());

  // repo
  getIt.registerLazySingleton<FirebaseAuthRepo>(
    () => FirebaseAuthRepoImplement(getIt<FirebaseService>()),
  );
  getIt.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(otpService: getIt<OtpService>()),
  );

  // Cubits
  getIt.registerFactory(() => SignupCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => SignoutCubit(getIt()));
  getIt.registerFactory(() => OtpCubit(getIt()));
  getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
}
