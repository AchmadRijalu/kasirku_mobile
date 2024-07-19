import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/views/edit_item_view.dart';
import 'package:kasirku_mobile/bloc/item/item_bloc.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class DetailItemView extends StatefulWidget {
  final int? id;
  static const routeName = "/detail-item-view";
  const DetailItemView({super.key, this.id});

  @override
  State<DetailItemView> createState() => _DetailItemViewState();
}

class _DetailItemViewState extends State<DetailItemView> {
  final ItemBloc itemBloc = ItemBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ID ITEM : ${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Item"),
      ),
      body: BlocProvider(
        create: (context) => itemBloc..add(ItemGetItemDetail(widget.id!)),
        child: BlocConsumer<ItemBloc, ItemState>(
          listener: (context, state) {
            if (state is ItemDeleteSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ItemFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ItemDetailSuccess)
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ${state.item.data!.name}",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Price: ${state.item.data!.price.toString()}",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                    Text(
                      "Description : ${state.item.data!.description}",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Color(0XFF2D31FA)),
                          onPressed: (() async {
                            await Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return EditItemView(
                                  id: widget.id,
                                  name: state.item.data!.name,
                                  price: state.item.data!.price,
                                  description: state.item.data!.description,
                                );
                              },
                            ));
                            itemBloc.add(ItemGetItemDetail(widget.id!));
                          }),
                          child: Text("Edit",
                              style: primaryTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: whiteColor,
                                  fontSize: 16))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.red),
                          onPressed: (() async {
                            context
                                .read<ItemBloc>()
                                .add(ItemDeleteItem(widget.id!));
                          }),
                          child: Text("Delete",
                              style: primaryTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: whiteColor,
                                  fontSize: 16))),
                    )
                  ],
                ),
              );
            return Container();
          },
        ),
      ),
    );
  }
}
