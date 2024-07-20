import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:kasirku_mobile/models/transaction_model.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class ListTransactionWidget extends StatelessWidget {
  final int? id;
  final TransactionDataModel? transactionDataModel;
  void Function()? onTap;

  ListTransactionWidget(
      {Key? key, this.onTap, this.id, this.transactionDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = transactionDataModel?.createdAt != null
        ? DateFormat('yyyy-MM-dd').format(transactionDataModel!.createdAt!)
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: secondaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 9), // changes position of shadow
            ),
          ], color: whiteColor, borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nomor Invoice: ${transactionDataModel?.invoiceNumber}",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor,
                    ),
                    child: Text(
                      "Tanggal: $formattedDate",
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
