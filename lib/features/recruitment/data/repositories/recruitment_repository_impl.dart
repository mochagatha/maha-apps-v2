import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recruitment_menu_item.dart';
import '../../domain/repositories/recruitment_repository.dart';
import '../datasources/recruitment_remote_datasource.dart';

class RecruitmentRepositoryImpl implements RecruitmentRepository {
  final RecruitmentRemoteDataSource remoteDataSource;

  RecruitmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<RecruitmentMenuItem>>> getRecruitmentMenus() async {
    try {
      final menuModels = await remoteDataSource.getRecruitmentMenus();
      final menuEntities = menuModels.map((model) => model.toEntity()).toList();
      return Right(menuEntities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
