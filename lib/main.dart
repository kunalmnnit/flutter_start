import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SIForm(),
    title: 'Simple Interset Calculator App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey=GlobalKey<FormState>();

  var _curr = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected='';
  var display='';
  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected=_curr[0];

  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalController,
                validator: (String value){
                  if(value.isEmpty){
                    return 'Please Enter principle amount';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Principle e.g. 12000',
                    labelText: 'Principle',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                controller: roiController,
                validator: (String value){
                  if(value.isEmpty){
                    return 'Please Enter roi';
                  }
                },
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'In percent',
                    labelText: 'Rate of Interest',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: termController,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please Enter term';
                        }
                      },
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Container(
                    width: _minimumPadding*5,
                  ),

                  Expanded(
                    child: DropdownButton<String>(
                      items: _curr.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Calculate',textScaleFactor: 1.5),
                      onPressed: (){
                          setState(() {
                            if(_formKey.currentState.validate()) {
                              this.display = calculateInterest();
                            }
                          });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Reset',textScaleFactor: 1.5),
                      onPressed: (){
                          setState(() {
                            _reset();
                          });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              child: Text(display,style: textStyle,),
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding)
            )
          ],
        ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      height: 125.0,
      width: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  String calculateInterest(){
    double principle=double.parse(principalController.text);
    double rate=double.parse(roiController.text);
    double term=double.parse(termController.text);

    double amount=principle+(principle*rate*term/100);

    String result='After $term yrs, Amount would be $amount $_currentItemSelected';
    return result;
  }
  void _reset(){
    principalController.text='';
    termController.text='';
    roiController.text='';
    display='';
    _currentItemSelected=_curr[0];

  }

  void _onDropDownItemSelected(String val)
  {
    setState(() {
      this._currentItemSelected=val;
    });
  }
}
