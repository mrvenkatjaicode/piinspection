// pi_detail_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

abstract class PIDetailEvent extends Equatable {
  const PIDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadPIDetail extends PIDetailEvent {
  final bool ownpi;
  final bool otherpi;
  final bool ishitapi;
  final String preinsid;
  final String partid;

  const LoadPIDetail({
    required this.ownpi,
    required this.otherpi,
    required this.ishitapi,
    required this.preinsid,
    required this.partid,
  });

  @override
  List<Object> get props => [ownpi, otherpi, ishitapi, preinsid, partid];
}

class ProductSelected extends PIDetailEvent {
  final String productName;
  final String api;

  const ProductSelected(this.productName, this.api);
}

class FetchBranchNameApi extends PIDetailEvent {}

class ChooseDDValue extends PIDetailEvent {
  final TextEditingController controller;
  final List<Tuple2<String?, String?>?> getList;
  final String screenName;
  final BuildContext context;

  const ChooseDDValue(
      {required this.controller,
      required this.getList,
      required this.screenName,
      required this.context});
}

class FetchLoadComboApi extends PIDetailEvent {
  final String? partyId;
  final String name;
  const FetchLoadComboApi({required this.partyId, required this.name});
}

class FetchVehicleCategoryApi extends PIDetailEvent {
  final String? partyId;
  final String? vehCode;
  const FetchVehicleCategoryApi({required this.partyId, required this.vehCode});
}

class FetchSeatingCapacity extends PIDetailEvent {}

class Fetchgvw extends PIDetailEvent {}

class FetchMakeApi extends PIDetailEvent {
  final String? partyId;
  final String? productCode;
  const FetchMakeApi({required this.partyId, required this.productCode});
}

class SelectMake extends PIDetailEvent {
  final String makeId; // unique ID of the selected make
  const SelectMake(this.makeId);
}

class FetchModelApi extends PIDetailEvent {
  final String? partyId;
  final String? productCode;
  final String? makeCode;
  const FetchModelApi(
      {required this.partyId,
      required this.productCode,
      required this.makeCode});
}

class ShowEndorsementType extends PIDetailEvent {
  final String piPurpose;

  const ShowEndorsementType({required this.piPurpose});
}

class IdvSelect extends PIDetailEvent {}

class PrefixSelect extends PIDetailEvent {}

class ProposalTypeSelect extends PIDetailEvent {}

class PreInspectionSelect extends PIDetailEvent {}

class NCBSelect extends PIDetailEvent {}

class PaymentSelect extends PIDetailEvent {}
