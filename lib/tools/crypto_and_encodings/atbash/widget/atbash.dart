import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/atbash/logic/atbash.dart';

const String _apiSpecification = '''
{
  "/atbash" : {
    "alternative_paths": ["atbasch"],
    "get": {
      "summary": "Atbash Tool",
      "responses": {
        "204": {
          "description": "Tool loaded. No response data."
        }
      },
      "parameters" : [
        {
          "in": "query",
          "name": "input",
          "required": true,
          "description": "Input data for Atbash text",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  }
}
''';

class Atbash extends GCWWebStatefulWidget {
  Atbash({Key? key}) : super(key: key, apiSpecification: _apiSpecification);

  @override
  _AtbashState createState() => _AtbashState();
}

class _AtbashState extends State<Atbash> {
  late TextEditingController _controller;

  String _currentInput = '';

  @override
  void initState() {
    super.initState();

    if (widget.hasWebParameter()) {
      _currentInput = widget.getWebParameter('input') ?? _currentInput;
      widget.webParameter = null;
    }

    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWDefaultOutput(child: atbash(_currentInput))
      ],
    );
  }
}
