import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/bloc/item/item_bloc.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class EditItemView extends StatefulWidget {
  static const routeName = '/edit-item';
  final int? id;
  final String? name;
  final int? price;
  final String? description;
  const EditItemView(
      {super.key, this.id, this.name, this.price, this.description});

  @override
  State<EditItemView> createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {
  final _keyState = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');

  final ItemBloc itemBloc = ItemBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name ?? "Nama Produk";
    priceController.text = widget.price.toString();
    descriptionController.text = widget.description ?? "Description";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: const Text('Edit Item'),
        ),
        body: BlocProvider(
          create: (context) => itemBloc,
          child: BlocConsumer<ItemBloc, ItemState>(
            listener: (context, state) {
              // TODO: implement listener

              if (state is ItemFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.message,
                  style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: whiteColor),
                )));
              }

              if (state is ItemUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Item Updated",
                  style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: whiteColor),
                )));
                Navigator.pop(context);
               
              }
            },
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  Container(
                    child: Form(
                        key: _keyState,
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                controller: nameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.description),
                                    label: Text(
                                      "Nama",
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade500),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              child: TextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.money),
                                  label: Text("Price",
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade500)),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.description),
                                  label: Text("Description",
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade500)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Color(0XFF2D31FA)),
                                    onPressed: (() async {
                                      if (nameController.text.isEmpty ||
                                          priceController.text.isEmpty ||
                                          descriptionController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          "Please fill all the form",
                                          style: primaryTextStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: whiteColor),
                                        )));
                                        return;
                                      } else {
                                        context.read<ItemBloc>().add(
                                            ItemUpdateItem(
                                                widget.id,
                                                nameController.text,
                                                int.parse(priceController.text),
                                                descriptionController.text));
                                      }
                                    }),
                                    child: Text("Edit Item",
                                        style: primaryTextStyle.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: whiteColor,
                                            fontSize: 16)))),
                          ],
                        )),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
