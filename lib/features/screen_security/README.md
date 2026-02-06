# Screen Security Feature

Fitur untuk mencegah screenshot dan screen recording di aplikasi berdasarkan konfigurasi dari API.

## Struktur Feature

Mengikuti Clean Architecture pattern:

```
screen_security/
├── data/
│   ├── datasources/
│   │   └── screen_security_remote_datasource.dart
│   ├── models/
│   │   └── screen_security_model.dart
│   └── repositories/
│       └── screen_security_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── screen_security_entity.dart
│   ├── repositories/
│   │   └── screen_security_repository.dart
│   └── usecases/
│       └── get_screen_security_settings.dart
└── presentation/
    └── providers/
        └── screen_security_provider.dart
```

## API Integration

### Endpoint

```
GET /record-screen-app/get-by-employee-worker-id
Base URL: BASE_URL_GOLANG
```

### Query Parameters

- `type`: "employee" atau "worker"
- `employee_worker_id`: ID dari employee/worker

### Response Example

```json
{
  "status": "success",
  "code": 200,
  "message": "OK",
  "data": {
    "id": 1,
    "employee_worker_id": 11,
    "is_record": false,
    "is_catch": true,
    "type": "employee",
    "employee": {
      "id": 11,
      "nik": "31024021",
      "fullname": "Nur Alimul Haq",
      "photo_url": "...",
      "status_label": "Aktif",
      "department": {
        "department_name": "Electronica & Information Technology"
      },
      "job_title": {
        "name": "IT Programming"
      }
    }
  }
}
```

## Logika Security

**PENTING:** Logika terbalik dari nama fieldnya!

- **`is_catch = true`**: Screenshot **BISA DITANGKAP** → Screenshot DIPERBOLEHKAN ✅ (tidak di-block)
- **`is_catch = false`**: Screenshot **TIDAK BISA DITANGKAP** → Screenshot DIBLOKIR ❌ (di-block)
- **`is_record = true`**: Screen recording DIPERBOLEHKAN ✅
- **`is_record = false`**: Screen recording DIBLOKIR ❌

**Contoh:**

- API return `is_catch: true` → User **BISA** screenshot (proteksi OFF)
- API return `is_catch: false` → User **TIDAK BISA** screenshot (proteksi ON)

## Implementasi

### 1. Library yang Digunakan

- **`screen_protector`** v1.5.1 - Library modern untuk mencegah screenshot dan screen recording
  - Support Android & iOS
  - Lebih aktif di-maintain dibanding flutter_windowmanager

### 2. Inisialisasi di App Startup

Security settings otomatis di-fetch dan diterapkan saat aplikasi startup di `main.dart`:

```dart
// Dipanggil setelah user login
await screenSecurityProvider.fetchAndApplySecuritySettings(
  type: 'employee',
  employeeWorkerId: employeeId,
);
```

### 3. Metode Security yang Diterapkan

**Prevent Screenshot:**

```dart
await ScreenProtector.protectDataLeakageOn();
```

**Allow Screenshot:**

```dart
await ScreenProtector.protectDataLeakageOff();
```

### 4. Platform Support

- ✅ **Android**: Full support - mencegah screenshot dan screen recording
- ✅ **iOS**: Support screenshot prevention, screen recording limitation (OS restriction)
- ❌ **Web**: Tidak support (browser limitation)

## Cara Penggunaan

### Get Current Security Status

```dart
final provider = context.read<ScreenSecurityProvider>();
bool isSecurityEnabled = provider.isSecurityEnabled;
ScreenSecurityEntity? settings = provider.securitySettings;
```

### Manually Disable Security (jika diperlukan)

```dart
await provider.disableSecurity();
```

### Re-fetch Settings

```dart
await provider.fetchAndApplySecuritySettings(
  type: 'employee',
  employeeWorkerId: employeeId,
);
```

## Dependency Injection

Semua dependencies sudah terdaftar di `injection_container.dart`:

- ScreenSecurityProvider (Factory)
- GetScreenSecuritySettings (LazySingleton)
- ScreenSecurityRepository (LazySingleton)
- ScreenSecurityRemoteDataSource (LazySingleton)

## Testing

Unit test dapat dibuat untuk:

- Use case (GetScreenSecuritySettings)
- Repository implementation
- Provider state management

## Catatan

1. Security settings hanya diterapkan pada platform mobile (Android/iOS)
2. Settings di-fetch setiap kali user login berhasil
3. Jika API gagal, aplikasi tetap berjalan normal tanpa security restriction
4. Provider state bisa dimonitor untuk debugging: `ScreenSecurityStatus.loading`, `loaded`, `error`
5. Security otomatis di-disable saat logout

## Debug Mode

Untuk memudahkan debugging, tambahkan `ScreenSecurityStatusWidget` di halaman yang ingin di-debug:

```dart
import '../../../screen_security/presentation/widgets/screen_security_status_widget.dart';

// Di dalam widget build
Column(
  children: [
    const ScreenSecurityStatusWidget(), // Hanya muncul di debug mode
    // ... widget lainnya
  ],
)
```

Widget ini akan menampilkan:

- Status security (enabled/disabled)
- Nilai is_catch dan is_record dari API
- Error message jika ada

## Troubleshooting

### Screenshot masih bisa diambil padahal is_catch = true

**Solusi:**

1. Pastikan running di **device fisik**, bukan emulator (emulator sering bypass security)
2. Cek console log saat login, pastikan ada log:
   ```
   🔒 Fetching screen security settings for employee: [ID], type: employee
   ✅ Screen security settings loaded:
      - is_record: false
      - is_catch: true
   🛡️ Applying security settings:
      - shouldBlockScreenshot (is_catch): true
   🔒 Screenshot protection ENABLED
   ```
3. Pastikan `screen_protector` package ter-install dengan benar: `flutter pub get`
4. Test dengan mengambil screenshot:
   - **Android**: Power + Volume Down
   - **iOS**: Power + Volume Up
   - Harusnya muncul notifikasi "Can't take screenshot" atau layar hitam

### API error atau timeout

**Solusi:**

1. Pastikan BASE_URL_GOLANG sudah benar di `.env`
2. Cek endpoint di Postman: `GET /record-screen-app/get-by-employee-worker-id?type=employee&employee_worker_id=[ID]`
3. Pastikan employee_id valid dan ada di database

### Security tidak diterapkan setelah login

**Solusi:**

1. Pastikan user memiliki `employeeId` setelah login
2. Cek apakah `fetchAndApplySecuritySettings` dipanggil di `login_page.dart`
3. Restart aplikasi setelah login pertama kali

### Web/Desktop platform

Screen security **tidak support** di Web/Desktop karena limitasi platform. Library hanya bekerja di Android dan iOS.
