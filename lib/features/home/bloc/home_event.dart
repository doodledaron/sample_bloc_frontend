part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable{
    @override
  List<Object> get props => [];
}

//pass data via event
class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductWishlistButtonClickedEvent({
    required this.clickedProduct,
  });
}

//pass data via event
class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {
  
}

//initial event that trigger the HomeLoadedState
class HomeInitialEvent extends HomeEvent {}
