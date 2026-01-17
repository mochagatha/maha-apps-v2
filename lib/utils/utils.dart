import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String baseUrl = dotenv.env['BASE_URL']!;
  static String baseUrlGolang = dotenv.env['BASE_URL_GOLANG']!;
  static String baseUrlPublic = dotenv.env['BASE_URL_PUBLIC']!;
  static String baseUrlEmployee = dotenv.env['BASE_URL_EMPLOYEE']!;
  static String baseUrlRegion = dotenv.env['BASE_URL_REGION']!;
  static String baseUrlLetter = dotenv.env['BASE_URL_LETTER']!;
  static String baseUrlAttendance = dotenv.env['BASE_URL_ATTENDANCE']!;
  static String baseUrlPayroll = dotenv.env['BASE_URL_PAYROLL']!;
  static String baseUrlVersion = dotenv.env['BASE_URL_VERSION']!;
  static String baseUrlVersionGolang = dotenv.env['BASE_URL_VERSION_GOLANG']!;
  static String baseUrlCount = dotenv.env['BASE_URL_COUNT']!;
  // static const String getAllEmployee = '/employee';
  // static const String updateDataEmployee = '/employee/employee-data';
  // static const String verifyRegister = '/employee/verify-register-new';
  // static const String verifyData = '/employee/verify-data-recruitment';
  // static const String verifyHrManager = '/employee/verify-data-phase-two';
  // static const String rejectHrManager = '/employee/reject-data-phase-two';
  // static const String rejectDataHrRekrutmen = '/employee/reject-data';
  // static const String getDocumentById = '/employee/employee-document';
  // static const String uploadDokumen = '/employee/employee-document';
  // static const String verifDirektur = '/employee/verify-contract-director';
  // static const String rejectDirektur = '/employee/reject-contract-director';
  // static const String changeStatus = '/employee/change-status';
  // static const String getAllWorkHour = '/work-hour';
  // static const String getFamily = '/employee/employee-family';
  // static const String getSibling = '/employee/employee-sibling';
  // static const String getSkill = '/employee/employee-skill';
  // static const String addWorkHourKaryawan = '/employee/employee-work-hour';
  // static const String getJobdesk = '/employee/employee-contract';
  // static const String ajukanKembali = '/employee/revision-data-recruitment';
  // static const String getAllHoliday = '/attendance/holiday';
  // static const String updateFoto = '/employee/employee-selfie';
  // static const String getAllAttendance =
  //     "/attendance/monitoring/today-statistic";
  // static const String addCouple = '/employee/employee-marital';
  // static const String addChildren = '/employee/employee-children';
  // // static const String getAllEmployeePresent =
  // //     '/attendance/new-get-by-date-and-branch';
  // static const String getAllEmployeePresent =
  //     '/attendance/new-get-by-date-and-branch-v2';
  // static const String getEmployeeByBranch = '/employee/search-permit';
  // static const String checkFakeGps = "/letter/fake-gps-report";
  // static const String addOvertime = '/attendance/overtime-order';
  // static const String getOvertime = '/attendance/overtime-order';
  // static const String getSupervision = '/attendance/supervision-order';
  // static const String getEmployeeNoDirektur = '/employee/get-all-active';
  // static const String getAllDeduction = '/payroll/deduction-type';
  // static const String getAllDeductionEmployee = '/payroll/deduction';
  // static const String getAllDeductionEmployeeV2 =
  //     '/payroll/deduction/create-v2';
  // static const String addDeductionWorkerV2 =
  //     '/payroll/deduction-worker/create-v2';
  // static const String addAdditionalWorkerV2 =
  //     '/payroll/additional-worker/create-v2';
  // static const String getAllDevisi = '/department';
  // static const String sendOtp = '/employee/send-otp-forgot-password';
  // static const String verifOtp = '/employee/verify-otp-forgot-password';
  // static const String resetPassword = '/employee/reset-password';
  // static const String sendToken = '/employee/employee-fcm-token';
  // static const String loan = '/payroll/loan-application';
  // static const String loanV2 = '/payroll/loan-application/v2/create';
  // static const String maxLoan =
  //     '/payroll/loan-application/max-loan-by-employee';
  // static const String historyLoan = '/payroll/loan-application/get-by-employee';
  // static const String refreshToken = '/employee/refresh-token';
  // static const String getAllBranch = '/branch/get-all';
  // static const String getWorkerByBranch = '/employee/worker';
  // static const String submitWorkerForListLoan =
  //     '/payroll/worker-loan-application/list';
  // static const String getListLoanWorker =
  //     '/payroll/worker-loan-application/list/get-by-boss';
  // static const String submitLoanWorker = '/payroll/worker-loan-application';
  // static const String getListLoanWorkerAfterSubmit =
  //     '/payroll/worker-loan-application/get-by-boss';
  // static const String addPPH21 = '/employee/employee-pph-categories';
  // static const String addPPH21Worker = '/employee/worker-pph-categories';
  // static const String getAllJobTitle = '/job-title';
  // static const String addHirarki = '/employee/hierarchy-structure-project';
  // static const String addHirarkiOffice = '/employee/hierarchy-structure-office';
  // static const String getAllSupervisorByBranch =
  //     '/employee/hierarchy-structure-project/get-supervisor-by-branch';
  // static const String getAllSupervisorByBranchOffice =
  //     '/employee/hierarchy-structure-office/get-supervisor-by-branch';
  // static const String gethirarkiStrukturByBranch =
  //     '/employee/hierarchy-structure-project/get-by-branch';
  // static const String gethirarkiStrukturOfficeByBranch =
  //     '/employee/hierarchy-structure-office/get-by-branch';
  // static const String gethirarkiStrukturById =
  //     '/employee/hierarchy-structure-project/get-by-id';
  // static const String gethirarkiStrukturOfficeById =
  //     '/employee/hierarchy-structure-office/get-by-id';
  // static const String getAllWorker = '/employee/worker';
  // static const String addHirarkiStrukturPrijectDetail =
  //     '/employee/hierarchy-structure-project-detail/create-update-delete';
  // static const String addHirarkiStrukturOfficeDetail =
  //     '/employee/hierarchy-structure-office-detail/create-update-delete';
  // static const String addDuties =
  //     '/employee/hierarchy-structure-project-duties';
  // static const String addDutiesOffice =
  //     '/employee/hierarchy-structure-office-duties';
  // static const String getDutiesOffice =
  //     '/employee/hierarchy-structure-office-duties/get-by-hierarchy-structure-office-id';
  // static const String getDuties =
  //     '/employee/hierarchy-structure-project-duties/get-by-hierarchy-structure-project-id';
  // static const String addAuthority =
  //     '/employee/hierarchy-structure-project-authority';
  // static const String addAuthorityOffice =
  //     '/employee/hierarchy-structure-office-authority';
  // static const String getProjectManager = '/employee/project-manager/get-all';
  // static const String getProjectManagerByIdEmployee =
  //     '/employee/project-manager/get-by-employee-id';
  // static const String getBranceByProjectManager =
  //     '/employee/project-manager/get-by-employee-id';
  // static const String getAllListEmployeeForApproval =
  //     '/payroll/loan-application/get-by-position';
  // static const String approvalLoan =
  //     "/payroll/loan-application/approve-by-position";
  // static const String getLoanWorkerByFilter =
  //     "/payroll/worker-loan-application/filter-data";
  // static const String approvalWorker =
  //     "/payroll/worker-loan-application/approve-by-job-title";
  // static const String sendLocation = "/letter/employee-off-site";
  // static const String employeeNotification =
  //     "/employee/employee-notification/get-by-employee-id";
  // static const String readNotification = "/employee-notification/read";
  // static const String readAllNotification =
  //     "/employee/employee-notification/read-all-by-employee";
  // static const String deleteAllNotificationIsRead =
  //     "/employee/employee-notification/delete-all-by-employee";
  // static const String getEmployeeFillter = '/employee/search-employee';
  // static const String getProject = '/branch/project';
  // static const String getRecapAttendance = '/attendance/recap/attendances';
  // static const String settingOvertime = '/employee/employee-overtime-setting';
  // static const String getAllAdditional = '/payroll/additional-type';
  // static const String addAddentialEmployee = '/payroll/additional';
  // static const String addAddentialEmployeeV2 = '/payroll/additional/create-v2';
  // static const String settingOvertimeWorker =
  //     '/employee/worker-overtime-setting';
  // static const String handover = '/letter/handover';
  // static const String getTaskLetterByEmployeeId =
  //     "/letter/employee-assignment-letter/get-by-employee-id";
  // static const String getTaskLetterById =
  //     "/letter/employee-assignment-letter/get-by-id";
  // static const String getTaskLetterByBossId =
  //     "/letter/employee-assignment-letter/get-by-boss-id";
  // static const String getTaskLetterByjobTitleId =
  //     "/letter/employee-assignment-letter/get-by-job-title";
  // static const String approveTaskLetter =
  //     "/letter/employee-assignment-letter/approve-by-job-title";
  // static const String addTaskLetter = "/letter/employee-assignment-letter";
  // static const String addAttachmentTaskLetter =
  //     "/letter/employee-assignment-letter/upload-attachment";
  // static const String submitDoneTaskLetter =
  //     "/letter/employee-assignment-letter/submit-done";
  // static const String getPermintaanBySenderId =
  //     "/letter/employee-request/get-by-sender-id";
  // static const String getPermintaanByReceiverId =
  //     "/letter/employee-request/get-by-receiver-id";
  // static const String addPermintaan = "/letter/employee-request";
  // static const String approvePermintaan = "/letter/employee-request/accept";
  // static const String rejectPermintaan = "/letter/employee-request/reject";
  // static const String pendapatan = "/payroll/additional";
  // static const String warningLetter = "/letter/warning-letter";
  // static const String getAllBranchProyek = '/branch/project';
  // static const String getHistoryOvertimeWorker = '/attendance/overtime-worker';
  // static const String bpjs = '/employee/employee-bpjs';
  // static const String version = '/version';
  // static const String bpjsContribution = '/employee/bpjs-contribution';
  // static const String offSite = '/letter/employee-off-site';
  // // static const String notificationCountByJobTitle = '/employee/employee-notification/count-by-job-title';
  // static const String notificationCount = '/notification/count';
  // static const String notificationCountV2 =
  //     '/employee/employee-notification/count-by-job-title';
  // static const String changeContract = '/employee/change-contract';
  // static const String promotion = '/employee/promotion';
  // static const String cobination = '/employee/combination/get-all';
  // static const String demotion = '/employee/demotion';
  // static const String mutation = '/employee/mutation';
  // static const String overtimeEmployee =
  //     '/attendance/overtime/create-by-employee';
  // static const String supervisionEmployee =
  //     '/attendance/supervision-order/create-by-employee';
  // static const String getSupervisionEmployee =
  //     '/attendance/supervision-order/get-by-employee';
  // static const String attendanceAnywhere = '/attendance/attendance-anywhere';
  // static const String employeeTask = '/employee/employee-task';
  // static const String fcmToken = '/employee/employee-fcm-token';
  // static const String filterDropdown =
  //     '/employee/employee-worker/get-all-by-filter';
  // static const String upgradeSalary = '/employee/employee-salary-increase';
  // static const String downgradeSalary = '/employee/employee-salary-reduction';
  // static const String leaveEfficient = '/attendance/leave';
  // static const String sickEfficient = '/attendance/sick';
  // static const String permitEfficient = '/attendance/permit';
  // static const String workerEfficient = '/employee/worker';
  // static const String slipLoan = '/payroll/loan-application';
  // static const String userRole = '/employee/user-role';
  // static const String companyStructure = '/employee/company-structure';
  // static const String ScreenSetting = '/record-screen-app';
  // static const String logActivityApp = '/log-activity-app';
  // static const String settingOvertimeV2 = '/employee/overtime-setting';
  // static const String overtimeV2 = '/attendance/overtime';
}
