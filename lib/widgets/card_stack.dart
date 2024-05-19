import 'package:flutter/material.dart';
import 'package:bodega/models/product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

//import 'package:get/get.dart';
//import 'package:jnee/screens/detail/detail_screen.dart';

class CardStack extends StatelessWidget {
  final Product product;
  const CardStack(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(product.id),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Borrar',
          ),
          // SlidableAction(
          //   onPressed: doNothing,
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.share,
          //   label: 'Share',
          // ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            //flex: 2,
            onPressed: editProduct,
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
          // SlidableAction(
          //   onPressed: doNothing,
          //   backgroundColor: Color(0xFF0392CF),
          //   foregroundColor: Colors.white,
          //   icon: Icons.save,
          //   label: 'Save',
          // ),
        ],
      ),
      child: ListTile(
        title: Text(
          product.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        trailing: Text(
          product.price.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17.0,
          ),
        ),
        onTap: () {
          // print(product.name);
        },
      ),
    );
  }

  void doNothing(BuildContext c) {}

  void editProduct(BuildContext c) {
    Get.toNamed(
      "/new-product",
      arguments: product,
    );
  }
}
