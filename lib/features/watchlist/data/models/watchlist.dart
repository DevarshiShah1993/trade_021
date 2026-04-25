import 'package:equatable/equatable.dart';

import 'stock.dart';

/// A named, ordered collection of [Stock]s.
///
/// The order of [stocks] *is* the user-visible order — reordering at the
/// UI/Bloc layer mutates this list (immutably via copyWith).
class Watchlist extends Equatable {
  const Watchlist({
    required this.id,
    required this.name,
    required this.stocks,
  });

  final String id;
  final String name;
  final List<Stock> stocks;

  Watchlist copyWith({
    String? id,
    String? name,
    List<Stock>? stocks,
  }) {
    return Watchlist(
      id: id ?? this.id,
      name: name ?? this.name,
      stocks: stocks ?? this.stocks,
    );
  }

  @override
  List<Object?> get props => [id, name, stocks];
}
