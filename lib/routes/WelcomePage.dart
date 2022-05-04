import 'package:exchangeit/routes/LoginPage.dart';
import 'package:exchangeit/routes/SignupPage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xF3F3F3F3),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "images/bottom.png",
                  width: size.width * 0.8,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70),
                  Center(
                    child: Text(
                      "Welcome Exchangeit!",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                          color: Colors.deepOrange,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset('images/travel_welcome.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              primary: Colors.black,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                " Login ",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              primary: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
