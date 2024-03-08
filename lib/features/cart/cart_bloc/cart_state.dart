part of 'cart_bloc.dart';

sealed class CartState {
  const CartState();
}

sealed class CartActionState extends Equatable {
  const CartActionState();
}

//build state
final class CartInitial extends CartState {}

final class CartSuccessState extends CartState {
  final List<ProductDataModel> cartProductList;

  CartSuccessState({required this.cartProductList});
}
