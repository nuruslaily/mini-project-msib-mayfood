import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:foods/screens/food/food_screen.dart';

class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String path ='https://wa.me/+6285646709405';
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 10,
            ),
            const Icon(Icons.check_circle, size: 20, color: Colors.green),
            // SvgPicture.asset("assets/icons/order_accepted_icon.svg"),
            const Spacer(
              flex: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "You Order Has Been Accepted",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your item has been placed and is on it's way to being processed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600),
              ),
            ),
            
            const Spacer(
              flex: 8,
            ),
            Center(
                child: BarcodeWidget(
              barcode: Barcode.aztec(), // Barcode type and settings
              data: 'https://wa.me/+6285646709405', // Content
              width: 200,
              height: 200,
            )),
            ElevatedButton(
              child: const Text("Track Order", style: TextStyle(fontFamily: 'OpenSans')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const FoodScreen()));
              },
              child: const Text(
                "Back To Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
