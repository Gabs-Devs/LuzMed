import 'package:flutter/material.dart';

class InputWidgetPswrd extends StatefulWidget {
  final String passwordLabelText;
  final String passwordHintText;
  final TextEditingController? controller;

  const InputWidgetPswrd({
    super.key,
    this.passwordLabelText = "Senha",
    this.passwordHintText = "Coloque sua senha",
    this.controller,
  });

  @override
  _InputWidgetPswrdState createState() => _InputWidgetPswrdState();
}

class _InputWidgetPswrdState extends State<InputWidgetPswrd> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isPasswordRequired = widget.passwordLabelText.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(234, 239, 255, 20),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          _buildPasswordInput(widget.passwordLabelText, widget.passwordHintText, isPasswordRequired),
        ],
      ),
    );
  }

  Widget _buildPasswordInput(String labelText, String hintText, bool isRequired) {
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
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
