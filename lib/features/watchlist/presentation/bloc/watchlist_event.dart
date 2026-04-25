part of 'watchlist_bloc.dart';


sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class WatchlistStarted extends WatchlistEvent {
  const WatchlistStarted();
}

class WatchlistEditStarted extends WatchlistEvent {
  const WatchlistEditStarted();
}

class WatchlistReorderRequested extends WatchlistEvent {
  const WatchlistReorderRequested({
    required this.oldIndex,
    required this.newIndex,
  });
  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class WatchlistSaved extends WatchlistEvent {
  const WatchlistSaved();
}

class WatchlistEditCancelled extends WatchlistEvent {
  const WatchlistEditCancelled();
}


