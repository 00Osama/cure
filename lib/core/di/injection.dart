import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

/// Simple dependency injection container
/// 
/// Manages all app dependencies using a singleton pattern
class DependencyInjection {
  // Singleton instance
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  // Core dependencies
  late final SupabaseClient _supabaseClient;
  late final FlutterSecureStorage _secureStorage;

  // Data sources
  late final AuthRemoteDataSource _authRemoteDataSource;

  // Repositories
  late final AuthRepository _authRepository;

  /// Initialize all dependencies
  /// 
  /// Must be called once at app startup before using any dependencies
  Future<void> initialize() async {
    // Initialize core dependencies
    _supabaseClient = Supabase.instance.client;
    
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    // Initialize data sources
    _authRemoteDataSource = AuthRemoteDataSourceImpl(
      supabaseClient: _supabaseClient,
    );

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: _authRemoteDataSource,
      secureStorage: _secureStorage,
      supabaseClient: _supabaseClient,
    );
  }

  // Getters for dependencies
  SupabaseClient get supabaseClient => _supabaseClient;
  FlutterSecureStorage get secureStorage => _secureStorage;
  AuthRepository get authRepository => _authRepository;

  /// Create a new AuthBloc instance
  /// 
  /// BLoCs should not be singletons - create new instances as needed
  AuthBloc createAuthBloc() {
    return AuthBloc(authRepository: _authRepository);
  }
}

/// Global getter for easy access to dependency injection
final di = DependencyInjection();
