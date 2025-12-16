import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatePage  extends StatefulWidget {
  const CalculatePage({ Key?  key }) : super( key : key);

  @override
  _CalcPageState createState() => _CalcPageState();
}

class _CalcPageState extends State<CalculatePage> {
  final TextEditingController price = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController receive = TextEditingController();

  double _total = 0.0;
  double _change = 0.0;

  @override
  void dispose() {
    price.dispose();
    amount.dispose();
    receive.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    if (price.text.isNotEmpty && amount.text.isNotEmpty) {
      final double priceValue = double.tryParse(price.text) ?? 0;
      final int amountValue = int.tryParse(amount.text) ?? 0;

      setState(() {
        _total = priceValue * amountValue;
        _change = 0; // รีเซ็ตเงินทอนเมื่อคิดยอดใหม่
      });
    }
  }

  void _calculateChange() {
    if (receive.text.isNotEmpty) {
      final double receiveValue = double.tryParse(receive.text) ?? 0;

      setState(() {
        _change = receiveValue - _total;
      });
    }
  }

  // ====== widget ย่อยต่าง ๆ (ตอนนี้อยู่ใน State แล้ว ใช้ setState/ตัวแปรได้) ======

  Widget _priceTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: price,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Price per item',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _amountTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: amount,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Amount',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _calculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: _calculateTotal,
        child: const Text("Calculate Total"),
      ),
    );
  }

  Widget _showTotalText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Total: $_total",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _receiveMoneyTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: receive,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Receive money',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _changeCalculationButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: _calculateChange,
        child: const Text("Calculate Change"),
      ),
    );
  }

  Widget _showChangeText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Change: $_change",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Calculate",
                style: TextStyle(
                  fontFamily: "maa",
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.pinkAccent,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset('assets/1.jpg'),
              const Text(
                "Fill the price",
                textAlign: TextAlign.center,
              ),
              Image.network(
                'https://media3.giphy.com/media/v1.Y2lkPTZjMDliOTUyYXM1eWZzeHg1b2loZzF6YzViemo1aXR2eTJ5MmMxYm9qdXB2d3N3dCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/5K7ngCtszoxxbaBieC/200w.gif',
                height: 100,
              ),
              _priceTextField(),
              _amountTextField(),
              _calculateButton(),
              _showTotalText(),
              const SizedBox(height: 16),
              const Text(
                "Receive money",
                textAlign: TextAlign.center,
              ),
              _receiveMoneyTextField(),
              _changeCalculationButton(),
              _showChangeText(),
            ],
          ),
        ),
      ),
    );
  }
}