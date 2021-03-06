import 'animation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:loading_animations/loading_animations.dart';
import 'adminDashboard.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  login createState() => login();
}

class login extends State<LoginPage> {


  @override
  final _formKey = GlobalKey<FormState>();


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



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
                child: const  Icon(Icons.arrow_back),
                onPressed: ( ) {
                  Navigator.pushNamed(context, '/');
                },
              ),
              FadeAnimation(1.2, Text(DemoLocalizations.of(context).loginHeading,
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
                        controller: emailController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: DemoLocalizations.of(context).loginEmail
                        ),
                        validator: (value) {
                          if (value == '') {
                            return DemoLocalizations.of(context).emailValidation;
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: DemoLocalizations.of(context).loginPw
                        ),
                        validator: (value) {
                          if (value == '') {
                            return DemoLocalizations.of(context).pwValidation;
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
                child: ElevatedButton(
                  child: Text(DemoLocalizations.of(context).loginText),

                  onPressed: () {
                    final snackBar = SnackBar(
                      content: LoadingFilling.square()
                    );

                    final successMessage = SnackBar(
                      content: Text(DemoLocalizations.of(context).successfulLoginAlert),
                    );

                    final failedMessage = SnackBar(
                      content: Text(DemoLocalizations.of(context).failedLoginAlert),
                    );
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      if(emailController.text == "admin@gmail.com" && passwordController.text == "admin123"){
                        ScaffoldMessenger.of(context).showSnackBar(successMessage);
                        Navigator.pushNamed(context, '/adminHomepage');
                      } else {
                      ScaffoldMessenger.of(context).showSnackBar(failedMessage);
                      }
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