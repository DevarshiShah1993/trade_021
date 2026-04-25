import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_colors.dart';
import '../features/watchlist/data/repositories/watchlist_repository_impl.dart';
import '../features/watchlist/domain/repositories/watchlist_repository.dart';
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart';
import '../features/watchlist/presentation/pages/watchlist_page.dart';

// Note: app_routes.dart defines named-route constants for future expansion
// (deep linking, multi-screen flows). Currently navigation is direct via
// MaterialPageRoute, so the constants live there ready to be wired in.

class TradeApp extends StatefulWidget {
  const TradeApp({super.key});

  @override
  State<TradeApp> createState() => _TradeAppState();
}

class _TradeAppState extends State<TradeApp> {
  late final WatchlistRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = WatchlistRepositoryImpl();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WatchlistRepository>.value(
      value: _repository,
      child: BlocProvider<WatchlistBloc>(
        create: (_) => WatchlistBloc(repository: _repository)
          ..add(const WatchlistStarted()),
        child: MaterialApp(
          title: '021 Trade',
          debugShowCheckedModeBanner: false,
          // Per project preference no centralized AppTheme/AppTextStyles —
          // widgets style themselves. We only set scaffold/font defaults here.
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryText,
              primary: AppColors.primaryText,
              surface: AppColors.background,
            ),
          ),
          home: const WatchlistPage(),
        ),
      ),
    );
  }
}
