import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator",
    home: SI_Form(),
  ));
}

class SI_Form extends StatefulWidget {
  @override
  _SI_FormState createState() => _SI_FormState();
}

class _SI_FormState extends State<SI_Form> {
  var _currencies = ["Rupee", "Dollar", "Pound"];
  static const _minimumpadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SI Calculator")),
        body: Container(
          child: Column(
            children: <Widget>[
              getImageAsset(),
              TextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter the principal amount here (ex. 12000)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter the principal amount here (ex. 12000)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              )
            ],
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/bank.png");
    Image image =
        Image(image: assetImage, width: 125.0, height: 125.0, fit: BoxFit.fill);

    return Container(
        child: image, margin: EdgeInsets.all(_minimumpadding * 10.0));
  }
}
