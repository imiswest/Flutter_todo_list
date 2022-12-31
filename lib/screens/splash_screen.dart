import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_screen.dart';
import 'login_screen.dart';

///splash 화면일 때 로그인 정보(데이터)를 가져오게 함
///이때, 가져올 로그인 정보가 있다면 >> ListScreen , 없다면 >> LoginScreen

class SplashScreen extends StatefulWidget { //Stateful 쓰는 이유 : initState()를 사용하기 위해서
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> checkLogin() async { //비동기로 처리
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getInstanch()로 기기 내 shared_prefs 객체를 가져오고, isLogin이라는 이름으로 저장된 bool형태의값을 getBool로 가져옴
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print('[*] isLogin :' + isLogin.toString());
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) { //checkLogin 함수가 수행된 이후 수행해야 하는 일은 .then()으로 선언
      //then 뒤의 () 안에 들어가야 하는 것 : 넘겨받을 return 값 인자
      if (isLogin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
            (context) => ListScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
            (context) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    //initState와 같이 StatefulWidget에는 위젯의 생성부터 소멸까지 생애주기(Lifecycle)를 다루는 메서드들이 있음.
    // 이를 적절히 활용하면 원하는 순간에 원하는 함수 등을 실행시킬 수 있음
    super.initState();
    Timer(Duration(seconds: 2), () {
      moveScreen();
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SplashScreen',
              style: TextStyle(fontSize: 20),
            ),
            Text('나만의 일정 관리 : TODO LIST APP',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
