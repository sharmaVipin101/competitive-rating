import 'package:flutter/material.dart';
import 'package:ratings/pages/codechef.dart';
import 'package:ratings/pages/forces.dart';
import 'package:ratings/pages/interviewbit.dart';
import 'package:ratings/pages/spoj.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<String> platform = ['CodeChef','Codeforces','Spoj','Interviewbit'];
List<Widget> platforms = [CodeChef(),Forces(),Spoj(),InterviewBit()];
List<String> images = ['assets/codechef.png','assets/codeforces.jpg','assets/spoj.png','assets/interview.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ratings'
        ),
      ),
    body: SafeArea(


      child: Container(
margin: EdgeInsets.all(3),
        child: Column(
          children: [

           CircleAvatar(
             backgroundImage: AssetImage('assets/coder1.jpg'),
             minRadius: 110,
             foregroundColor: Colors.white,
           ),
            SizedBox(height: 10,),
            Expanded(

              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: 4,
                  itemBuilder:(context,i)=>SizedBox(
                    width: 100,
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      color: Colors.deepOrangeAccent,
                      child: Image(image: AssetImage(images[i]),),
//                  child: Text(
//                    platform[i]
//                  ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>platforms[i]
                        ));
                      },
                    ),
                  )),

            ),
          ],

        ),
      ),
    ),
    );
  }


}

