import 'package:chatting_application/contant.dart';
// import 'package:chatting_application/models/UserModel.dart';
import 'package:chatting_application/services/auth.dart';
import 'package:chatting_application/ui/screen/homescreen/HomeScreen.dart';
import 'package:chatting_application/ui/screen/loginscreen/LoginScreen.dart';
import 'package:chatting_application/ui/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'StartupScreenModel.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                Image.asset(
                  "assets/images/Logo_light.png",
                  height: 146,
                ),
                Spacer(),
                PrimaryButton(
                    text: "Sign In",
                    press: () {
                      // UserModel userModel = UserModel();
                      var user = LoginDetails();
                      if (user.checkLogedin() == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      }
                    }),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
