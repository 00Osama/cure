import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_client.dart';
import '../network/auth_token_provider.dart';
import '../notifications/notification_service.dart';
import '../../features/auth/data/data_sources/auth_remote_datasource.dart';
import '../../features/profile/data_sources/profile_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/profile/presentation/cubits/edit_profile_info_cubit.dart';
import '../../features/booking/data/datasources/booking_remote_datasource.dart';
import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';
import '../../features/booking/domain/usecase/booking_usecase.dart';
import '../../features/booking/presentation/cubits/booking_cubit.dart';
import '../../features/dashboard/domain/usecase/dashboard_usecase.dart';
import '../../features/dashboard/presentation/cubits/dashboard_cubit.dart';

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

  // Network + booking/dashboard
  late final ApiClient _apiClient;
  late final BookingRemoteDataSource _bookingRemoteDataSource;
  late final BookingRepository _bookingRepository;
  late final BookingUseCase _bookingUseCase;
  late final DashboardUseCase _dashboardUseCase;
  late final NotificationService _notificationService;

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

    _profileRemoteDataSource = ProfileRemoteDataSourceImpl(
      firestore: _firestore,
    );

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: _authRemoteDataSource,
      secureStorage: _secureStorage,
      profileRemoteDataSource: _profileRemoteDataSource,
    );

    // Initialize use cases
    _authUseCase = AuthUseCase(authRepository: _authRepository);

    // Network layer (dio → Supabase REST) + booking/dashboard wiring
    _apiClient = DioApiClient(tokenProvider: const SupabaseAnonTokenProvider());
    _bookingRemoteDataSource = BookingRemoteDataSourceImpl(
      apiClient: _apiClient,
    );
    _bookingRepository = BookingRepositoryImpl(
      remoteDataSource: _bookingRemoteDataSource,
    );
    _bookingUseCase = BookingUseCase(repository: _bookingRepository);
    _dashboardUseCase = DashboardUseCase(bookingRepository: _bookingRepository);
    _notificationService = NotificationService();
  }

  // Getters for dependencies
  FirebaseFirestore get firestore => _firestore;
  FlutterSecureStorage get secureStorage => _secureStorage;
  AuthRepository get authRepository => _authRepository;
  AuthUseCase get authUseCase => _authUseCase;
  ApiClient get apiClient => _apiClient;
  BookingUseCase get bookingUseCase => _bookingUseCase;
  NotificationService get notificationService => _notificationService;
  ProfileRemoteDataSource get profileRemoteDataSource =>
      _profileRemoteDataSource;

  /// Firebase uid of the signed-in user (used as patient/nurse id).
  String? get currentUid => _firebaseAuth.currentUser?.uid;

  /// Fetches the device FCM token and stores it on the user's profile so a
  /// server (Edge Function / Cloud Function) can push booking updates.
  Future<void> registerFcmToken() async {
    final uid = currentUid;
    if (uid == null) return;
    try {
      final token = await _notificationService.token();
      if (token == null) return;
      await _profileRemoteDataSource.updateFcmToken(uid, token);
    } catch (_) {
      // Non-fatal: token registration is best-effort.
    }
  }

  /// Create a new AuthCubit instance
  ///
  /// Cubits should not be singletons - create new instances as needed
  AuthCubit createAuthCubit() {
    return AuthCubit(authUseCase: _authUseCase);
  }

  EditProfileInfoCubit createEditProfileInfoCubit() {
    return EditProfileInfoCubit(
      profileRemoteDataSource: _profileRemoteDataSource,
      currentUid: () => currentUid,
    );
  }

  BookingCubit createBookingCubit() {
    return BookingCubit(useCase: _bookingUseCase, patientId: currentUid ?? '');
  }

  DashboardCubit createDashboardCubit() {
    return DashboardCubit(
      useCase: _dashboardUseCase,
      patientId: currentUid ?? '',
      notificationService: _notificationService,
    );
  }
}

/// Global getter for easy access to dependency injection
final di = DependencyInjection();
