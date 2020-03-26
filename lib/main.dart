import 'package:flutter/material.dart';
import 'cicalculator.dart';
import 'bmi.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Intrest Calc",
      home: SMPI(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo
      ),
      )
      );
}

class SMPI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SMPI();
  }
}

class _SMPI extends State<SMPI>{
  var currency=['Rupees','Euro','Dollars','Pounds'];
  var selectedItem="Rupees";
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
        title: Text("SI CALCULATOR"),
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
                child:Row(
                children: <Widget>[
                  Expanded(
                    child:TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termControlled,
                      validator: (String value){
                        if(value.isEmpty)
                           return 'Please Enter Time Period';
                      },
                      decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'Enter in years',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                  )
                ),
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
                  onDropDownSelected(valueSelected);
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
   AssetImage assetImage = AssetImage('assets/img.jpg');
   Image image = Image(image: assetImage, width:125 , height:125);
   return Container(
     child: image,
   );
 }
   void onDropDownSelected(String valueSelected){
     setState(() {
       this.selectedItem = valueSelected;
     });
   }
   String calculateTotalReturn(){
     double  p=double.parse(principalControlled.text);
     double  r=double.parse(roiControlled.text);
     double  t=double.parse(termControlled.text);

     double res = p+(p*t*r)/100;
     String fres='After $t years, your investment will be worth $res $selectedItem .';
     return fres; 
     
   } 
   void reset(){
     principalControlled.text="";
     roiControlled.text="";
     termControlled.text="";
     result="";
     selectedItem = 'Rupees';
   } 
   Material yourTheme(){
     return Material(
       child: ListTile(
         title: Text('Dark Theme'),
         trailing: Switch(value: true, onChanged: (bool newvalue){

         })),
       );
   }
}