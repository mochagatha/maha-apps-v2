// GoRouter Configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/bank_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/create_signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/statement_letter_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/statement_letter_signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/bank_provider.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/signature_provider.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/statement_letters_provider.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/terms_and_conditions_page.dart';
import '../../features/authentication/presentation/pages/privacy_notice_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/admin_home.dart';
import '../../features/home/presentation/providers/admin_home_provider.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'route_names.dart';
import 'route_paths.dart';
import 'not_found_page.dart';
import '../../shared/widgets/scaffold_with_navbar.dart';
import 'package:provider/provider.dart';
import '../di/injection_container.dart';
import '../../features/absensi/presentation/pages/absensi_page.dart';
import '../../features/absensi/presentation/providers/attendance_provider.dart';
import '../../features/biodata/presentation/pages/welcome_page.dart';
import '../../features/biodata/presentation/providers/biodata_provider.dart';
import '../../features/biodata/presentation/pages/biodata_form_page.dart';
import '../../features/biodata/presentation/providers/biodata_form_provider.dart';
import '../../features/biodata/presentation/pages/education_form_page.dart';
import '../../features/biodata/presentation/providers/education_form_provider.dart';
import '../../features/biodata/presentation/pages/family_page.dart';
import '../../features/biodata/presentation/providers/family_provider.dart';
import '../../features/biodata/presentation/pages/document_page.dart';
import '../../features/biodata/presentation/providers/document_provider.dart';
import '../../features/biodata/presentation/pages/skill_page.dart';
import '../../features/biodata/presentation/providers/skill_provider.dart';
import '../../features/biodata/presentation/pages/selfie_page.dart';
import '../../features/biodata/presentation/pages/selfie_camera_page.dart';
import '../../features/biodata/presentation/pages/selfie_result_page.dart';
import '../../features/biodata/presentation/pages/selfie_ktp_page.dart';
import '../../features/biodata/presentation/pages/selfie_ktp_camera_page.dart';
import '../../features/biodata/presentation/pages/selfie_ktp_result_page.dart';
import '../../features/biodata/domain/repositories/biodata_repository.dart'; // Import Repository for type safety if needed, or rely on sl lookup
import '../../features/recruitment/presentation/pages/recruitment_page.dart';
import '../../features/recruitment/presentation/providers/recruitment_provider.dart';
import '../../features/recruitment/presentation/pages/verification_data_page.dart';
import '../../features/recruitment/presentation/pages/employee_verification_page.dart';
import '../../features/recruitment/presentation/pages/company_code_page.dart';
import '../../features/authentication/presentation/pages/admin_face_verification_page.dart';
import '../../features/authentication/presentation/pages/admin_face_camera_page.dart';
import '../../features/authentication/presentation/providers/admin_face_provider.dart';
import '../../features/organizational_structure/presentation/pages/organizational_structure_list_page.dart';
import '../../features/organizational_structure/presentation/pages/structure_main_page.dart';
import '../../features/organizational_structure/presentation/pages/employment_level_list_page.dart';
import '../../features/organizational_structure/presentation/pages/department_list_page.dart';
import '../../features/organizational_structure/presentation/pages/job_title_list_page.dart';
import '../../features/organizational_structure/presentation/pages/job_title/job_title_office_page.dart';
import '../../features/organizational_structure/presentation/pages/job_title/job_title_project_page.dart';
import '../../features/organizational_structure/presentation/pages/job_title_page.dart';
import '../../features/organizational_structure/presentation/providers/organizational_structure_provider.dart';
import '../../features/organizational_structure/presentation/pages/department_office_page.dart';
import '../../features/organizational_structure/presentation/pages/department_project_page.dart';
import '../../features/organizational_structure/presentation/pages/employment_level_employee_page.dart';
import '../../features/organizational_structure/presentation/pages/employment_level_worker_page.dart';
import '../../features/organizational_structure/presentation/pages/employment_level_detail_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/settings_placeholder_page.dart';

class AppRouter {
  static GoRouter router() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RoutePaths.biodataBank,
      debugLogDiagnostics: true,

      // Redirect logic
      redirect: (context, state) {
        return null;
      },

