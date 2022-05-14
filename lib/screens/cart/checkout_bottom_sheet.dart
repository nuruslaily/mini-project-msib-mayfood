import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/cart/order_failed_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  // final Food item;

  const CheckoutBottomSheet({Key? key}) : super(key: key);
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: new Wrap(
        children: <Widget>[
          Row(
            children: [
              Text("Checkout", style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.w600,),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ))
            ],
          ),
          SizedBox(
            height: 45,
          ),
          getDivider(),
          checkoutRow("Delivery", trailingText: "Select Method"),
          getDivider(),
          checkoutRow("Payment", trailingWidget: Icon(Icons.payment)),
          getDivider(),
          checkoutRow("Promo Code", trailingText: "Pick Discount"),
          getDivider(),
          checkoutRow("Total Cost", trailingText: "Total Harga",),
          getDivider(),
          SizedBox(
            height: 30,
          ),
          termsAndConditionsAgreement(context),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: ElevatedButton(
              child: Text("Place Order", style: TextStyle(fontWeight: FontWeight.w600,),),
              onPressed: () {
                onPlaceOrderClicked();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            // fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terms",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(text: " And"),
            TextSpan(
                text: " Conditions",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,),
          ),
          Spacer(),
          trailingText == null
              ? trailingWidget!
              : Text(trailingText, style: TextStyle(fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,),
                ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderFailedDialogue();
        });
  }
  // double getPrice() {
  //   return widget.item.price * amount;
  // }
}
