part of 'wishlist_bloc.dart';

sealed class WishlistEvent {
  const WishlistEvent();
}

final class WishlistRemoveProduct extends WishlistEvent {
  final ProductDataModel clickedProduct;

  WishlistRemoveProduct({required this.clickedProduct});
}

final class WishlistInitialEvent extends WishlistEvent {}
