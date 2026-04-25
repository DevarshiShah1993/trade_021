import 'package:equatable/equatable.dart';

import 'stock.dart' show PriceDirection;

class MarketIndex extends Equatable {
  const MarketIndex({
    required this.id,
    required this.name,
    required this.exchangeLabel,
    required this.value,
    required this.change,
    required this.percentChange,
  });

  final String id;
  final String name;
  final String exchangeLabel;
  final double value;
  final double change;
  final double percentChange;

  PriceDirection get direction {
    if (change > 0) return PriceDirection.up;
    if (change < 0) return PriceDirection.down;
    return PriceDirection.neutral;
  }

  MarketIndex copyWith({
    String? id,
    String? name,
    String? exchangeLabel,
    double? value,
    double? change,
    double? percentChange,
  }) {
    return MarketIndex(
      id: id ?? this.id,
      name: name ?? this.name,
      exchangeLabel: exchangeLabel ?? this.exchangeLabel,
      value: value ?? this.value,
      change: change ?? this.change,
      percentChange: percentChange ?? this.percentChange,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, exchangeLabel, value, change, percentChange];
}
