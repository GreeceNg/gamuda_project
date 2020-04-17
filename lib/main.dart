import 'package:flutter/material.dart';
import 'package:gamuda_project/dragable.dart';
import 'package:gamuda_project/auth.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
   runApp(  
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: MyApp(),
    )
);
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: <Widget>[
            Image.asset('assets/gamuda.png', width: 250, fit: BoxFit.fill,),
            RaisedButton(
              padding: EdgeInsets.all(15),
              onPressed: ()  async { 
                bool credentials = await FireAuth().handleSignIn();
                if(!credentials) {
                   return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Oops!!'),
                        content: Text('Something is wrong with login'),
                        actions: <Widget>[
                          FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
                        ],
                      );
                    }
                  );
                  // print("login error");
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => Dragable()));
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/google.png', width: 25, fit: BoxFit.contain,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Sign in with Google"),),
                ],
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.grey[300])
              ),
            ),
          ],
        ),
      ),
    );
  }
}
