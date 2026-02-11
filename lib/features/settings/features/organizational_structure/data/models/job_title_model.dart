import '../../domain/entities/job_title_entity.dart';

class JobTitleModel extends JobTitleEntity {
  const JobTitleModel({
    super.id,
    super.name,
  });

  factory JobTitleModel.fromJson(Map<String, dynamic> json) {
    return JobTitleModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  JobTitleEntity toEntity() {
    return JobTitleEntity(
      id: id,
      name: name,
    );
  }
}
