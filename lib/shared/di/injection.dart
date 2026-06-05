import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/data/data_sources/auth_remote_datasource.dart';
import '../../features/auth/data/data_sources/profile_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';

/// Simple dependency injection container
///
/// Manages all app dependencies using a singleton pattern
class DependencyInjection {
  // Singleton instance
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  // Core dependencies
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;
  late final FlutterSecureStorage _secureStorage;

  // Data sources
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final ProfileRemoteDataSource _profileRemoteDataSource;

  // Repositories
  late final AuthRepository _authRepository;
  late final AuthUseCase _authUseCase;

  /// Initialize all dependencies
  ///
  /// Must be called once at app startup before using any dependencies
  Future<void> initialize() async {
    // Initialize core dependencies
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;

    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );

    // Initialize data sources
    _authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: _firebaseAuth,
    );

    _profileRemoteDataSource = ProfileRemoteDataSourceImpl(firestore: _firestore);

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: _authRemoteDataSource,
      secureStorage: _secureStorage,
      profileRemoteDataSource: _profileRemoteDataSource,
    );

    // Initialize use cases
    _authUseCase = AuthUseCase(authRepository: _authRepository);
  }

  // Getters for dependencies
  FirebaseFirestore get firestore => _firestore;
  FlutterSecureStorage get secureStorage => _secureStorage;
  AuthRepository get authRepository => _authRepository;
  AuthUseCase get authUseCase => _authUseCase;

  /// Create a new AuthCubit instance
  ///
  /// Cubits should not be singletons - create new instances as needed
  AuthCubit createAuthCubit() {
    return AuthCubit(authUseCase: _authUseCase);
  }
}

/// Global getter for easy access to dependency injection
final di = DependencyInjection();
