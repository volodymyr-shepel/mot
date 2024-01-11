import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mot/screens/sign_in/sign_in_screen.dart';
import 'package:mot/screens/welcome_screen/components/welcome_content.dart';
import '../home/home_screen.dart';
import '../../constants.dart';


class WelcomeScreen extends StatefulWidget {
  static String routeName = "/";

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;

  // This is screen which is displayed on the welcome screen
  List<Map<String, String>> welcomeData = [
    {
      "text": "Welcome to MOT, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Simplify Your Style: Shop Smart, Shop Easy with Us.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Your Joyful Journey Starts Here: Uncover Effortless Shopping Bliss!",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: welcomeData.length,
                  itemBuilder: (context, index) => WelcomeContent(
                    image: welcomeData[index]["image"],
                    text: welcomeData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          welcomeData.length,
                          (index) => AnimatedContainer(
                            duration: kAnimationDuration,
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? kPrimaryColor
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                          
                          context.push(SignInScreen.routeName); // TODO : CHANGE TO SIGN IN
                          //context.go(HomeScreen.routeName); // TODO : CHANGE TO SIGN IN
                        },
                        child: const Text("Continue"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
