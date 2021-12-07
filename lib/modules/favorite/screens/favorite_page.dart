import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorit'),
        ),
        body: Container(),
      ),
    );
  }
}
