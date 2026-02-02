import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_count.dart';
import '../repositories/home_repository.dart';

class GetNotificationCount implements UseCase<NotificationCount, NoParams> {
  final HomeRepository repository;

  GetNotificationCount(this.repository);

  @override
  Future<Either<Failure, NotificationCount>> call(NoParams params) async {
    return await repository.getNotificationCount();
  }
}
