import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery Order Track',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: OrderTrackPage(),
    );
  }
}

class OrderTrackPage extends StatelessWidget {
  final List<String> orderStages = [
    "Order Placed",
    "Preparing",
    "Out for Delivery",
    "Delivered"
  ];

  final int currentStage = 2; // Example: Order is currently "Out for Delivery"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Status",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < orderStages.length; i++)
              OrderStageTile(
                stageName: orderStages[i],
                isActive: i <= currentStage,
              ),
          ],
        ),
      ),
    );
  }
}

class OrderStageTile extends StatelessWidget {
  final String stageName;
  final bool isActive;

  OrderStageTile({required this.stageName, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isActive ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isActive ? Colors.orange : Colors.grey,
      ),
      title: Text(
        stageName,
        style: TextStyle(
          color: isActive ? Colors.orange : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}