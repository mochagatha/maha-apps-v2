import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/recruitment_menu_item.dart';
import '../repositories/recruitment_repository.dart';

class GetRecruitmentMenus implements UseCase<List<RecruitmentMenuItem>, NoParams> {
  final RecruitmentRepository repository;

  GetRecruitmentMenus(this.repository);

  @override
  Future<Either<Failure, List<RecruitmentMenuItem>>> call(NoParams params) async {
    return await repository.getRecruitmentMenus();
  }
}
