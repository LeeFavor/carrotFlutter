import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'src/screens/widgets/app.dart';

void main() {
String token = Global.accessToken;
bool isLogin = token.isNotEmpty;
runApp(MyApp(isLogin));
}
