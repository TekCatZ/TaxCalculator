import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tax_calculator/theme/theme.dart';

import '../../bloc/routes_page/routes_bloc.dart';
import 'routes/routes.dart';

// Route画面
// ThangNP3
class RoutesPage extends StatelessWidget {
  const RoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<RoutesBloc>(),
      child: const _RouteView(),
    );
  }
}

class _RouteView extends StatelessWidget {
  const _RouteView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: FlowBuilder<RoutesState>(
        state: context.select((RoutesBloc bloc) => bloc.state),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
