part of 'watchlist_bloc.dart';

enum WatchlistStatus { initial, loading, ready, error }

class WatchlistState extends Equatable {
  const WatchlistState({
    this.status = WatchlistStatus.initial,
    this.watchlists = const [],
    this.indices = const [],
    this.activeWatchlistId,
    this.draft,
    this.errorMessage,
  });

  final WatchlistStatus status;
  final List<Watchlist> watchlists;
  final List<MarketIndex> indices;

  // Currently selected tab.
  final String? activeWatchlistId;

  // Working copy used while the Edit screen is open. Null when not editing.
  final Watchlist? draft;

  final String? errorMessage;

  bool get isDirty {
    if (draft == null) return false;
    final saved = watchlists.firstWhere(
      (w) => w.id == draft!.id,
      orElse: () => draft!,
    );
    if (saved.name != draft!.name) return true;
    if (saved.stocks.length != draft!.stocks.length) return true;
    for (var i = 0; i < saved.stocks.length; i++) {
      if (saved.stocks[i].id != draft!.stocks[i].id) return true;
    }
    return false;
  }
  Watchlist? get activeWatchlist {
    if (activeWatchlistId == null) return null;
    for (final w in watchlists) {
      if (w.id == activeWatchlistId) return w;
    }
    return null;
  }

  WatchlistState copyWith({
    WatchlistStatus? status,
    List<Watchlist>? watchlists,
    List<MarketIndex>? indices,
    String? activeWatchlistId,
    Watchlist? draft,
    bool clearDraft = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      watchlists: watchlists ?? this.watchlists,
      indices: indices ?? this.indices,
      activeWatchlistId: activeWatchlistId ?? this.activeWatchlistId,
      draft: clearDraft ? null : (draft ?? this.draft),
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        watchlists,
        indices,
        activeWatchlistId,
        draft,
        errorMessage,
      ];
}
