//import 'package:jnee/controllers/auth_controller.dart';
import 'package:bodega/controllers/product_controller.dart';
import 'package:bodega/generated/l10n.dart';
import 'package:bodega/widgets/dialogs.dart';
import 'package:bodega/widgets/global_widgets/input_text.dart';
import 'package:bodega/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NewProductForm extends GetView<ProductController> {
  NewProductForm({super.key});

  var barcodeController = TextEditingController();
  var barcodeNewController = TextEditingController();

  void _submit(BuildContext context) async {
    ProgressDialog.show(context);
    final int submitOk = await controller.submit(controller.isNewProduct);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (submitOk < 1) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("ERROR"),
          content: const Text("No se pudo guardar el registro"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(S.current.txtOk),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      // go to home
      controller.navigateToHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final descriptionController = TextEditingController();
    final emptyStringPriceController = TextEditingController();
    final emptyStringQuantityController = TextEditingController();

    nameController.text = controller.name;
    priceController.text = controller.price.toString();
    emptyStringPriceController.text = controller.emptyString;
    quantityController.text = controller.quantity.toString();
    emptyStringQuantityController.text = controller.emptyString;
    descriptionController.text = controller.description;

    barcodeController.text = controller.barcode;
    barcodeNewController.text = controller.emptyString;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
                  //key: UniqueKey(),

                  // initialValue:
                  //     controller.isNewProduct ? "" : controller.barcode,
                  controller: controller.isNewProduct
                      ? barcodeNewController
                      : barcodeController, // <-- SEE HERE
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.qr_code_scanner),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: controller.onBarcodeChanged,
                ),
                // Obx(() => TextFormField(
                //       key: UniqueKey(),

                //       initialValue: controller.isNewProduct
                //           ? "${controller.ini}"
                //           : controller.barcode, // <-- SEE HERE
                //       decoration: const InputDecoration(
                //         prefixIcon: Icon(Icons.qr_code_scanner),
                //       ),
                //       textInputAction: TextInputAction.next,
                //       onChanged: controller.onBarcodeChanged,
                //     )),
                // child: InputText(
                //   prefixIcon: const Icon(Icons.production_quantity_limits),
                //   labelText: "Código de barras",
                //   textInputAction: TextInputAction.next,
                //   onChanged: controller.onBarcodeChanged,
                //   validator: (text) {
                //     if (text.isNotEmpty) return null;
                //     return "Codigo de barras invalido";
                //   },
                // ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: _scanBarcodeNormal,
                  child: const Icon(Icons.search),
                ),
              )
            ],
          ),
          //Obx(() => Text("${controller.ini}")),

          InputText(
            prefixIcon: const Icon(Icons.production_quantity_limits),
            labelText: "Nombre",
            textInputAction: TextInputAction.next,
            controller: nameController,
            onChanged: (value) {
              controller.onNameChanged(value);
            },
            validator: (text) {
              if (text.isNotEmpty) return null;
              return "Nombre inválido";
            },
          ),
          InputText(
            prefixIcon: const Icon(Icons.price_check),
            labelText: "Precio",
            textInputAction: TextInputAction.next,
            controller: controller.isNewProduct
                ? emptyStringPriceController
                : priceController,
            onChanged: controller.onPriceChanged,
            keyboardType: TextInputType.number,
            validator: (text) {
              if (text.isNotEmpty) return null;
              return "Precio invalido";
            },
          ),
          InputText(
            prefixIcon: const Icon(Icons.pin),
            labelText: "Cantidad",
            textInputAction: TextInputAction.next,
            controller: controller.isNewProduct
                ? emptyStringQuantityController
                : quantityController,
            onChanged: controller.onQuantityChanged,
            keyboardType: TextInputType.number,
            validator: (text) {
              if (text.isNotEmpty) return null;
              return "Cantidad invalida";
            },
          ),
          InputText(
            prefixIcon: const Icon(Icons.view_list),
            labelText: "Descripción",
            textInputAction: TextInputAction.next,
            controller: descriptionController,
            onChanged: controller.onDescriptionChanged,
            validator: (text) {
              if (text.isNotEmpty) return null;
              return "Descripcion invalido";
            },
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          RoundedButton(
            label: S.current.txtSave,
            onPressed: () => _submit(context),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 40),
          )
        ],
      ),
    );
  }

  Future<void> _scanBarcodeNormal() async {
    String res;

    try {
      res = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', S.current.txtCancel, true, ScanMode.BARCODE);
      // controller.ini.value = res;
      // controller.barcode = res;
      if (controller.isNewProduct) {
        barcodeNewController.text = res;
        controller.barcode = res;
      } else {
        barcodeController.text = res;
        controller.barcode = res;
      }
    } on PlatformException {
      res = 'Fallo al obtener version de plataforma';
    }
  }
}
