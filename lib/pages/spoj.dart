import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Spoj extends StatefulWidget {
  @override
  _SpojState createState() => _SpojState();
}




class _SpojState extends State<Spoj> {



  String username;
  String rank;
  String points;
  String status;
  bool loading = false;
  Map data;

  String text;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future getData()async{

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {

        setState(() {
          loading=true;
        });

        Response response = await get("https://competitive-coding-api.herokuapp.com/api/spoj/$text");

         data = jsonDecode(response.body);



        setState(() {
          status =data['status'];
          username = data['username'];
          points = data['points'].toString();
          rank = data['rank'].toString();

          loading=false;
        });

        if(status=='Failed')
        {
          showDialog(context: context,
              barrierDismissible: true,
              builder: (BuildContext context)
              {
                return AlertDialog(
                  backgroundColor: Color(0xffFBD28B),
                  title: Text('Error Occurred'),
                  content: Text(data['details']),
                  actions: [
                    FlatButton(
                      child: Text("ok",style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Times New Roman'
                      ),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                );

              });
        }
        else
        {

          showDialog(context: context,
              barrierDismissible: true,
              builder: (BuildContext context)
              {
                return AlertDialog(
                  backgroundColor: Color(0xffFBD28B),
                  title: RichText(
                    softWrap: true,
                    text:TextSpan(
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Times New Roman',
                            color: Colors.black
                        ),
                        children: [
                          TextSpan(
                            text:username,

                          ),

                        ]

                    ),

                  ),

                  content: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
//                      color: Colors.white70,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(height: 5,),
                        RichText(
                          softWrap: true,
                          text:TextSpan(
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                  text:"Points: ",
                                ),
                                TextSpan(
                                    text: points
                                )
                              ]

                          ),

                        ),
                        Divider(height: 5,),
                        RichText(
                          softWrap: true,
                          text:TextSpan(
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                  text:"Rank: ",
                                ),
                                TextSpan(
                                    text: rank
                                )
                              ]

                          ),

                        ),
                        Divider(height: 5,),

                      ],
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("ok",style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Times New Roman'
                      ),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                );

              });
        }




      } catch (e) {

      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffFBD28B),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 100.0,),
              CircleAvatar(
                backgroundImage: AssetImage('assets/coder.jpg',),
                maxRadius: 150,
                minRadius: 120,

              ),
              SizedBox(height: 10.0,),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      enabled: !loading,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter username';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'SPOJ Username',

                        helperMaxLines: 1,
                        icon: Icon(Icons.account_circle),
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(5.0),
//                        ),
                      ),
                      onSaved: (input) {
                        text = input;
                      },
                    ),
                  ),
                ),

              ),
              SizedBox(height: 10.0,),
              loading ? CircularProgressIndicator():MaterialButton(
                padding: EdgeInsets.all(10.0),
                color: Color(0xffE5B143),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Align(
                  child: Text('Show',style: TextStyle(color: Colors.white70,fontSize: 30.0,fontFamily: 'monospace'),),
                ),
                onPressed: (){
                  getData();
                },
              )

            ],
          ),
        ),
      ),

    );
  }

}
