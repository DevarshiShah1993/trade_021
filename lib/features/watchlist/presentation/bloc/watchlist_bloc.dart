import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/market_index.dart';
import '../../data/models/stock.dart';
import '../../data/models/watchlist.dart';
import '../../domain/repositories/watchlist_repository.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({required WatchlistRepository repository})
      : _repository = repository,
        super(const WatchlistState()) {
    on<WatchlistStarted>(_onStarted);
    on<WatchlistEditStarted>(_onEditStarted);
    on<WatchlistReorderRequested>(_onReorderRequested);
    on<WatchlistSaved>(_onSaved);
    on<WatchlistEditCancelled>(_onEditCancelled);
  }

  final WatchlistRepository _repository;

  Future<void> _onStarted(
    WatchlistStarted event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistStatus.loading, clearError: true));
    try {
      final watchlists = await _repository.fetchWatchlists();
      final indices = await _repository.fetchIndices();
      emit(
        state.copyWith(
          status: WatchlistStatus.ready,
          watchlists: watchlists,
          indices: indices,
          activeWatchlistId:
              watchlists.isNotEmpty ? watchlists.first.id : null,
        ),
      );

     
    } catch (e) {
      emit(
        state.copyWith(
          status: WatchlistStatus.error,
          errorMessage: 'Failed to load watchlists: $e',
        ),
      );
    }
  }


  void _onEditStarted(
    WatchlistEditStarted event,
    Emitter<WatchlistState> emit,
  ) {
    final active = state.activeWatchlist;
    if (active == null) return;
    emit(
      state.copyWith(
        draft: active.copyWith(stocks: List<Stock>.of(active.stocks)),
      ),
    );
  }

  void _onReorderRequested(
    WatchlistReorderRequested event,
    Emitter<WatchlistState> emit,
  ) {
    final draft = state.draft;
    if (draft == null) return;

    var newIndex = event.newIndex;
    if (event.newIndex > event.oldIndex) {
      newIndex = event.newIndex - 1;
    }
    if (event.oldIndex < 0 ||
        event.oldIndex >= draft.stocks.length ||
        newIndex < 0 ||
        newIndex >= draft.stocks.length ||
        newIndex == event.oldIndex) {
      return;
    }

    final updated = List<Stock>.of(draft.stocks);
    final moved = updated.removeAt(event.oldIndex);
    updated.insert(newIndex, moved);
    emit(state.copyWith(draft: draft.copyWith(stocks: updated)));
  }


  Future<void> _onSaved(
    WatchlistSaved event,
    Emitter<WatchlistState> emit,
  ) async {
    final draft = state.draft;
    if (draft == null) return;

    final savedIndex = state.watchlists.indexWhere((w) => w.id == draft.id);
    final Watchlist reconciled;
    if (savedIndex == -1) {
      reconciled = draft;
    } else {
      final freshById = {
        for (final s in state.watchlists[savedIndex].stocks) s.id: s,
      };
      reconciled = draft.copyWith(
        stocks: draft.stocks.map((s) {
          final fresh = freshById[s.id];
          return fresh == null
              ? s
              : s.copyWith(
                  lastPrice: fresh.lastPrice,
                  previousClose: fresh.previousClose,
                );
        }).toList(growable: false),
      );
    }

    await _repository.saveWatchlist(reconciled);
    final updated = state.watchlists
        .map((w) => w.id == reconciled.id ? reconciled : w)
        .toList(growable: false);
    emit(
      state.copyWith(
        watchlists: updated,
        clearDraft: true,
      ),
    );
  }

  void _onEditCancelled(
    WatchlistEditCancelled event,
    Emitter<WatchlistState> emit,
  ) {
    emit(state.copyWith(clearDraft: true));
  }


}
