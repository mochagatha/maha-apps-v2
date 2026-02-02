import 'package:equatable/equatable.dart';

class NotificationCount extends Equatable {
  final int notificationCount;
  final int approvalCount;
  final int approvalRequest;

  const NotificationCount({
    required this.notificationCount,
    required this.approvalCount,
    required this.approvalRequest,
  });

  @override
  List<Object?> get props => [
        notificationCount,
        approvalCount,
        approvalRequest,
      ];
}
