import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoe_store/config/constants/api_endpoint.dart';
import 'package:shoe_store/features/product/domain/entity/product_entity.dart';
import 'package:shoe_store/features/product/presentation/viewmodel/product_view_model.dart';

class EditProductView extends ConsumerStatefulWidget {
  final ProductEntity product;
  const EditProductView({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProductViewState();
}

class _EditProductViewState extends ConsumerState<EditProductView> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(productViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _gap = const SizedBox(height: 10);
  List<String> batches = ["Men", "Women", "Children"];
  String? _dropDownValue;

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.productName);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    descController = TextEditingController(text: widget.product.desc);
    _dropDownValue = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    // final productState = ref.watch(productViewModelProvider);
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height * 0.90,
          alignment: Alignment.center,
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.grey[300],
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ref, ImageSource.camera);
                                Navigator.pop(context);
                                // Upload image it is not null
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ref, ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  // child: SizedBox(
                  //   height: 200,
                  //   width: 200,
                  //   child: CircleAvatar(
                  //     radius: 50,
                  //     backgroundImage: _img != null
                  //         ? FileImage(_img!)
                  //         // : const AssetImage('assets/images/add_icon.jpg')
                  //         //     as ImageProvider,
                  //         : NetworkImage(ApiEndpoints.imageUrl +
                  //             widget.product.productImage!) as ImageProvider,
                  //   ),
                  // ),
                  child: Container(
                    // color: Colors.grey,
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: widget.product.productImage != null
                              ? NetworkImage(ApiEndpoints.imageUrl +
                                  widget.product.productImage!)
                              : const NetworkImage(
                                  'https://rukminim1.flixcart.com/image/450/500/xif0q/shoe/j/q/n/8-mrj2100-8-aadi-white-black-grey-original-imagn8yk5hfq7vnh.jpeg?q=90&crop=false'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                _gap,
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber, width: 2.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter ProductName';
                    }
                    return null;
                  },
                ),
                _gap,
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber, width: 2.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter ProductPrice';
                    }
                    return null;
                  },
                ),
                _gap,
                DropdownButtonFormField(
                  items: batches
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _dropDownValue = value;
                  },
                  value: _dropDownValue,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                  ),
                  validator: ((value) {
                    if (value == null) {
                      return 'Please select Category';
                    }
                    return null;
                  }),
                ),
                _gap,
                TextFormField(
                  controller: descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                  ),
                ),
                _gap,
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      var product = ProductEntity(
                        productImage: widget.product.productImage,
                        productName: nameController.text,
                        price: int.parse(priceController.text),
                        category: _dropDownValue!,
                        desc: descController.text,
                      );

                      ref.read(productViewModelProvider.notifier).editProduct(
                          context, widget.product.productId!, product);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
