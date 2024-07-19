import 'package:flutter/material.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class ListItemWidget extends StatelessWidget {
  final ItemDataModel? item;
  void Function()? onTap;
  ListItemWidget({super.key, this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(12), bottom: Radius.circular(12)),
        ),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                "${item?.name}",
                style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Rp. ${item?.price.toString()}",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Description : ${item?.description}",
                      style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 13),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
