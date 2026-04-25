import 'package:equatable/equatable.dart';

/// Exchange where an instrument is listed/traded.
enum Exchange {
  nse('NSE'),
  bse('BSE'),
  idx('IDX'); // synthetic — used for indices like NIFTY IT

  const Exchange(this.label);
  final String label;
}

/// Instrument segment / product type.
enum Segment {
  eq('EQ'),
  monthly('Monthly'),
  idx('IDX');

  const Segment(this.label);
  final String label;
}
enum PriceDirection { up, down, neutral }

class Stock extends Equatable {
  const Stock({
    required this.id,
    required this.symbol,
    required this.exchange,
    required this.segment,
    required this.lastPrice,
    required this.previousClose,
  });

  final String id;
  final String symbol;
  final Exchange exchange;
  final Segment segment;
  final double lastPrice;
  final double previousClose;

  double get absoluteChange => lastPrice - previousClose;

  double get percentChange {
    if (previousClose == 0) return 0;
    return (absoluteChange / previousClose) * 100;
  }

  PriceDirection get direction {
    if (absoluteChange > 0) return PriceDirection.up;
    if (absoluteChange < 0) return PriceDirection.down;
    return PriceDirection.neutral;
  }

  Stock copyWith({
    String? id,
    String? symbol,
    Exchange? exchange,
    Segment? segment,
    double? lastPrice,
    double? previousClose,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      exchange: exchange ?? this.exchange,
      segment: segment ?? this.segment,
      lastPrice: lastPrice ?? this.lastPrice,
      previousClose: previousClose ?? this.previousClose,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        exchange,
        segment,
        lastPrice,
        previousClose,
      ];
}
