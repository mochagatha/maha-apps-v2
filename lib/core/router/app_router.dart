// GoRouter Configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/bank_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/create_signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/employee_employment_agreement_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/statement_letter_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/pages/statement_letter_signature_page.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/bank_provider.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/employment_agreement_provider.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/signature_provider.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/statement_letters_provider.dart';
import 'package:maha_apps_v2/features/recruitment/features/data_verification/presentation/pages/employee_personal_data_page.dart';
import 'package:maha_apps_v2/features/settings/features/kpi/features/penilaian_kinerja/presentation/pages/settings_kpi_penilaian_kinerja_page.dart';
import 'package:maha_apps_v2/features/settings/features/kpi/features/penilaian_kinerja/presentation/providers/penilaian_kinerja_provider.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/terms_and_conditions_page.dart';
import '../../features/authentication/presentation/pages/privacy_notice_page.dart';
import '../../features/authentication/presentation/providers/auth_provider.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/admin_home.dart';
import '../../features/home/presentation/providers/admin_home_provider.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/features/kpi/features/aktivasi_point/presentation/page/settings_kpi_aktivasi_point_page.dart';
import '../../features/settings/features/kpi/features/aktivasi_point/presentation/page/settings_kpi_aktivasi_point_detail_page.dart';
import '../../features/settings/features/kpi/features/aktivasi_point/presentation/provider/aktivasi_point_provider.dart';
import '../../features/settings/features/kpi/features/aktivasi_point/presentation/provider/employee_kpi_detail_provider.dart';
import '../../features/settings/features/kpi/features/target_point/presentation/pages/settings_kpi_target_point_page.dart';
import '../../features/settings/features/kpi/features/target_point/presentation/providers/target_point_provider.dart';
import '../../features/settings/features/kpi/features/ubah_periode_surat/presentation/pages/settings_kpi_ubah_periode_surat_page.dart';
import '../../features/settings/features/kpi/features/ubah_periode_surat/presentation/providers/ubah_periode_surat_provider.dart';
import '../../features/settings/features/kpi/presentation/pages/settings_kpi_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';
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
import '../../features/recruitment/features/data_verification/presentation/pages/verification_data_page.dart';
import '../../features/recruitment/features/data_verification/presentation/pages/employee_verification_page.dart';
import '../../features/recruitment/presentation/pages/company_code_page.dart';
import '../../features/authentication/presentation/pages/admin_face_verification_page.dart';
import '../../features/authentication/presentation/pages/admin_face_camera_page.dart';
import '../../features/authentication/presentation/providers/admin_face_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/organizational_structure_list_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/structure_main_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/employment_level_list_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/employment_level_office_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/employment_level_project_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/department_list_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/job_title_list_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/job_title_office_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/job_title_project_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/job_title_detail_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/job_title_selection_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/employee_by_job_title_selection_page.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/job_title_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/department_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/structure_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/user_role_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/department_office_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/department_project_page.dart';
import '../../features/settings/features/organizational_structure/presentation/pages/employment_level_detail_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/settings_placeholder_page.dart';
import '../../features/settings/features/absensi/presentation/pages/settings_absensi_page.dart';
import '../../features/settings/features/absensi/presentation/pages/settings_placeholder_page.dart'
    as absensi_placeholder;
import '../../features/settings/features/pelacakan_jam_kerja/presentation/pages/pelacakan_jam_kerja_page.dart';
import '../../features/settings/features/pelacakan_jam_kerja/presentation/pages/pelacakan_settings_page.dart';
import '../../features/settings/features/pelacakan_jam_kerja/presentation/pages/employee_detail_page.dart';
import '../../features/settings/features/pelacakan_jam_kerja/presentation/providers/pelacakan_provider.dart';
import '../../features/settings/features/access_menu/presentation/pages/access_menu_list_page.dart';
import '../../features/settings/features/access_menu/presentation/pages/employee_selection_page.dart';
import '../../features/settings/features/access_menu/presentation/providers/access_menu_provider.dart';
import '../../features/settings/features/access_menu/presentation/providers/employee_list_provider.dart';
import '../../features/permissions/presentation/pages/permission_page.dart';
import '../../features/permissions/presentation/providers/permission_provider.dart';
import '../../features/settings/features/access_screen/presentation/pages/access_screen_list_page.dart';
import '../../features/settings/features/access_screen/presentation/pages/access_screen_detail_page.dart';
import '../../features/settings/features/access_screen/presentation/providers/access_screen_provider.dart';

