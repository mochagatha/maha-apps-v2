import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/profile_repository.dart';

/// Use case for updating employee profile
/// Updates employee profile information
class UpdateEmployeeProfile implements UseCase<Employee, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateEmployeeProfile(this.repository);

  @override
  Future<Either<Failure, Employee>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params.toMap());
  }
}

/// Parameters for updating employee profile
class UpdateProfileParams extends Equatable {
  final String? phone;
  final String? address;
  final String? emergencyContact;
  final String? emergencyPhone;

  const UpdateProfileParams({
    this.phone,
    this.address,
    this.emergencyContact,
    this.emergencyPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (emergencyContact != null) 'emergency_contact': emergencyContact,
      if (emergencyPhone != null) 'emergency_phone': emergencyPhone,
    };
  }

  @override
  List<Object?> get props => [phone, address, emergencyContact, emergencyPhone];
}
