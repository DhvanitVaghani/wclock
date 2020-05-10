import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';



//Get data from worldtimeapi.org
class WorldTime {

  String location;
  String flag;
  String time;
  String url;
  bool isday;
     
  WorldTime({this.location,this.flag,this.url,this.isday});   

  Future <void> getData() async {
    try{
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data =jsonDecode(response.body);
    String date = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    
    //convert into propar formate
    DateTime dateTime = DateTime.parse(date);
    dateTime=dateTime.add(Duration(hours: int.parse(offset)));
    isday = dateTime.hour  >6 && dateTime.hour <20 ? true :false;
    time = DateFormat.jm().format(dateTime);
    }

    catch (e) {
         print('error: $e');
    }

 }
}