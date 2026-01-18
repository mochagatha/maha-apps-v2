import '../entities/notification_count.dart';

class NotificationCountModel extends NotificationCount {
  const NotificationCountModel({
    required int notificationCount,
    required int approvalCount,
    required int approvalRequest,
  }) : super(
          notificationCount: notificationCount,
          approvalCount: approvalCount,
          approvalRequest: approvalRequest,
        );

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) {
    return NotificationCountModel(
      notificationCount: json['notification_count'] ?? 0,
      approvalCount: json['approval_count'] ?? 0,
      approvalRequest: json['approval_request'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_count': notificationCount,
      'approval_count': approvalCount,
      'approval_request': approvalRequest,
    };
  }

  NotificationCount toEntity() {
    return NotificationCount(
      notificationCount: notificationCount,
      approvalCount: approvalCount,
      approvalRequest: approvalRequest,
    );
  }
}
