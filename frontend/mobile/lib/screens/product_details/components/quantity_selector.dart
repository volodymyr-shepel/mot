import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white, // Set your color here
        borderRadius: BorderRadius.circular(22),
      ),
    child: IntrinsicWidth( // Wrap the Row with IntrinsicWidth to give it proper constraints
      child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (quantity > 1) {
                  setState(() {
                    quantity--;
                  });
                }
              },
            ),
            Text(
              '$quantity',
              style: TextStyle(color: Colors.black, fontSize: 18), // Ensure the color contrasts with the background
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
