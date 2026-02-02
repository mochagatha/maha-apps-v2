import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recruitment_menu_item.dart';

abstract class RecruitmentRepository {
  Future<Either<Failure, List<RecruitmentMenuItem>>> getRecruitmentMenus();
}
