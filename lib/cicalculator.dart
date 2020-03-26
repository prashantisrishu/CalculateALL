import 'dart:math';

import 'package:flutter/material.dart';
import 'bmi.dart';
import 'main.dart';

class CMPI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CMPI();
  }
}

class _CMPI extends State<CMPI>{
  var currency=['Rupees','Euro','Dollars','Pounds'];
  var choice=['Yearly','Half Yearly','Quarter Yearly','Monthly','Weekly','Daily'];
  var selectedItem="Rupees";
  var selectedOtherItem='Yearly';
  var result="";
  var formKey= GlobalKey<FormState>();
  TextEditingController principalControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController resulttext = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("CI CALCULATOR"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Simple Interest Calculator'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SMPI();
                }));
              },
            ),
            ListTile(
              title: Text('Compound Interest Calculator'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CMPI();
                }));
              },
            ),
            ListTile(
              title:Text('Body Mass Calculator'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BMI();
                }));
              },
            ),
            Container(
              height: 500,
            ),
            
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
              Container(height: 15,),
              getImage(),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child:TextFormField(
                  style: textStyle,
                  controller: principalControlled,
                keyboardType: TextInputType.number,
                validator: (String value){
                  if(value.isEmpty)
                       return 'Please Enter a Principal Amount';
                },
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter principal  Eg:10000',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                   ),
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15),
                child:TextFormField(
                  style: textStyle,
                  controller: roiControlled,
                  validator: (String value){
                    if(value.isEmpty)
                       return 'Please Enter Rate of Interest';
                  },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Rate Of Interest',
                  hintText: 'Enter in Percent',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15),
                child:TextFormField(
                  style: textStyle,
                  controller: termControlled,
                  validator: (String value){
                    if(value.isEmpty)
                       return 'Please Enter Term';
                  },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Term',
                  hintText: 'Enter Term',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15),
                child:Row(
                children: <Widget>[
                  Expanded(
                   child:DropdownButton<String>(
                   items: choice.map((String value){
                     return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value),
                     );
                 }).toList(),
                 value: selectedOtherItem,
                onChanged: (String value1Selected){
                   onDropDown2Selected(value1Selected);
                 },
               ),
               ),
              Container(width:25),
              Expanded(
                child:DropdownButton<String>(
                items: currency.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    );
                }).toList(),
                value: selectedItem,
                onChanged: (String valueSelected){
                  onDropDown1Selected(valueSelected);
                },
              ),
              ),
                ],
                )
              ),
              Padding(
                 padding: EdgeInsets.only(top:15),
                child:Row(
                children: <Widget>[
                  Expanded(
                    
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorLight,
                      elevation: 5,
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        ),
                      onPressed: (){
                          
                          setState(() {
                            if(formKey.currentState.validate()){
                            this.result=calculateTotalReturn();
                            }
                          });
                      }),
                    
                    ),
                  Expanded(
                    
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      elevation: 2.5,
                      child: Text("Reset",
                      style: TextStyle(
                        fontSize: 16
                        ),
                        ),
                      onPressed: (){
                         setState(() {
                           reset();
                         });
                      }),
                    ),
                ],
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15),
                child:Column(
                children: <Widget>[
                  Text(
                    this.result,
                    style: TextStyle(
                      fontSize: 22,
                      backgroundColor: Colors.black,
                    ),
                  )
                ],
              ),
              ),
          ],
        ),
      ),
    );
  }

 Widget getImage(){
   AssetImage assetImage = AssetImage('assets/money.jpg');
   Image image = Image(image: assetImage, width:150 , height:150);
   return Container(
     child: image,
   );
 }
   void onDropDown1Selected(String valueSelected){
     setState(() {
       this.selectedItem = valueSelected;
     });
   }
 void onDropDown2Selected(String valueSelected){
     setState(() {
       this.selectedOtherItem = valueSelected;
     });
   }
   String calculateTotalReturn(){
     double  p=double.parse(principalControlled.text);
     double  r=double.parse(roiControlled.text);
     double  t=double.parse(termControlled.text);
     double res;
     if(selectedOtherItem == 'Yearly'){
       res = p + pow((1 + (r/1)),t);
     }
     else if(selectedOtherItem == 'Half Yearly'){
       res = p + pow((1 + (r/2)),t);
     }
     else if(selectedOtherItem == 'Quarter Yearly'){
       res = p + pow((1 + (r/4)),t);
     }
     else if(selectedOtherItem == 'Monthly'){
       res = p + pow((1 + (r/12)),t);
     }
     else if(selectedOtherItem == 'Weekly'){
       res = p + pow((1 + (r/52)),t);
     }
     else if(selectedOtherItem == 'Daily'){
       res = p + pow((1 + (r/365)),t);
     }
     String fres='After $t years, compounded $selectedOtherItem, your investment will be worth $res $selectedItem .';
     return fres; 
     
   } 
   void reset(){
     principalControlled.text="";
     roiControlled.text="";
     termControlled.text="";
     result="";
     selectedItem = 'Rupees';
     selectedOtherItem = "Yearly";
   } 
}