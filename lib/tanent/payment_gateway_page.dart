import 'package:flutter/material.dart';
import 'transaction_report_page.dart';

class PaymentGatewayPage extends StatefulWidget {
  final String paymentType;
  final String amount;
  final String description;
  const PaymentGatewayPage({
    Key? key,
    required this.paymentType,
    required this.amount,
    required this.description,
  }) : super(key: key);

  @override
  State<PaymentGatewayPage> createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> {
  String _selectedMethod = '';
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  String? _cardError;
  String? _expiryError;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  Widget _buildCardInput() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.credit_card, color: Colors.black, size: 32),
                const SizedBox(width: 10),
                Text(
                  'VISA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 2,
              ),
              maxLength: 16,
              decoration: InputDecoration(
                labelText: 'Card Number',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.numbers, color: Colors.black),
                fillColor: Colors.white10,
                filled: true,
                errorText: _cardError,
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    maxLength: 5,
                    decoration: InputDecoration(
                      labelText: 'Expiry (MM/YY)',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white10,
                      filled: true,
                      errorText: _expiryError,
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 3,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpiInput() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 10),
                Text(
                  'UPI',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _upiController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'UPI ID or Number',
                labelStyle: const TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  Icons.alternate_email,
                  color: Colors.green,
                ),
                fillColor: Colors.green.shade50,
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Gateway')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paying for: ${widget.paymentType}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Amount: ₹${widget.amount}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (widget.description.isNotEmpty)
              Text(
                'Description: ${widget.description}',
                style: const TextStyle(fontSize: 15),
              ),
            const SizedBox(height: 30),
            const Text(
              'Choose Payment Method:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethod = 'card'),
                    child: Card(
                      color:
                          _selectedMethod == 'card'
                              ? Colors.blue.shade50
                              : Colors.white,
                      elevation: _selectedMethod == 'card' ? 4 : 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.credit_card, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Credit/Debit Card',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethod = 'upi'),
                    child: Card(
                      color:
                          _selectedMethod == 'upi'
                              ? Colors.green.shade50
                              : Colors.white,
                      elevation: _selectedMethod == 'upi' ? 4 : 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'UPI',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_selectedMethod == 'card') _buildCardInput(),
            if (_selectedMethod == 'upi') _buildUpiInput(),
            const SizedBox(height: 24),
            if (_selectedMethod.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    bool valid = true;
                    setState(() {
                      _cardError = null;
                      _expiryError = null;
                    });
                    if (_selectedMethod == 'card') {
                      final cardNum = _cardNumberController.text.trim();
                      final expiry = _expiryController.text.trim();
                      if (cardNum.length != 16 ||
                          !RegExp(r'^\d{16}$').hasMatch(cardNum)) {
                        setState(() {
                          _cardError = 'Card number must be 16 digits';
                        });
                        valid = false;
                      }
                      if (!RegExp(
                        r'^(0[1-9]|1[0-2])/\d{2}$',
                      ).hasMatch(expiry)) {
                        setState(() {
                          _expiryError = 'Format MM/YY required';
                        });
                        valid = false;
                      }
                    }
                    if (!valid) return;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (context) => Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 24),
                                  Text(
                                    'Processing payment...',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                    await Future.delayed(const Duration(seconds: 5));
                    Navigator.of(context).pop();
                    final transactionId =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => TransactionReportPage(
                              transactionId: transactionId,
                              amount: widget.amount,
                              paymentMethod:
                                  _selectedMethod == 'card'
                                      ? 'Credit/Debit Card'
                                      : 'UPI',
                            ),
                      ),
                    );
                  },
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