      routes: [
        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: RoutePaths.forgotPassword,
          name: RouteNames.forgotPassword,
          builder: (context, state) => const InputEmailForgetPasswordPage(),
        ),
        GoRoute(
          path: RoutePaths.termsAndConditions,
          name: RouteNames.termsAndConditions,
          builder: (context, state) => const TermsAndConditionsPage(),
        ),
        GoRoute(
          path: RoutePaths.privacyNotice,
          name: RouteNames.privacyNotice,
          builder: (context, state) => const PrivacyNoticePage(),
        ),
        GoRoute(
          path: RoutePaths.adminHome,
          name: RouteNames.adminHome,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AdminHomeProvider>(),
            child: const AdminHomePage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.adminFaceVerification,
          name: RouteNames.adminFaceVerification,
          builder: (context, state) => const AdminFaceVerificationPage(),
        ),
        GoRoute(
          path: RoutePaths.adminFaceCamera,
          name: RouteNames.adminFaceCamera,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AdminFaceProvider>(),
            child: const AdminFaceCameraPage(),
          ),
        ),

        // StatefulShellRoute for Bottom Navigation with persisted state
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: shellNavigatorKey,
              routes: [
                GoRoute(
                  path: RoutePaths.home,
                  name: RouteNames.home,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.pesan,
                  name: RouteNames.pesan,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text("Pesan"))),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.calendar,
                  name: RouteNames.calendar,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text("Kalender"))),
                ),
              ],
            ),
          ],
        ),

        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: RoutePaths.absensi,
          name: RouteNames.absensi,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AttendanceProvider>(),
            child: const AbsensiPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.welcomeBiodata,
          name: RouteNames.welcomeBiodata,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<BiodataProvider>(),
            child: const WelcomeBiodata(),
          ),
        ),
        GoRoute(
          path: RoutePaths.biodataForm,
          name: RouteNames.biodataForm,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) =>
                BiodataFormProvider(repository: sl<BiodataRepository>()),
            child: const BiodataFormPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.educationForm,
          name: RouteNames.educationForm,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => EducationFormProvider(),
            child: const EducationFormPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.familyForm,
          name: RouteNames.familyForm,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => FamilyProvider(),
            child: const FamilyPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.documentForm,
          name: RouteNames.documentForm,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => DocumentProvider(),
            child: const DocumentPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.skillForm,
          name: RouteNames.skillForm,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => SkillProvider(),
            child: const SkillPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.selfieForm,
          name: RouteNames.selfieForm,
          builder: (context, state) => const SelfiePage(),
        ),
        GoRoute(
          path: RoutePaths.selfieCamera,
          name: RouteNames.selfieCamera,
          builder: (context, state) => const SelfieCameraPage(),
        ),
        GoRoute(
          path: RoutePaths.selfieResult,
          name: RouteNames.selfieResult,
          builder: (context, state) => const SelfieResultPage(),
        ),
        GoRoute(
          path: RoutePaths.selfieKtpForm,
          name: RouteNames.selfieKtpForm,
          builder: (context, state) => const SelfieKtpPage(),
        ),
        GoRoute(
          path: RoutePaths.selfieCameraKtp,
          name: RouteNames.selfieCameraKtp,
          builder: (context, state) => const SelfieCameraKtpPage(),
        ),
        GoRoute(
          path: RoutePaths.selfieResultKtp,
          name: RouteNames.selfieResultKtp,
          builder: (context, state) => const SelfieKtpResultPage(),
        ),
        GoRoute(
          path: RoutePaths.biodataBank,
          name: RouteNames.biodataBank,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => BankProvider(),
              child: const BankPage(),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.biodataSignature,
          name: RouteNames.biodataSignature,
          builder: (context, state) => SignaturePage(),
        ),
        GoRoute(
          path: RoutePaths.biodataCreateSignature,
          name: RouteNames.biodataCreateSignature,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => SignatureProvider(),
              child: CreateSignaturePage(),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return ChangeNotifierProvider(
              create: (context) => StatementLettersProvider(),
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: RoutePaths.biodataStatementLetter,
              name: RouteNames.biodataStatementLetter,
              builder: (context, state) => StatementLetterPage(),
            ),
            GoRoute(
              path: RoutePaths.biodataStatementLetterSignature,
              name: RouteNames.biodataStatementLetterSignature,
              builder: (context, state) => StatementLetterSignaturePage(),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.recruitment,
          name: RouteNames.recruitment,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<RecruitmentProvider>(),
            child: const RecruitmentPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.verificationData,
          name: RouteNames.verificationData,
          builder: (context, state) => const VerificationDataPage(),
        ),
        GoRoute(
          path: RoutePaths.employeeVerification,
          name: RouteNames.employeeVerification,
          builder: (context, state) => const EmployeeVerificationPage(),
        ),
        GoRoute(
          path: RoutePaths.companyCode,
          name: RouteNames.companyCode,
          builder: (context, state) => const CompanyCodePage(),
        ),

        // Organizational Structure Routes
        GoRoute(
          path: RoutePaths.organizationalStructure,
          name: RouteNames.organizationalStructure,
          builder: (context, state) => const OrganizationalStructureListPage(),
        ),
        GoRoute(
          path: RoutePaths.structureMain,
          name: RouteNames.structureMain,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const StructureMainPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.employmentLevel,
          name: RouteNames.employmentLevel,
          builder: (context, state) => const EmploymentLevelListPage(),
        ),
        GoRoute(
          path: RoutePaths.employmentLevelEmployee,
          name: RouteNames.employmentLevelEmployee,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const EmploymentLevelEmployeePage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.employmentLevelWorker,
          name: RouteNames.employmentLevelWorker,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const EmploymentLevelWorkerPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.employmentLevelEmployeeDetail,
          name: RouteNames.employmentLevelEmployeeDetail,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'employee',
              title: 'Tingkatan Karyawan',
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.employmentLevelWorkerDetail,
          name: RouteNames.employmentLevelWorkerDetail,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'worker',
              title: 'Tingkatan Pekerja Harian',
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.departmentList,
          name: RouteNames.departmentList,
          builder: (context, state) => const DepartmentListPage(),
        ),
        GoRoute(
          path: RoutePaths.departmentOffice,
          name: RouteNames.departmentOffice,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const DepartmentOfficePage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.departmentProject,
          name: RouteNames.departmentProject,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const DepartmentProjectPage(),
          ),
        ),
        GoRoute(
          path: RoutePaths.jobTitleList,
          name: RouteNames.jobTitleList,
          builder: (context, state) => const JobTitleListPage(),
        ),
        GoRoute(
          path: RoutePaths.jobTitleOffice,
          name: RouteNames.jobTitleOffice,
          builder: (context, state) => const JobTitleOfficePage(),
        ),
        GoRoute(
          path: RoutePaths.jobTitleProject,
          name: RouteNames.jobTitleProject,
          builder: (context, state) => const JobTitleProjectPage(),
        ),
        GoRoute(
          path: RoutePaths.jobTitleOfficeEmployee,
          name: RouteNames.jobTitleOfficeEmployee,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const JobTitlePage(
              typeRole: 'employee',
              typeBranch: 'office',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.jobTitleOfficeWorker,
          name: RouteNames.jobTitleOfficeWorker,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const JobTitlePage(
              typeRole: 'worker',
              typeBranch: 'office',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.jobTitleProjectEmployee,
          name: RouteNames.jobTitleProjectEmployee,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const JobTitlePage(
              typeRole: 'employee',
              typeBranch: 'project',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.jobTitleProjectWorker,
          name: RouteNames.jobTitleProjectWorker,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<OrganizationalStructureProvider>(),
            child: const JobTitlePage(
              typeRole: 'worker',
              typeBranch: 'project',
              title: 'Data Jabatan',
            ),
          ),
        ),

        // Settings Routes
        GoRoute(
          path: RoutePaths.setting,
          name: RouteNames.setting,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: RoutePaths.settingsPenempatanKerja,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Penempatan Kerja'),
        ),
        GoRoute(
          path: RoutePaths.settingsLibur,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Hari Libur & Cuti Bersama'),
        ),
        GoRoute(
          path: RoutePaths.settingsHirarkiOffice,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Hirarki Office'),
        ),
        GoRoute(
          path: RoutePaths.settingsLembur,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Lembur'),
        ),
        GoRoute(
          path: RoutePaths.settingsTindakanKaryawan,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Tindakan Karyawan'),
        ),
        GoRoute(
          path: RoutePaths.settingsBpjs,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'BPJS'),
        ),
        GoRoute(
          path: RoutePaths.settingsPph21,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'PPH 21'),
        ),
        GoRoute(
          path: RoutePaths.settingsJamKerja,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Jam Kerja'),
        ),
        GoRoute(
          path: RoutePaths.settingsFormatDanDraf,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Format dan Draf'),
        ),
        GoRoute(
          path: RoutePaths.settingsAksesLayar,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Akses Layar'),
        ),
        GoRoute(
          path: RoutePaths.settingsHakAksesMenu,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Hak Akses Menu'),
        ),
        GoRoute(
          path: RoutePaths.settingsPelacakanJamKerja,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Pelacakan Jam Kerja'),
        ),
        GoRoute(
          path: RoutePaths.settingsKpi,
          builder: (context, state) => const SettingsPlaceholderPage(
            title: 'Indikator Kinerja Utama (KPI)',
          ),
        ),
        GoRoute(
          path: RoutePaths.settingsBahasa,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Ubah Bahasa'),
        ),
      ],

      errorBuilder: (context, state) {
        return const NotFoundPage();
      },
    );
  }
}
