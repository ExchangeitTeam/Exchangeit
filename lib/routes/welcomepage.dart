import 'package:exchangeit/routes/loginpage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xF3F3F3F3),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "images/lineartop.png",
                  width: size.width,
                ),
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 20),
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
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              primary: Colors.black,
                              elevation: 20,
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
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
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
