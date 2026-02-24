import 'package:equatable/equatable.dart';
import 'e_matrai_item.dart';

class EMatraiCount extends Equatable {
  final int all;
  final int approve;
  final int newCount;
  final int upload;

  const EMatraiCount({
    required this.all,
    required this.approve,
    required this.newCount,
    required this.upload,
  });

  @override
  List<Object?> get props => [all, approve, newCount, upload];
}

class EMatraiList extends Equatable {
  final EMatraiCount count;
  final List<EMatraiItem> items;

  const EMatraiList({
    required this.count,
    required this.items,
  });

  @override
  List<Object?> get props => [count, items];
}
