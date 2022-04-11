import 'animation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new ElevatedButton(
                child: const Text('Home'),
                onPressed: ( ) {
                  Navigator.pop(context);
                },
              ),
              FadeAnimation(1.2, Text("Login to Covid_App",
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
              SizedBox(height: 30,),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey))
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: "Enter your email"
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: "Enter your password"
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter valid password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(height: 40,),
              FadeAnimation(1.8, Center(
                child: new ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Data is in processing.')));
                    }
                  },
                ),

              )),
            ],
          ),
        ),
      ),
    );
  }
}