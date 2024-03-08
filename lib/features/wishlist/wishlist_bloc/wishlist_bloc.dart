import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_shop_app/data/wishlist_items.dart';
import 'package:bloc_shop_app/features/home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistRemoveProduct>(wishlistRemoveProduct);
    on<WishlistInitialEvent>(wishlistInitialEvent);
  }

  FutureOr<void> wishlistRemoveProduct(
      WishlistRemoveProduct event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.clickedProduct);
    emit(
      WishlistSuccessState(wishListProductList: wishlistItems),
    );
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(
      WishlistSuccessState(wishListProductList: wishlistItems),
    );
  }
}
