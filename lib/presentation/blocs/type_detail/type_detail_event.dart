import 'package:equatable/equatable.dart';

abstract class TypeDetailEvent extends Equatable {
  const TypeDetailEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện kiểm tra trạng thái xác thực
class GetTypeDetai extends TypeDetailEvent {
  final String typeIdOrName;
  const GetTypeDetai({
    required this.typeIdOrName,
  });
}
