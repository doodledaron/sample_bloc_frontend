part of 'wishlist_bloc.dart';

sealed class WishlistState {
  const WishlistState();
}

final class WishlistActionState extends WishlistState {}

//build state
final class WishlistInitial extends WishlistState {}

//build state
final class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishListProductList;

  WishlistSuccessState({required this.wishListProductList});
}
