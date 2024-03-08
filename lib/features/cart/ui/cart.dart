import 'package:bloc_shop_app/features/cart/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_tile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              //to use the cart list passed from our CartSuccessState

              final successState = state as CartSuccessState;
              return ListView.builder(
                itemCount: successState.cartProductList.length,
                itemBuilder: (context, index) {
                  //access the list of products in the HomeLoadedState
                  return CartTileWidget(
                    productDataModel: successState.cartProductList[index],
                    cartBloc: cartBloc,
                  );
                },
              );

            default:
              return Scaffold(
                body: Center(
                  child: Text('unknown error'),
                ),
              );
          }
        },
      ),
    );
  }
}
