import 'package:flutter/material.dart';
import 'package:si/main.dart';
import 'cicalculator.dart';


class BMI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BMI();
  }
}

class _BMI extends State<BMI>{
  var result="";
  var formKey= GlobalKey<FormState>();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController resulttext = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
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
             title:Text('Compound Interest Calculator'),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CMPI();
               }));
             },
           ),
           ListTile(
             title:Text('Body Mass Index Calculator'),
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
                  controller: height,
                keyboardType: TextInputType.number,
                validator: (String value){
                  if(value.isEmpty)
                       return 'Please Enter Your Height in meter';
                },
                decoration: InputDecoration(
                  labelText: 'Height(meter)',
                  hintText: 'Enter Height  Eg:1.4 meter',
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
                  controller: weight,
                  validator: (String value){
                    if(value.isEmpty)
                       return 'Please Enter your Weight in Kg';
                  },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight(Kg)',
                  hintText: 'Enter in Kg',
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
                            this.result=calculateBMI();
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
   AssetImage assetImage = AssetImage('assets/bmi.png');
   Image image = Image(image: assetImage, width:175 , height:200);
   return Container(
     child: image,
   );
 }
   String calculateBMI(){
     double  h=double.parse(height.text);
     double  w=double.parse(weight.text);

     double res = w/(h*h);
     if(res < 18.5){
       String fres='Your BMI is $res. You are UnderWeight.Take Care';
       return fres; 
     }
     else if(res >= 18.5 && res <= 24.9){
      String fres='Your BMI is $res. You are Healthy. Continue the same way :)';
      return fres; 
     }
     else if(res >= 25 && res <= 29.9){
      String fres='Your BMI is $res. You are Overweight.Take Care';
      return fres; 
     }
     else{
      String fres="You BMI ic $res. You are Obese. Please Take Care.";
      return fres; 
     }
     
     
   } 
   void reset(){
     height.text="";
     weight.text="";
     result="";
   } 

}