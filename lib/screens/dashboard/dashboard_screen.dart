import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_state.dart';
import '../../utils/widgets/speed_dail_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardBloc(),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {},
          builder: (context, state) {
            return OverlayLoaderWithAppIcon(
              appIconSize: 60,
              circularProgressColor: Colors.transparent,
              overlayBackgroundColor: Colors.black87,
              isLoading: state is LoadingState,
              appIcon: Image.asset(
                'assest/loadgif.gif',
              ),
              child: Scaffold(
                appBar: AppBar(title: const Text('Dashboard')),
                body: const Center(
                  child: Text('Press the Speed Dial Button'),
                ),
                floatingActionButton: const SpeedDailFabWidget(),
              ),
            );
          },
        ));
  }
}
