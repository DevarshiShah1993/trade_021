import 'dart:async';

import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/mock_watchlist_data_source.dart';
import '../models/market_index.dart';
import '../models/watchlist.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  WatchlistRepositoryImpl({MockWatchlistDataSource? dataSource})
      : _dataSource = dataSource ?? MockWatchlistDataSource() {
    _watchlists = _dataSource.seedWatchlists();
    _indices = _dataSource.seedIndices();
  }

  final MockWatchlistDataSource _dataSource;
  late List<Watchlist> _watchlists;
  late List<MarketIndex> _indices;

  final _watchlistController =
      StreamController<List<Watchlist>>.broadcast();
  final _indexController = StreamController<List<MarketIndex>>.broadcast();


  @override
  Future<List<Watchlist>> fetchWatchlists() async => _watchlists;

  @override
  Future<List<MarketIndex>> fetchIndices() async => _indices;

  @override
  Future<void> saveWatchlist(Watchlist watchlist) async {
    final idx = _watchlists.indexWhere((w) => w.id == watchlist.id);
    if (idx == -1) return;
    _watchlists = [..._watchlists]..[idx] = watchlist;
    _watchlistController.add(_watchlists);
  }

  @override
  void dispose() {
    _watchlistController.close();
    _indexController.close();
  }
}
