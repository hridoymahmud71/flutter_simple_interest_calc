import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hridoy_utililies/utility.dart';

void main() {
  runApp(MaterialApp(
      title: "Simple Interest Calculator",
      debugShowCheckedModeBanner: false,
      home: SI_Form(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent)));
}

class SI_Form extends StatefulWidget {
  @override
  _SI_FormState createState() => _SI_FormState();
}

class _SI_FormState extends State<SI_Form> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ["Taka", "Rupee", "Dollar", "Pound"];
  var _currency = "";
  static const _minimumpadding = 5.0;

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var resultDisplay = "";

  void setDefaultCurrency() {
    this._currency =
        this._currencies.isNotEmpty ? this._currencies[0] : "Unknown Currency";
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  void initState() {
    super.initState();
    this.setDefaultCurrency();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("SI Calculator")),
        body: Form(
          key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
          child: ListView(children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.all(_minimumpadding * 2),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                style: textStyle,
                controller: principalController,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter Principal amount";
                  }
                  if(!Utility.isNumeric(value)){
                    return "Principal amount should be numeric";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter the principal amount here (ex. 12000)",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                style: textStyle,
                controller: rateController,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter Interest Rate";
                  }
                  if(!Utility.isNumeric(value)){
                    return "Interest Rate should be numeric";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Interest",
                    hintText: "Enter the interest rate (ex. 11.5)",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      controller: termController,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter the number of terms";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Terms",
                          hintText: "Enter number of terms/year (ex. 3)",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                        value: _currency,
                        onChanged: (String newValue) {
                          setState(() {
                            _currency = newValue;
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text("Calculate", textScaleFactor: 1.5),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            this.resultDisplay = calculateTotalReturns();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      child: Text("Reset", textScaleFactor: 1.5),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(_minimumpadding * 2),
                child: Text(
                  this.resultDisplay,
                  style: textStyle,
                ))
          ]),
        )));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/bank.png");
    Image image = Image(image: assetImage, width: 150.0, height: 150.0);

    return Container(
        child: image, margin: EdgeInsets.all(_minimumpadding * 10.0));
  }

  void _onDropDownCurrencySelect(givenValue) {
    this._currency = givenValue;
  }

  String calculateTotalReturns() {
    return "After ${termController.text} years your return will be $_currency${calculatedReturn()}";
  }

  double calculatedReturn() {
    double p = double.parse(principalController.text);
    int n = int.parse(termController.text);
    double r = double.parse(rateController.text);

    double total = p + ((p * n * r) / 100);
    return total;
  }

  void _reset() {
    this.principalController.text = "";
    this.termController.text = "";
    this.rateController.text = "";
    this.resultDisplay = "";
    this.setDefaultCurrency();
  }
}
