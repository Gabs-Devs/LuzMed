import 'package:flutter/material.dart';

class InputWidgetEmail extends StatefulWidget {
  final String emailLabelText;
  final String emailHintText;
  final TextEditingController? controller;

  const InputWidgetEmail({
    super.key,
    this.emailLabelText = "Email",
    this.emailHintText = "Coloque seu email",
    this.controller,
  });

  @override
  _InputWidgetEmailState createState() => _InputWidgetEmailState();
}

class _InputWidgetEmailState extends State<InputWidgetEmail> {
  @override
  Widget build(BuildContext context) {
    bool isEmailRequired = widget.emailLabelText.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(234, 239, 255, 20),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmailInput(widget.emailLabelText, widget.emailHintText, isEmailRequired),
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildEmailInput(String labelText, String hintText, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isRequired ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        TextField(
          controller: widget.controller, 
          decoration: InputDecoration(
            labelText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}