part of 'home_bloc.dart';

@immutable
//build states : simple states that will build my UI
sealed class HomeState {}

//actionable states : if UI got actionable states, UI want to do some action
sealed class HomeActionState extends HomeState {}

//Build states
final class HomeInitial extends HomeState {}

//while the app hast fully loaded. example: still fetching data from the server. Show circular indicator
final class HomeLoadingState extends HomeState {}

//passing data via state
//while the app fully loaded, no circular progress indicator will be shown
final class HomeLoadedState extends HomeState {
  //When the home is loaded, want to get a list of Products
  //requires the products input, which forces the app logic to pass in the product data to display whenever it transitions to this state. This encapsulates the data needed to show content and keeps it separate from other states.
  final List<ProductDataModel> products;
  HomeLoadedState({
    required this.products,
  });
}

//while there is error while fetching data
final class HomeErrorState extends HomeState {}

//Action states
final class HomeNavigateToWishlistPageActionState extends HomeActionState {}

final class HomeNavigateToCartPageActionState extends HomeActionState {}

//to show scaffold message(also action state)
final class HomeProductWishlistedActionState extends HomeActionState {}

//to show scaffold message(also action state)
final class HomeProductCartAddedActionState extends HomeActionState {}
