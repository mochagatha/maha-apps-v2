// Unified Route Configuration - Single source of truth for route names and paths
class AppRoute {
  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}

class AppRoutes {
  // Authentication
  static const splash = AppRoute('splash', '/');
  static const login = AppRoute('login', '/login');
  static const register = AppRoute('register', '/register');
  static const forgotPassword = AppRoute('forgot-password', '/forgot-password');
  static const termsAndConditions = AppRoute('termsAndConditions', '/terms-and-conditions');
  static const privacyNotice = AppRoute('privacyNotice', '/privacy-notice');
  static const permission = AppRoute('permission', '/permission');

  // Home
  static const home = AppRoute('home', '/home');
  static const adminHome = AppRoute('admin-home', '/admin-home');
  static const adminFaceVerification = AppRoute(
    'admin-face-verification',
    '/admin-face-verification',
  );
  static const adminFaceCamera = AppRoute('admin-face-camera', '/admin-face-camera');
  static const adminFaceResult = AppRoute('admin-face-result', '/admin-face-result');
  static const pesan = AppRoute('pesan', '/pesan');
  static const calendar = AppRoute('calendar', '/calendar');

  // Profile
  static const profile = AppRoute('profile', '/profile');

  // Settings
  static const settings = AppRoute('settings', '/settings');

  // Features
  static const absensi = AppRoute('absensi', '/absensi');
  static const monitoringList = AppRoute('monitoring-list', '/monitoring-list');
  static const approvalList = AppRoute('approval-list', '/approval-list');
  static const workerPlanManager = AppRoute('worker-plan-manager', '/worker-plan-manager');
  static const permintaan = AppRoute('permintaan', '/permintaan');
  static const listFeature = AppRoute('list-feature', '/list-feature');
  static const requestHomeScreen = AppRoute('request-home', '/request-home');
  static const administration = AppRoute('administration', '/administration');
  static const archiveMenu = AppRoute('arsip-menu', '/arsip-menu');
  static const archiveYearMenu = AppRoute('arsip-year-menu', '/arsip-menu/year');
  static const archiveMonthMenu = AppRoute('arsip-month-menu', '/arsip-menu/month');
  static const archiveWorkerStatusMenu = AppRoute('arsip-worker-status-menu', '/arsip-menu/worker-status');
  static const archiveRegistrationMenu = AppRoute('arsip-registration-menu', '/arsip-menu/registration');
  static const archiveStatementMenu = AppRoute('arsip-statement-menu', '/arsip-menu/statement');
  static const archiveAgreementMenu = AppRoute('arsip-agreement-menu', '/arsip-menu/agreement');
  static const archiveDocumentsMenu = AppRoute('arsip-documents-menu', '/arsip-menu/documents');
  static const dataAbsensi = AppRoute('data-absensi', '/data-absensi');
  static const dataKaryawanList = AppRoute('data-karyawan-list', '/data-karyawan-list');
  static const listProyek = AppRoute('list-proyek', '/list-proyek');
  static const reportList = AppRoute('report-list', '/report-list');
  static const dataListPayroll = AppRoute('data-list-payroll', '/data-list-payroll');
  static const approvalNew = AppRoute('approval-new', '/approval-new');
  static const recruitment = AppRoute('recruitment', '/recruitment');
  static const contractUpdates = AppRoute('contract-updates', '/contract-updates');
  static const kpi = AppRoute('kpi', '/kpi');

