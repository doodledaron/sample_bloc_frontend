import 'package:bloc_shop_app/features/wishlist/ui/wishlist_tile.dart';
import 'package:bloc_shop_app/features/wishlist/wishlist_bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  //initialize the bloc
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    super.initState();
    wishlistBloc.add(
      WishlistInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          buildWhen: (previous, current) => current is! WishlistActionState,
          listenWhen: (previous, current) => current is WishlistActionState,
          builder: (context, state) {
            //build states
            if (state is WishlistSuccessState) {
              //to access the wishlist
              // final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: state.wishListProductList.length,
                itemBuilder: (context, index) {
                  //access the list of products in the HomeLoadedState
                  return WishlistTileWidget(
                    productDataModel: state.wishListProductList[index],
                    wishlistBloc: wishlistBloc,
                  );
                },
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text('unknown error'),
                ),
              );
            }
          },
          listener: (context, state) {
            //listen to action state
          }),
    );
  }
}
