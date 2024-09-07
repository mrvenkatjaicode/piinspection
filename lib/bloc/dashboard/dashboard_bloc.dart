import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<OwnFlowNavigateEvent>(_onOwnFlowNavigate);
    on<OtherFlowNavigateEvent>(_onOtherFlowNavigate);
    on<HitApiFlowNavigateEvent>(_onHitApiFlowNavigate);
  }

  Future<void> _onOwnFlowNavigate(
      OwnFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(true, false, false, emit);
  }

  Future<void> _onOtherFlowNavigate(
      OtherFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(false, true, false, emit);
  }

  Future<void> _onHitApiFlowNavigate(
      HitApiFlowNavigateEvent event, Emitter<DashboardState> emit) async {
    await _fetchLocation(false, false, true, emit);
  }

  Future<void> _fetchLocation(bool isOwnFlow, bool isOtherFlow, bool isHitApi,
      Emitter<DashboardState> emit) async {
    emit(LoadingState());

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        emit(const LocationPermissionDeniedState(
            'Location services are disabled.'));
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const LocationPermissionDeniedState(
              'Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const LocationPermissionDeniedState(
            'Location permissions are permanently denied, we cannot request permissions.'));
        return;
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      // Get placemark from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks.first;

      emit(LocationFetchedAndNavigateState(
          position: position,
          place: place,
          isOwnFlow: isOwnFlow,
          isOtherFlow: isOtherFlow,
          isHitApi: isHitApi));
    } catch (e) {
      emit(LocationPermissionDeniedState(e.toString()));
    }
  }
}
