import '../../data/models/market_index.dart';
import '../../data/models/watchlist.dart';

abstract class WatchlistRepository {
  Future<List<Watchlist>> fetchWatchlists();
  Future<List<MarketIndex>> fetchIndices();
  Future<void> saveWatchlist(Watchlist watchlist);
  void dispose();
}
