// pi_detail_state.dart
import 'package:equatable/equatable.dart';
import 'package:tuple/tuple.dart';

abstract class PIDetailState extends Equatable {
  const PIDetailState();

  @override
  List<Object> get props => [];
}

class PIDetailInitial extends PIDetailState {}

class PIDetailLoading extends PIDetailState {}

class BranchListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  const BranchListLoaded({
    required this.getList,
  });

  @override
  List<Object> get props => [getList];
}

class ProductListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const ProductListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class PiPuroseListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const PiPuroseListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class EndoresementTypeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const EndoresementTypeListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class FuelTypeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;
  final String name;

  const FuelTypeListLoaded({required this.getList, required this.name});

  @override
  List<Object> get props => [getList, name];
}

class VehicleCategoryListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const VehicleCategoryListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class PIDetailShowEndorsementState extends PIDetailState {
  final bool isShowEndorsementType;
  final bool isShowPolicyNumber;

  const PIDetailShowEndorsementState({
    required this.isShowEndorsementType,
    required this.isShowPolicyNumber,
  });
}

class PIDetailProductCodeFetched extends PIDetailState {
  final String productCode;
  final String api;

  const PIDetailProductCodeFetched(this.productCode, this.api);
}

class SeatingCapacityLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const SeatingCapacityLoaded({required this.getList});
}

class GVWLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const GVWLoaded({required this.getList});
}

class MakeListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const MakeListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class ModelListLoaded extends PIDetailState {
  final List<Tuple2<String?, String?>?> getList;

  const ModelListLoaded({required this.getList});

  @override
  List<Object> get props => [getList];
}

class PIDetailError extends PIDetailState {
  final String message;

  const PIDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
