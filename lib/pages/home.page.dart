import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../widgets/logo.widget.dart';
import '../widgets/submit-form.dart';
import '../widgets/success.widget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcoolCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200
        ),
        color: _color,
        child: ListView(
          children: <Widget>[
            Logo(),
            _completed ? Success(
              result: _resultText,
              reset: reset,
            )
            :
            SubmitForm(
              alcoolCtrl: _alcoolCtrl,
              gasCtrl: _gasCtrl,
              submitFunc: calculate,
              busy: _busy,
            ),
          ],
        )
      )
    );
  }

  Future calculate(){
    double alc = double.parse(
      _alcoolCtrl.text.replaceAll(new RegExp(r'[,.]'),'')
    ) / 100;
    double gas = double.parse(
      _gasCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
    ) / 100;
    double res = alc / gas;
    
    setState((){
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(
      const Duration(seconds: 1),
      () {
        setState((){
          if (res >= 0.7) {
            _resultText = "Compensa utilizar Gasolina!";
          } else {
            _resultText = "Compensa utilizar Álcool!";
          }
          _completed = true;
          _busy = false;
        });
      }
    );
  }

  reset() {
    setState(() {
      _alcoolCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
      _color = Colors.deepPurple;
    });
  }
}