  // Biodata
  static const welcomeBiodata = AppRoute('welcome-biodata', '/biodata/welcome');
  static const biodataForm = AppRoute('biodata-form', '/biodata/form');
  static const educationForm = AppRoute('education-form', '/biodata/education');
  static const familyForm = AppRoute('family-form', '/biodata/family');
  static const documentForm = AppRoute('document-form', '/biodata/document');
  static const skillForm = AppRoute('skill-form', '/biodata/skill');
  static const selfieForm = AppRoute('selfie-form', '/biodata/selfie');
  static const selfieCamera = AppRoute('selfie-camera', '/biodata/selfie/camera');
  static const selfieResult = AppRoute('selfie-result', '/biodata/selfie/result');
  static const selfieKtpForm = AppRoute('selfie-ktp-form', '/biodata/selfie-ktp');
  static const selfieCameraKtp = AppRoute('selfie-camera-ktp', '/biodata/selfie-ktp/camera');
  static const selfieResultKtp = AppRoute('selfie-result-ktp', '/biodata/selfie-ktp/result');
  static const biodataBank = AppRoute('biodata-bank', '/biodata/bank');
  static const biodataSignature = AppRoute('biodata-signature', '/biodata/signature');
  static const createEmploymentAgreement = AppRoute('create-employment-agreement', '/employment-agreement/create');
  static const detailEmploymentAgreement = AppRoute('detail-employment-agreement', '/employment-agreement/detail');
  static const biodataRevisionNotice = AppRoute('biodata-revision-notice', '/biodata/revision/notice');
  static const biodataRevisionForm = AppRoute('biodata-revision-form', '/biodata/revision/form');
  static const biodataCreateSignature = AppRoute(
    'biodata-create-signature',
    '/biodata/signature/create',
  );
  static const biodataStatementLetter = AppRoute(
    'biodata-statement-letter-statement',
    '/biodata/statement-letter/statement',
  );
  static const biodataStatementLetterSignature = AppRoute(
    'biodata-statement-letter-signature',
    '/biodata/statement-letter/signature',
  );
  static const employeeEmploymentAgreement = AppRoute(
    'employee-employment-agreement',
    '/employment-agreement/employee',
  );

  // Recruitment
  static const verificationData = AppRoute('verification-data', '/recruitment/verification-data');
  static const employeeVerification = AppRoute(
    'employee-verification',
    '/recruitment/employee-verification',
  );
  static const employeePersonalData = AppRoute(
    'employee-personal-data',
    '/recruitment/personal-data/employee',
  );
  static const companyCode = AppRoute('company-code', '/recruitment/company-code');
  static const recruitmentAgreement = AppRoute('recruitment-agreement', '/recruitment/agreement');
  static const recruitmentEMatrai = AppRoute('recruitment-e-matrai', '/recruitment/e-matrai');
  static const employeeEMatrai = AppRoute('recruitment-employee-e-matrai', '/recruitment/e-matrai/employee');
  static const workerEMatrai = AppRoute('recruitment-worker-e-matrai', '/recruitment/e-matrai/worker');
  static const recruitmentBpjsActivation = AppRoute(
    'recruitment-bpjs-activation',
    '/recruitment/bpjs-activation',
  );

  // Organizational Structure
  static const organizationalStructure = AppRoute(
    'organizational-structure',
    '/organizational-structure',
  );
  static const structureMain = AppRoute('structure-main', '/organizational-structure/main');
  static const structureProject = AppRoute(
    'structure-project',
    '/organizational-structure/project',
  );
  static const organizationalChart = AppRoute(
    'organizational-chart',
    '/organizational-structure/chart',
  );
  static const employmentLevel = AppRoute(
    'employment-level',
    '/organizational-structure/employment-level',
  );
  static const employmentLevelOffice = AppRoute(
    'employment-level-office',
    '/organizational-structure/employment-level/office',
  );
  static const employmentLevelProject = AppRoute(
    'employment-level-project',
    '/organizational-structure/employment-level/project',
  );
  static const employmentLevelOfficeEmployee = AppRoute(
    'employment-level-office-employee',
    '/organizational-structure/employment-level/office/employee',
  );
  static const employmentLevelOfficeWorker = AppRoute(
    'employment-level-office-worker',
    '/organizational-structure/employment-level/office/worker',
  );
  static const employmentLevelProjectEmployee = AppRoute(
    'employment-level-project-employee',
    '/organizational-structure/employment-level/project/employee',
  );
  static const employmentLevelProjectWorker = AppRoute(
    'employment-level-project-worker',
    '/organizational-structure/employment-level/project/worker',
  );
  static const departmentList = AppRoute('department-list', '/organizational-structure/department');
  static const departmentOffice = AppRoute(
    'department-office',
    '/organizational-structure/department/office',
  );
  static const departmentProject = AppRoute(
    'department-project',
    '/organizational-structure/department/project',
  );
  static const jobTitleList = AppRoute('job-title-list', '/organizational-structure/job-title');
  static const jobTitleOffice = AppRoute(
    'job-title-office',
    '/organizational-structure/job-title/office',
  );
  static const jobTitleProject = AppRoute(
    'job-title-project',
    '/organizational-structure/job-title/project',
  );
  static const jobTitleOfficeEmployee = AppRoute(
    'job-title-office-employee',
    '/organizational-structure/job-title/office/employee',
  );
  static const jobTitleOfficeWorker = AppRoute(
    'job-title-office-worker',
    '/organizational-structure/job-title/office/worker',
  );
  static const jobTitleProjectEmployee = AppRoute(
    'job-title-project-employee',
    '/organizational-structure/job-title/project/employee',
  );
  static const jobTitleProjectWorker = AppRoute(
    'job-title-project-worker',
    '/organizational-structure/job-title/project/worker',
  );
  static const jobTitleSelection = AppRoute(
    'job-title-selection',
    '/organizational-structure/job-title-selection',
  );
  static const employeeByJobTitleSelection = AppRoute(
    'employee-by-job-title-selection',
    '/organizational-structure/employee-by-job-title-selection',
  );

