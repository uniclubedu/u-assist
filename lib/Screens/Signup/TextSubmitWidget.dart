import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSubmitWidget extends StatefulWidget {
  const TextSubmitWidget({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  State<StatefulWidget> createState() => _TextSubmitWidget ();
}

class _TextSubmitWidget extends State<TextSubmitWidget> {

  TextEditingController _controller = TextEditingController();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter your name'
          ),
        ),
      ],
    );
  }
}
