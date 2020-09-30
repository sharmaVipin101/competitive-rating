import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CodeChef extends StatefulWidget {
  @override
  _CodeChefState createState() => _CodeChefState();
}

class _CodeChefState extends State<CodeChef> {

  String username;
  String rating;
  String hrating;
  String rank;
  String crank;
  bool loading = false;
  bool _enabled = true;
  Map data;
  String status;
  String text;
  String stars;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future getData()async{

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {

        setState(() {
          _enabled = false;
          loading=true;
        });

        Response response = await get("https://competitive-coding-api.herokuapp.com/api/codechef/$text");

        data = jsonDecode(response.body);

        setState(() {
          _enabled = true;
          loading=false;
            username = data['user_details']['username'];
            rating = data['rating'].toString();
            hrating = data['highest_rating'].toString();
            rank = data['global_rank'].toString();
            crank = data['country_rank'].toString();
            status = data['status'];
            stars = data['stars'];
        });


        if(status=='Failed')
          {
            showDialog(context: context,
            barrierDismissible: true,
            builder: (BuildContext context)
            {
              return AlertDialog(
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
                  TextSpan(
                    text: "  "
                  ),
                  TextSpan(
                      text: stars

                  )
                ]

            ),

          ),

          content: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white70,

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
                       text:"Rating: ",
                     ),
                     TextSpan(
                       text: rating
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
                         text:"Highest Rating: ",
                       ),
                       TextSpan(
                           text: hrating
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
                         fontFamily: 'Times New Roman'
                         , color: Colors.black
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
                         text:"Country Rank: ",
                       ),
                       TextSpan(
                           text: crank
                       )
                     ]

                 ),

               ),
             ],
             ),
          ),
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



      } catch (e) {

      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.orangeAccent,
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
                      enabled: _enabled,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter username';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Codechef Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
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
                padding: EdgeInsets.all(20.0),
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Align(
                  child: Text('Show',style: TextStyle(color: Colors.white,fontSize: 20.0),),
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
