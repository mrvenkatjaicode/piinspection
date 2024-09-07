import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class LoadingState extends DashboardState {}

class LocationFetchedAndNavigateState extends DashboardState {
  final Position position;
  final Placemark place;
  final bool isOwnFlow;
  final bool isOtherFlow;
  final bool isHitApi;

  const LocationFetchedAndNavigateState({
    required this.position,
    required this.place,
    required this.isOwnFlow,
    required this.isOtherFlow,
    required this.isHitApi,
  });

  @override
  List<Object?> get props => [position, place, isOwnFlow, isOtherFlow, isHitApi];
}

class LocationPermissionDeniedState extends DashboardState {
  final String error;

  const LocationPermissionDeniedState(this.error);

  @override
  List<Object?> get props => [error];
}
