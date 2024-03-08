part of 'cart_bloc.dart';

sealed class CartEvent {
  const CartEvent();
}

final class CartInitialEvent extends CartEvent {}

final class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel clickedProduct;
//pass data from event (to delete product)
  CartRemoveFromCartEvent({required this.clickedProduct});
}
