import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wclock/pages/blocpage.dart';

void main() { 
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light
   ));
    
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wclock',
        home: BlocPage(),
  
      ));}
  
  
