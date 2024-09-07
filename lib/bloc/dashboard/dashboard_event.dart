import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class OwnFlowNavigateEvent extends DashboardEvent {
  const OwnFlowNavigateEvent();
}

class OtherFlowNavigateEvent extends DashboardEvent {
  const OtherFlowNavigateEvent();
}

class HitApiFlowNavigateEvent extends DashboardEvent {
  const HitApiFlowNavigateEvent();
}