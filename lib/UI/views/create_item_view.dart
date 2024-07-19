import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/bloc/item/item_bloc.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class CreateItemView extends StatefulWidget {
  static const routeName = '/create-item';
  const CreateItemView({super.key});

  @override
  State<CreateItemView> createState() => _CreateItemViewState();
}

class _CreateItemViewState extends State<CreateItemView> {
  final _keyState = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');

  final ItemBloc itemBloc = ItemBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          title: const Text('Create Item'),
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

              if (state is ItemCreateSuccess) {
                Navigator.pop(context);
                itemBloc.add(ItemGetItems());
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: priceController,
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
                                      context.read<ItemBloc>().add(
                                          ItemCreateItem(
                                              nameController.text,
                                              priceController.text,
                                              descriptionController.text));
                                    }),
                                    child: Text("Buat Item",
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
