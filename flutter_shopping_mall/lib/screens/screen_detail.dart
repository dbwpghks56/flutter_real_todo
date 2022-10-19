import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:flutter_shopping_mall/models/model_cart.dart';
import 'package:provider/provider.dart';
import '../models/model_item.dart';

class ScreenDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;
    final cart = Provider.of<CartProvider>(context);
    final authClient = Provider.of<FirebaseAuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
        child: ListView(
          children: [
            Image.network(item.imageUrl,
              // fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.all(3)),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                item.title,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.price.toString()} 원',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      Text(
                        '브랜드 : ${item.brand}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '등록일자 : ${item.registerDate}',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  cart.isItemInCart(item) ? const Icon(Icons.check, color: Colors.blue,) :
                  InkWell(
                    onTap: () {
                      cart.addItemToCart(authClient.user, item);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.add, color: Colors.blue,),
                        Text('담기', style: TextStyle(color: Colors.blue),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:const EdgeInsets.all(15),
              child: Text(item.description, style:const TextStyle(fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }
}