  // Access Menu
  static const employeeSelection = AppRoute('employee-selection', '/employee-selection');
  static const accessMenuList = AppRoute('access-menu-list', '/access-menu');
  static const settingsAksesLayar = AppRoute('access-screen-list', '/settings/akses-layar');
  static const accessScreenDetail = AppRoute(
    'access-screen-detail',
    '/settings/akses-layar/detail',
  );

  // Settings Submenus
  static const settingsAbsensi = AppRoute('settings-absensi', '/settings/absensi');
  static const settingsAbsensiDetailJamKerja = AppRoute('settings-absensi-detail-jam-kerja', '/settings/absensi/jam-kerja/detail');
  static const settingsAbsensiEditJamKerja = AppRoute('settings-absensi-edit-jam-kerja', '/settings/absensi/jam-kerja/edit');
  static const settingsLibur = AppRoute('settings-libur', '/settings/libur');
  static const settingsAbsensiPenempatanKerja = AppRoute(
    'settings-absensi-penempatan-kerja',
    '/settings/absensi/penempatan-kerja',
  );
  static const settingsAbsensiZonasi = AppRoute(
    'settings-absensi-zonasi',
    '/settings/absensi/zonasi',
  );
  static const settingsAbsensiJamKerja = AppRoute(
    'settings-absensi-jam-kerja',
    '/settings/absensi/jam-kerja',
  );
  static const settingsAbsensiKaryawan = AppRoute(
    'settings-absensi-karyawan',
    '/settings/absensi/karyawan',
  );
  static const settingsAbsensiPekerjaHarian = AppRoute(
    'settings-absensi-pekerja-harian',
    '/settings/absensi/pekerja-harian',
  );
  static const settingsAbsensiPenempatanKaryawan = AppRoute(
    'settings-absensi-penempatan-karyawan',
    '/settings/absensi/penempatan/karyawan',
  );
  static const settingsAbsensiPenempatanPekerjaHarian = AppRoute(
    'settings-absensi-penempatan-pekerja-harian',
    '/settings/absensi/penempatan/pekerja-harian',
  );
  static const settingsAbsensiHariLiburCuti = AppRoute(
    'settings-absensi-hari-libur-cuti',
    '/settings/absensi/hari-libur-cuti-bersama',
  );
  static const settingsAbsenceJointLeave = AppRoute(
    'settings-absensi-joint-leave',
    '/settings/absensi/joint-leave',
  );
  static const settingsAbsenceAddJointLeave = AppRoute(
    'settings-absensi-add-joint-leave',
    '/settings/absensi/joint-leave/add',
  );
  static const settingsAbsensiLembur = AppRoute(
    'settings-absensi-lembur',
    '/settings/absensi/lembur',
  );
  static const settingsAbsensiLemburKaryawan = AppRoute(
    'settings-absensi-lembur-karyawan',
    '/settings/absensi/lembur/karyawan',
  );
  static const settingsAbsensiLemburKaryawanOrangan = AppRoute(
    'settings-absensi-lembur-karyawan-orangan',
    '/settings/absensi/lembur/karyawan/orangan',
  );
  static const settingsAbsensiLemburPekerjaHarian = AppRoute(
    'settings-absensi-lembur-pekerja-harian',
    '/settings/absensi/lembur/pekerja-harian',
  );
  static const settingsAbsensiLemburPekerjaHarianOrangan = AppRoute(
    'settings-absensi-lembur-pekerja-harian-orangan',
    '/settings/absensi/lembur/pekerja-harian/orangan',
  );
  static const settingsAbsensiAbsenDimanaSaja = AppRoute(
    'settings-absensi-absen-dimana-saja',
    '/settings/absensi/absen-dimana-saja',
  );
  static const settingsAbsensiAbsenDimanaSajaKaryawan = AppRoute(
    'settings-absensi-absen-dimana-saja-karyawan',
    '/settings/absensi/absen-dimana-saja/karyawan',
  );
  static const settingsAbsensiAbsenDimanaSajaKaryawanOrangan = AppRoute(
    'settings-absensi-absen-dimana-saja-karyawan-orangan',
    '/settings/absensi/absen-dimana-saja/karyawan/orangan',
  );
  static const settingsAbsensiAbsenDimanaSajaPekerjaHarian = AppRoute(
    'settings-absensi-absen-dimana-saja-pekerja-harian',
    '/settings/absensi/absen-dimana-saja/pekerja-harian',
  );
  static const settingsAbsensiAbsenDimanaSajaPekerjaHarianOrangan = AppRoute(
    'settings-absensi-absen-dimana-saja-pekerja-harian-orangan',
    '/settings/absensi/absen-dimana-saja/pekerja-harian/orangan',
  );
  static const settingsAbsensiPerbaikanKehadiran = AppRoute(
    'settings-absensi-perbaikan-kehadiran',
    '/settings/absensi/perbaikan-kehadiran',
  );
  static const settingsPenempatanKerja = AppRoute(
    'settings-penempatan-kerja',
    '/settings/penempatan-kerja',
  );
  static const settingsHirarkiOffice = AppRoute(
    'settings-hirarki-office',
    '/settings/hirarki-office',
  );
  static const settingsLembur = AppRoute('settings-lembur', '/settings/lembur');
  static const settingsTindakanKaryawan = AppRoute(
    'settings-tindakan-karyawan',
    '/settings/tindakan-karyawan',
  );
  static const settingsBpjs = AppRoute('settings-bpjs', '/settings/bpjs');
  static const settingsPph21 = AppRoute('settings-pph21', '/settings/pph21');
  static const settingsJamKerja = AppRoute('settings-jam-kerja', '/settings/jam-kerja');
  static const settingsFormatDanDraf = AppRoute(
    'settings-format-dan-draf',
    '/settings/format-dan-draf',
  );
  static const settingsHakAksesMenu = AppRoute(
    'settings-hak-akses-menu',
    '/settings/hak-akses-menu',
  );
  static const settingsBahasa = AppRoute('settings-bahasa', '/settings/bahasa');
  static const settingsEmail = AppRoute('settings-email', '/settings/email');
  static const settingsWhatsapp = AppRoute('settings-whatsapp', '/settings/whatsapp');
  static const settingsAlurOperasional = AppRoute(
    'settings-alur-operasional',
    '/settings/alur-operasional',
  );
  static const settingsNotifikasi = AppRoute('settings-notifikasi', '/settings/notifikasi');

