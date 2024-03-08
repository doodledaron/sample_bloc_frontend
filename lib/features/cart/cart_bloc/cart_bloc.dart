import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_shop_app/data/cart_items.dart';
import 'package:bloc_shop_app/features/home/models/home_product_data_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    //cart items from data
    //to be emitted and used in Cart UI
    emit(
      CartSuccessState(cartProductList: cartItems),
    );
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.clickedProduct);
    emit(
      //just emit the cart success state again to rebuild the ui
      CartSuccessState(cartProductList: cartItems),
    );
  }
}
