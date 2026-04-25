import '../models/market_index.dart';
import '../models/stock.dart';
import '../models/watchlist.dart';

/// Hardcoded sample data — matches the instruments visible in the demo
/// video so reviewers can map 1:1 between the recording and this app.
class MockWatchlistDataSource {
  List<Watchlist> seedWatchlists() {
    return [
      Watchlist(
        id: 'wl_1',
        name: 'Watchlist 1',
        stocks: [
          const Stock(
            id: 'reliance_nse_eq',
            symbol: 'RELIANCE',
            exchange: Exchange.nse,
            segment: Segment.eq,
            lastPrice: 1374.10,
            previousClose: 1378.50,
          ),
          const Stock(
            id: 'hdfcbank_nse_eq',
            symbol: 'HDFCBANK',
            exchange: Exchange.nse,
            segment: Segment.eq,
            lastPrice: 966.85,
            previousClose: 966.00,
          ),
          const Stock(
            id: 'asianpaint_nse_eq',
            symbol: 'ASIANPAINT',
            exchange: Exchange.nse,
            segment: Segment.eq,
            lastPrice: 2537.40,
            previousClose: 2530.80,
          ),
          const Stock(
            id: 'nifty_it_idx',
            symbol: 'NIFTY IT',
            exchange: Exchange.idx,
            segment: Segment.idx,
            lastPrice: 35187.30,
            previousClose: 34310.44,
          ),
          const Stock(
            id: 'reliance_sep_1880_ce',
            symbol: 'RELIANCE SEP 1880 CE',
            exchange: Exchange.nse,
            segment: Segment.monthly,
            lastPrice: 0.00,
            previousClose: 0.00,
          ),
          const Stock(
            id: 'reliance_sep_1370_pe',
            symbol: 'RELIANCE SEP 1370 PE',
            exchange: Exchange.nse,
            segment: Segment.monthly,
            lastPrice: 19.20,
            previousClose: 18.20,
          ),
          const Stock(
            id: 'mrf_nse_eq',
            symbol: 'MRF',
            exchange: Exchange.nse,
            segment: Segment.eq,
            lastPrice: 147625.00,
            previousClose: 147075.00,
          ),
          const Stock(
            id: 'mrf_bse_eq',
            symbol: 'MRF',
            exchange: Exchange.bse,
            segment: Segment.eq,
            lastPrice: 147439.45,
            previousClose: 146975.65,
          ),
        ],
      ),
      Watchlist(
        id: 'wl_5',
        name: 'Watchlist 5',
        stocks: [
         
        ],
      ),
      Watchlist(
        id: 'wl_6',
        name: 'Watchlist 6',
        stocks: [
         
        ],
      ),
    ];
  }

  List<MarketIndex> seedIndices() {
    return const [
      MarketIndex(
        id: 'sensex',
        name: 'SENSEX 18TH SEP 8...',
        exchangeLabel: 'BSE',
        value: 81225.55,
        change: 144.50,
        percentChange: 13.30,
      ),
      MarketIndex(
        id: 'nifty_bank',
        name: 'NIFTY BANK',
        exchangeLabel: '',
        value: 54170.15,
        change: -16.75,
        percentChange: -0.03,
      ),
    ];
  }
}