  // Settings KPI
  static const settingsKpi = AppRoute('settings-kpi', '/settings/kpi');
  static const settingsKpiTargetPoint = AppRoute(
    'settings-kpi-target-point',
    '/settings/kpi/target-point',
  );
  static const settingsKpiPenilaianKinerja = AppRoute(
    'settings-kpi-penilaian-kinerja',
    '/settings/kpi/penilaian-kinerja',
  );
  static const settingsKpiUbahPeriodeSurat = AppRoute(
    'settings-kpi-ubah-periode-surat',
    '/settings/kpi/ubah-periode-surat',
  );
  static const settingsKpiPengaturanAktivasiPoint = AppRoute(
    'settings-kpi-pengaturan-aktivasi-point',
    '/settings/kpi/pengaturan-aktivasi-point',
  );
  static const settingsKpiPengaturanAktivasiPointDetail = AppRoute(
    'settings-kpi-pengaturan-aktivasi-point-detail',
    '/settings/kpi/pengaturan-aktivasi-point/:employeeId',
  );

  // Pelacakan Jam Kerja
  static const settingsPelacakanJamKerja = AppRoute(
    'pelacakan-jam-kerja',
    '/settings/pelacakan-jam-kerja',
  );
  static const pelacakanSettings = AppRoute(
    'pelacakan-settings',
    '/settings/pelacakan-jam-kerja/settings',
  );
  static const pelacakanEmployeeDetail = AppRoute(
    'pelacakan-employee-detail',
    '/settings/pelacakan-jam-kerja/employee',
  );
}
