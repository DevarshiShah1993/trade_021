import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/market_index_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/sort_by_chip.dart';
import '../widgets/stock_tile.dart';
import '../widgets/watchlist_tabs.dart';
import 'edit_watchlist_page.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  void _openEdit(BuildContext context) {
    final bloc = context.read<WatchlistBloc>();
    if (bloc.state.activeWatchlist == null) return;
    bloc.add(const WatchlistEditStarted());
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const EditWatchlistPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          buildWhen: (p, n) =>
              p.status != n.status ||
              p.watchlists != n.watchlists ||
              p.indices != n.indices ||
              p.activeWatchlistId != n.activeWatchlistId,
          builder: (context, state) {
            if (state.status == WatchlistStatus.initial ||
                state.status == WatchlistStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == WatchlistStatus.error) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    state.errorMessage ?? 'Something went wrong',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final active = state.activeWatchlist;

            return Column(
              children: [
                _IndexHeader(state: state),
                const Divider(height: 1, color: AppColors.divider),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: WatchlistSearchBar(),
                ),
                WatchlistTabs(
                  watchlists: state.watchlists,
                  activeId: state.activeWatchlistId,
                  onTap: (id) {},
                  onEditPressed: () => _openEdit(context),
                ),
                const Divider(height: 1, color: AppColors.divider),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SortByChip(),
                  ),
                ),
                Expanded(
                  child: active == null || active.stocks.isEmpty
                      ? const _EmptyState()
                      : ListView.separated(
                          itemCount: active.stocks.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            color: AppColors.divider,
                          ),
                          itemBuilder: (context, i) {
                            final stock = active.stocks[i];
                            return StockTile(
                              stock: stock,
                              onLongPress: () => _openEdit(context),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class _IndexHeader extends StatelessWidget {
  const _IndexHeader({required this.state});
  final WatchlistState state;

  @override
  Widget build(BuildContext context) {
    if (state.indices.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 360;
        if (!isWide) {
          return SizedBox(
            height: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.indices.length,
              separatorBuilder: (_, __) => const VerticalDivider(
                width: 1,
                color: AppColors.divider,
              ),
              itemBuilder: (_, i) => SizedBox(
                width: 220,
                child: MarketIndexCard(index: state.indices[i]),
              ),
            ),
          );
        }
        return IntrinsicHeight(
          child: Row(
            children: [
              for (var i = 0; i < state.indices.length; i++) ...[
                Expanded(
                  child: MarketIndexCard(
                    index: state.indices[i],
                    showChevron: i == state.indices.length - 1,
                  ),
                ),
                if (i != state.indices.length - 1)
                  const VerticalDivider(
                    width: 1,
                    color: AppColors.divider,
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No stocks in this watchlist yet.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
