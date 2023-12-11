import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/bloc/cubit_library_info.dart';
import 'package:jaleskhair/userInterface/bloc/state_library_info.dart';
import 'package:jaleskhair/userInterface/presentation/user_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthLogin extends StatefulWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {

  String? token;
  bool initial = true;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if(initial == true){
      SharedPreferences.getInstance().then((shard){
        setState(() {
          initial = false;
          token = shard.getString("save_token");
          // debugPrint("ttttttt"+token!);
          debugPrint('***********');
        });
      });
      // return CircularProgressIndicator();
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: w,
              height: h,
              color: Colors.white,
            ),
            Center(
              child: Text(
                "",
                // "اهلا بعودتك",
                style: const TextStyle(
                  color: primarycolor,
                ),
              ),
            )
          ],
        ),
      );
    }else {
      if(token == null){
        return LoginScreen();
      } else {
        return BlocProvider(
          create: (context) => LibraryInformationCubit(InitLibraryInformationState()),
            child: UserInterface()
        );
      }
    }

  }
}
