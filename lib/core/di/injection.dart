import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_client.dart';
import '../network/auth_token_provider.dart';
import '../notifications/notification_service.dart';
import '../../features/auth/data/data_sources/auth_remote_datasource.dart';
import '../../features/profile/data/data_sources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/use_cases/delete_account_use_case.dart';
import '../../features/profile/domain/use_cases/get_profile_use_case.dart';
import '../../features/profile/domain/use_cases/logout_use_case.dart';
import '../../features/profile/domain/use_cases/update_fcm_token_use_case.dart';
import '../../features/profile/domain/use_cases/update_profile_use_case.dart';
import '../../features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/profile/presentation/cubits/edit_profile_info_cubit.dart';
import '../../features/profile/presentation/cubits/profile_cubit.dart';
import '../../features/booking_nurse/data/datasources/booking_remote_datasource.dart';
import '../../features/booking_nurse/data/datasources/nurse_remote_datasource.dart';
import '../../features/booking_nurse/data/repositories/booking_repository_impl.dart';
import '../../features/booking_nurse/data/repositories/nurse_repository_impl.dart';
import '../../features/booking_nurse/domain/repositories/booking_repository.dart';
import '../../features/booking_nurse/domain/repositories/nurse_repository.dart';
import '../../features/booking_nurse/domain/usecase/booking_usecase.dart';
import '../../features/booking_nurse/domain/usecase/get_available_nurses_usecase.dart';
import '../../features/booking_nurse/presentation/cubits/nurses_cubit.dart';
import '../../features/patient_dashboard/domain/usecase/dashboard_usecase.dart';
import '../../features/patient_dashboard/presentation/cubits/dashboard_cubit.dart';

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
  late final ProfileRepository _profileRepository;
  late final GetProfileUseCase _getProfileUseCase;
  late final UpdateProfileUseCase _updateProfileUseCase;
  late final UploadProfileImageUseCase _uploadProfileImageUseCase;
  late final UpdateFcmTokenUseCase _updateFcmTokenUseCase;
  late final DeleteAccountUseCase _deleteAccountUseCase;
  late final LogoutUseCase _logoutUseCase;

  // Network + booking/dashboard
  late final ApiClient _apiClient;
  late final BookingRemoteDataSource _bookingRemoteDataSource;
  late final BookingRepository _bookingRepository;
  late final BookingUseCase _bookingUseCase;
  late final NurseRemoteDataSource _nurseRemoteDataSource;
  late final NurseRepository _nurseRepository;
  late final GetAvailableNursesUseCase _getAvailableNursesUseCase;
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
      firebaseAuth: _firebaseAuth,
    );

    // Initialize repositories
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: _authRemoteDataSource,
      secureStorage: _secureStorage,
      profileRemoteDataSource: _profileRemoteDataSource,
    );

    // Initialize use cases
    _authUseCase = AuthUseCase(authRepository: _authRepository);
    _profileRepository = ProfileRepositoryImpl(
      remoteDataSource: _profileRemoteDataSource,
      firebaseAuth: _firebaseAuth,
    );
    _getProfileUseCase = GetProfileUseCase(_profileRepository);
    _updateProfileUseCase = UpdateProfileUseCase(_profileRepository);
    _uploadProfileImageUseCase = UploadProfileImageUseCase(_profileRepository);
    _updateFcmTokenUseCase = UpdateFcmTokenUseCase(_profileRepository);
    _deleteAccountUseCase = DeleteAccountUseCase(_profileRepository);
    _logoutUseCase = LogoutUseCase(_profileRepository);

    // Network layer (dio → Supabase REST) + booking/dashboard wiring
    _apiClient = DioApiClient(tokenProvider: const SupabaseAnonTokenProvider());
    _bookingRemoteDataSource = BookingRemoteDataSourceImpl(
      apiClient: _apiClient,
    );
    _bookingRepository = BookingRepositoryImpl(
      remoteDataSource: _bookingRemoteDataSource,
    );
    _bookingUseCase = BookingUseCase(repository: _bookingRepository);
    _nurseRemoteDataSource = NurseRemoteDataSourceImpl(_firestore);
    _nurseRepository = NurseRepositoryImpl(_nurseRemoteDataSource);
    _getAvailableNursesUseCase = GetAvailableNursesUseCase(_nurseRepository);
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
  ProfileRepository get profileRepository => _profileRepository;

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
      await _updateFcmTokenUseCase(token);
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
      getProfileUseCase: _getProfileUseCase,
      updateProfileUseCase: _updateProfileUseCase,
      uploadProfileImageUseCase: _uploadProfileImageUseCase,
    );
  }

  ProfileCubit createProfileCubit() {
    return ProfileCubit(
      getProfileUseCase: _getProfileUseCase,
      deleteAccountUseCase: _deleteAccountUseCase,
      logoutUseCase: _logoutUseCase,
    );
  }

  DashboardCubit createDashboardCubit() {
    return DashboardCubit(
      useCase: _dashboardUseCase,
      patientId: currentUid ?? '',
      notificationService: _notificationService,
    );
  }

  NursesCubit createNursesCubit() {
    return NursesCubit(_getAvailableNursesUseCase);
  }
}

/// Global getter for easy access to dependency injection
final di = DependencyInjection();