class AppRouter {
  static GoRouter router() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.splash.path,
      debugLogDiagnostics: true,
      // Redirect logic - Smart navigation to prevent hot reload splash issue
      redirect: (context, state) {
        final authProvider = context.read<AuthProvider>();
        final currentPath = state.matchedLocation;

        // If user is on splash and already authenticated, skip splash
        // BUT: Admin users should NOT skip - they must login fresh each time
        if (currentPath == AppRoutes.splash.path && authProvider.isAuthenticated) {
          // Check if admin
          if (authProvider.isAdmin) {
            return AppRoutes.adminHome.path;
          }
          // Check user status to determine destination (matching v1 logic)
          if (authProvider.user?.status == 1) {
            return AppRoutes.welcomeBiodata.path;
          } else {
            return AppRoutes.home.path;
          }
        }

        // Allow normal navigation for all other cases
        return null;
      },

      routes: [
        GoRoute(
          path: AppRoutes.splash.path,
          name: AppRoutes.splash.name,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          name: AppRoutes.login.name,
          redirect: (context, state) {
            final authProvider = context.read<AuthProvider>();
            // If user is on splash and already authenticated, skip splash
            // BUT: Admin users should NOT skip - they must login fresh each time
            if (authProvider.isAuthenticated) {
              // Check if admin
              if (authProvider.isAdmin) {
                return AppRoutes.adminHome.path;
              }
              // Check user status to determine destination (matching v1 logic)
              if (authProvider.user?.status == 1) {
                return AppRoutes.welcomeBiodata.path;
              } else {
                return AppRoutes.home.path;
              }
            }

            // Allow normal navigation for all other cases
            return null;
          },
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.permission.path,
          name: AppRoutes.permission.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<PermissionProvider>(),
            child: const PermissionPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.register.path,
          name: AppRoutes.register.name,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword.path,
          name: AppRoutes.forgotPassword.name,
          builder: (context, state) => const InputEmailForgetPasswordPage(),
        ),
        GoRoute(
          path: AppRoutes.termsAndConditions.path,
          name: AppRoutes.termsAndConditions.name,
          builder: (context, state) => const TermsAndConditionsPage(),
        ),
        GoRoute(
          path: AppRoutes.privacyNotice.path,
          name: AppRoutes.privacyNotice.name,
          builder: (context, state) => const PrivacyNoticePage(),
        ),
        GoRoute(
          path: AppRoutes.adminHome.path,
          name: AppRoutes.adminHome.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AdminHomeProvider>(),
            child: const AdminHomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.adminFaceVerification.path,
          name: AppRoutes.adminFaceVerification.name,
          builder: (context, state) => const AdminFaceVerificationPage(),
        ),
        GoRoute(
          path: AppRoutes.adminFaceCamera.path,
          name: AppRoutes.adminFaceCamera.name,
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
                  path: AppRoutes.home.path,
                  name: AppRoutes.home.name,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.pesan.path,
                  name: AppRoutes.pesan.name,
                  builder: (context, state) => const Scaffold(body: Center(child: Text("Pesan"))),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.calendar.path,
                  name: AppRoutes.calendar.name,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text("Kalender"))),
                ),
              ],
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.profile.path,
          name: AppRoutes.profile.name,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: AppRoutes.absensi.path,
          name: AppRoutes.absensi.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AttendanceProvider>(),
            child: const AbsensiPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.welcomeBiodata.path,
          name: AppRoutes.welcomeBiodata.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<BiodataProvider>(),
            child: const WelcomeBiodata(),
          ),
        ),
        GoRoute(
          path: AppRoutes.biodataForm.path,
          name: AppRoutes.biodataForm.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => BiodataFormProvider(repository: sl<BiodataRepository>()),
            child: const BiodataFormPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.educationForm.path,
          name: AppRoutes.educationForm.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => EducationFormProvider(),
            child: const EducationFormPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.familyForm.path,
          name: AppRoutes.familyForm.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => FamilyProvider(),
            child: const FamilyPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.documentForm.path,
          name: AppRoutes.documentForm.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => DocumentProvider(),
            child: const DocumentPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.skillForm.path,
          name: AppRoutes.skillForm.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => SkillProvider(),
            child: const SkillPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.selfieForm.path,
          name: AppRoutes.selfieForm.name,
          builder: (context, state) => const SelfiePage(),
        ),
        GoRoute(
          path: AppRoutes.selfieCamera.path,
          name: AppRoutes.selfieCamera.name,
          builder: (context, state) => const SelfieCameraPage(),
        ),
        GoRoute(
          path: AppRoutes.selfieResult.path,
          name: AppRoutes.selfieResult.name,
          builder: (context, state) => const SelfieResultPage(),
        ),
        GoRoute(
          path: AppRoutes.selfieKtpForm.path,
          name: AppRoutes.selfieKtpForm.name,
          builder: (context, state) => const SelfieKtpPage(),
        ),
        GoRoute(
          path: AppRoutes.selfieCameraKtp.path,
          name: AppRoutes.selfieCameraKtp.name,
          builder: (context, state) => const SelfieCameraKtpPage(),
        ),
        GoRoute(
          path: AppRoutes.selfieResultKtp.path,
          name: AppRoutes.selfieResultKtp.name,
          builder: (context, state) => const SelfieKtpResultPage(),
        ),
        GoRoute(
          path: AppRoutes.biodataBank.path,
          name: AppRoutes.biodataBank.name,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => BankProvider(),
              child: const BankPage(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.biodataSignature.path,
          name: AppRoutes.biodataSignature.name,
          builder: (context, state) => SignaturePage(),
        ),
        GoRoute(
          path: AppRoutes.biodataCreateSignature.path,
          name: AppRoutes.biodataCreateSignature.name,
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
              path: AppRoutes.biodataStatementLetter.path,
              name: AppRoutes.biodataStatementLetter.name,
              builder: (context, state) => StatementLetterPage(),
            ),
            GoRoute(
              path: AppRoutes.biodataStatementLetterSignature.path,
              name: AppRoutes.biodataStatementLetterSignature.name,
              builder: (context, state) => StatementLetterSignaturePage(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.employeeEmploymentAgreement.path,
          name: AppRoutes.employeeEmploymentAgreement.name,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => EmploymentAgreementProvider(),
              child: const EmployeeEmploymentAgreementPage(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.recruitment.path,
          name: AppRoutes.recruitment.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<RecruitmentProvider>(),
            child: const RecruitmentPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.verificationData.path,
          name: AppRoutes.verificationData.name,
          builder: (context, state) => const VerificationDataPage(),
        ),
        GoRoute(
          path: AppRoutes.employeeVerification.path,
          name: AppRoutes.employeeVerification.name,
          builder: (context, state) => const EmployeeVerificationPage(),
        ),
        GoRoute(
          path: AppRoutes.employeePersonalData.path,
          name: AppRoutes.employeePersonalData.name,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return EmployeePersonalDataPage(id: extra["id"]);
          },
        ),
        GoRoute(
          path: AppRoutes.companyCode.path,
          name: AppRoutes.companyCode.name,
          builder: (context, state) => const CompanyCodePage(),
        ),

        // Organizational Structure Routes
        GoRoute(
          path: AppRoutes.organizationalStructure.path,
          name: AppRoutes.organizationalStructure.name,
          builder: (context, state) => const OrganizationalStructureListPage(),
        ),
        GoRoute(
          path: AppRoutes.structureMain.path,
          name: AppRoutes.structureMain.name,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>?;
            final type = args != null && args.containsKey('type')
                ? args['type'] as String
                : 'utama';
            return ChangeNotifierProvider(
              create: (_) => sl<StructureProvider>(),
              child: StructureMainPage(
                type: type,
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.employmentLevel.path,
          name: AppRoutes.employmentLevel.name,
          builder: (context, state) => const EmploymentLevelListPage(),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelOffice.path,
          name: AppRoutes.employmentLevelOffice.name,
          builder: (context, state) => const EmploymentLevelOfficePage(),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelProject.path,
          name: AppRoutes.employmentLevelProject.name,
          builder: (context, state) => const EmploymentLevelProjectPage(),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelOfficeEmployee.path,
          name: AppRoutes.employmentLevelOfficeEmployee.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<UserRoleProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'employee',
              typeBranch: 'office',
              title: 'Tingkatan Karyawan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelOfficeWorker.path,
          name: AppRoutes.employmentLevelOfficeWorker.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<UserRoleProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'worker',
              typeBranch: 'office',
              title: 'Tingkatan Pekerja Harian',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelProjectEmployee.path,
          name: AppRoutes.employmentLevelProjectEmployee.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<UserRoleProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'employee',
              typeBranch: 'project',
              title: 'Tingkatan Karyawan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.employmentLevelProjectWorker.path,
          name: AppRoutes.employmentLevelProjectWorker.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<UserRoleProvider>(),
            child: const EmploymentLevelDetailPage(
              typeRole: 'worker',
              typeBranch: 'project',
              title: 'Tingkatan Pekerja Harian',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.departmentList.path,
          name: AppRoutes.departmentList.name,
          builder: (context, state) => const DepartmentListPage(),
        ),
        GoRoute(
          path: AppRoutes.departmentOffice.path,
          name: AppRoutes.departmentOffice.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<DepartmentProvider>(),
            child: const DepartmentOfficePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.departmentProject.path,
          name: AppRoutes.departmentProject.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<DepartmentProvider>(),
            child: const DepartmentProjectPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.jobTitleList.path,
          name: AppRoutes.jobTitleList.name,
          builder: (context, state) => const JobTitleListPage(),
        ),
        GoRoute(
          path: AppRoutes.jobTitleOffice.path,
          name: AppRoutes.jobTitleOffice.name,
          builder: (context, state) => const JobTitleOfficePage(),
        ),
        GoRoute(
          path: AppRoutes.jobTitleProject.path,
          name: AppRoutes.jobTitleProject.name,
          builder: (context, state) => const JobTitleProjectPage(),
        ),
        GoRoute(
          path: AppRoutes.jobTitleOfficeEmployee.path,
          name: AppRoutes.jobTitleOfficeEmployee.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<JobTitleProvider>(),
            child: const JobTitleDetailPage(
              typeRole: 'employee',
              typeBranch: 'office',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.jobTitleOfficeWorker.path,
          name: AppRoutes.jobTitleOfficeWorker.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<JobTitleProvider>(),
            child: const JobTitleDetailPage(
              typeRole: 'worker',
              typeBranch: 'office',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.jobTitleProjectEmployee.path,
          name: AppRoutes.jobTitleProjectEmployee.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<JobTitleProvider>(),
            child: const JobTitleDetailPage(
              typeRole: 'employee',
              typeBranch: 'project',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.jobTitleProjectWorker.path,
          name: AppRoutes.jobTitleProjectWorker.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<JobTitleProvider>(),
            child: const JobTitleDetailPage(
              typeRole: 'worker',
              typeBranch: 'project',
              title: 'Data Jabatan',
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.jobTitleSelection.path,
          name: AppRoutes.jobTitleSelection.name,
          builder: (context, state) {
            final companyStructureId = int.parse(state.uri.queryParameters['companyStructureId']!);
            final roleStructureId = int.parse(state.uri.queryParameters['roleStructureId']!);
            return ChangeNotifierProvider(
              create: (_) => sl<JobTitleProvider>(),
              child: JobTitleSelectionPage(
                companyStructureId: companyStructureId,
                roleStructureId: roleStructureId,
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.employeeByJobTitleSelection.path,
          name: AppRoutes.employeeByJobTitleSelection.name,
          builder: (context, state) {
            final companyStructureId = int.parse(state.uri.queryParameters['companyStructureId']!);
            final roleStructureId = int.parse(state.uri.queryParameters['roleStructureId']!);
            final jobTitleId = int.parse(state.uri.queryParameters['jobTitleId']!);
            final jobTitleName = state.uri.queryParameters['jobTitleName'] ?? '';
            return ChangeNotifierProvider(
              create: (_) => sl<StructureProvider>(),
              child: EmployeeByJobTitleSelectionPage(
                companyStructureId: companyStructureId,
                roleStructureId: roleStructureId,
                jobTitleId: jobTitleId,
                jobTitleName: jobTitleName,
              ),
            );
          },
        ),
        // Access Menu Routes
        GoRoute(
          path: AppRoutes.employeeSelection.path,
          name: AppRoutes.employeeSelection.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<EmployeeListProvider>(),
            child: const EmployeeSelectionPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.accessMenuList.path,
          name: AppRoutes.accessMenuList.name,
          builder: (context, state) {
            final employeeId = state.uri.queryParameters['employeeId'] ?? '1';
            return ChangeNotifierProvider(
              create: (_) => sl<AccessMenuProvider>(),
              child: AccessMenuListPage(employeeId: int.parse(employeeId)),
            );
          },
        ),
        // KPI Menu Routes
        GoRoute(
          path: AppRoutes.settingsKpi.path,
          name: AppRoutes.settingsKpi.name,
          builder: (context, state) => const SettingsKpiPage(),
        ),
        GoRoute(
          path: AppRoutes.settingsKpiTargetPoint.path,
          name: AppRoutes.settingsKpiTargetPoint.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<TargetPointProvider>(),
            child: const SettingsKpiTargetPointPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsKpiPenilaianKinerja.path,
          name: AppRoutes.settingsKpiPenilaianKinerja.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<PenilaianKinerjaProvider>(),
            child: const SettingsKpiPenilaianKinerjaPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsKpiUbahPeriodeSurat.path,
          name: AppRoutes.settingsKpiUbahPeriodeSurat.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<UbahPeriodeSuratProvider>(),
            child: const SettingsKpiUbahPeriodeSuratPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsKpiPengaturanAktivasiPoint.path,
          name: AppRoutes.settingsKpiPengaturanAktivasiPoint.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AktivasiPointProvider>(),
            child: const SettingsKpiAktivasiPointPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsKpiPengaturanAktivasiPointDetail.path,
          name: AppRoutes.settingsKpiPengaturanAktivasiPointDetail.name,
          builder: (context, state) {
            final employeeId = int.parse(state.pathParameters['employeeId']!);
            return ChangeNotifierProvider(
              create: (_) => sl<EmployeeKpiDetailProvider>(),
              child: SettingsKpiAktivasiPointDetailPage(employeeId: employeeId),
            );
          },
        ),

        // Settings Routes
        GoRoute(
          path: AppRoutes.settings.path,
          name: AppRoutes.settings.name,
          builder: (context, state) => const SettingsPage(),
        ),
        // Settings Absensi Routes
        GoRoute(
          path: AppRoutes.settingsAbsensi.path,
          builder: (context, state) => const SettingsAbsensiPage(),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiPenempatanKerja.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Penempatan Kerja',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiZonasi.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Zonasi',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiJamKerja.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Jam Kerja',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiKaryawan.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Karyawan',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiPekerjaHarian.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Pekerja Harian',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiHariLiburCuti.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Hari Libur & Cuti Bersama',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiLembur.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Lembur',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiAbsenDimanaSaja.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Absen Dimana Saja',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsAbsensiPerbaikanKehadiran.path,
          builder: (context, state) => const absensi_placeholder.SettingsPlaceholderPage(
            title: 'Perbaikan Kehadiran',
          ),
        ),
        GoRoute(
          path: AppRoutes.settingsPenempatanKerja.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Penempatan Kerja'),
        ),
        GoRoute(
          path: AppRoutes.settingsLibur.path,
          builder: (context, state) =>
              const SettingsPlaceholderPage(title: 'Hari Libur & Cuti Bersama'),
        ),
        GoRoute(
          path: AppRoutes.settingsHirarkiOffice.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Hirarki Office'),
        ),
        GoRoute(
          path: AppRoutes.settingsLembur.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Lembur'),
        ),
        GoRoute(
          path: AppRoutes.settingsTindakanKaryawan.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Tindakan Karyawan'),
        ),
        GoRoute(
          path: AppRoutes.settingsBpjs.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'BPJS'),
        ),
        GoRoute(
          path: AppRoutes.settingsPph21.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'PPH 21'),
        ),
        GoRoute(
          path: AppRoutes.settingsJamKerja.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Jam Kerja'),
        ),
        GoRoute(
          path: AppRoutes.settingsFormatDanDraf.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Format dan Draf'),
        ),
        GoRoute(
          path: AppRoutes.settingsAksesLayar.path,
          name: AppRoutes.settingsAksesLayar.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AccessScreenProvider>(),
            child: const AccessScreenListPage(),
          ),
          routes: [
            GoRoute(
              path: 'detail',
              name: AppRoutes.accessScreenDetail.name,
              builder: (context, state) {
                final id = int.parse(state.uri.queryParameters['id'] ?? '0');
                final type = state.uri.queryParameters['type'] ?? 'employee';
                return ChangeNotifierProvider(
                  create: (_) => sl<AccessScreenProvider>(),
                  child: AccessScreenDetailPage(id: id, type: type),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.settingsHakAksesMenu.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Hak Akses Menu'),
        ),
        GoRoute(
          name: AppRoutes.settingsPelacakanJamKerja.name,
          path: AppRoutes.settingsPelacakanJamKerja.path,
          builder: (context, state) => const PelacakanJamKerjaPage(),
          routes: [
            GoRoute(
              name: AppRoutes.pelacakanSettings.name,
              path: 'settings',
              builder: (context, state) {
                final type = state.uri.queryParameters['type'] ?? 'karyawan';
                return ChangeNotifierProvider(
                  create: (_) => sl<PelacakanProvider>(),
                  child: PelacakanSettingsPage(employeeType: type),
                );
              },
              routes: [
                GoRoute(
                  name: AppRoutes.pelacakanEmployeeDetail.name,
                  path: 'employee/:id',
                  builder: (context, state) {
                    final employeeId = int.parse(state.pathParameters['id'] ?? '0');
                    final provider = context.read<PelacakanProvider>();
                    final employee = provider.filteredEmployees.firstWhere(
                      (e) => e.id == employeeId,
                      orElse: () => provider.employees.firstWhere((e) => e.id == employeeId),
                    );
                    return EmployeeDetailPage(employee: employee);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.settingsBahasa.path,
          builder: (context, state) => const SettingsPlaceholderPage(title: 'Ubah Bahasa'),
        ),
      ],

      errorBuilder: (context, state) {
        return const NotFoundPage();
      },
    );
  }
}
