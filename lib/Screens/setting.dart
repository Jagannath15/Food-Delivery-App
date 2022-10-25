import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async{
            SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setBool("finalLogin", true);
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                Get.to(StartPage());
        }, child: Text("Sign out"),
      )
    )
    );

  }
}