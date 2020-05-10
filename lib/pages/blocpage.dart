import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wclock/classes/worldtime.dart';
import 'package:wclock/classes/clockbloc.dart';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BlocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BlocPageState();
  }
}

class _BlocPageState extends State<BlocPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocProvider(
              create: (context) => ClockBloc(WorldTime()),
              child: ShowBloc(),
            )));
  }
}

class ShowBloc extends StatefulWidget {
  @override
  _ShowBlocState createState() => _ShowBlocState();
}

class _ShowBlocState extends State<ShowBloc> {
  List<WorldTime> collection = [
    WorldTime(location: 'Kolkata', flag: 'in.png', url: 'Asia/Kolkata'),
    WorldTime(location: 'Moscow', flag: 'moscow.png', url: 'Europe/Moscow'),
    WorldTime(
        location: 'Hong_Kong', flag: 'hongkong.png', url: 'Asia/Hong_Kong'),
    WorldTime(location: 'Melbourne', flag: 'm.png', url: 'Australia/Melbourne'),
    WorldTime(location: 'Stockholm', flag: 's.png', url: 'Europe/Stockholm'),
    WorldTime(location: 'Jamaica', flag: 'j.png', url: 'America/Jamaica'),
    WorldTime(location: 'Lisbon', flag: 'l.png', url: 'Europe/Lisbon'),
    WorldTime(location: 'Toronto', flag: 't.png', url: 'America/Toronto'),
    WorldTime(location: 'Vancouver', flag: 'v.png', url: 'America/Vancouver'),
    WorldTime(location: 'Goose_Bay', flag: 'g.png', url: 'America/Goose_Bay'),
    WorldTime(location: 'Windhoek', flag: 'w.png', url: 'Africa/Windhoek'),
    WorldTime(location: 'London', flag: 'lo.png', url: 'Europe/London'),
  ];

Future<bool> movetolastState(){
  _snackbarshow(context, 'Please, Click on Choose Location');
  return new Future.value(false);
  
} 

  @override
  Widget build(BuildContext context) {
    final clockbloc = BlocProvider.of<ClockBloc>(context);
    return BlocBuilder<ClockBloc, ClockState>(builder: (context, state) {
      if (state is HomeState) {
        return WillPopScope(
          onWillPop: movetolastState,
          child: SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: state.worldTime.isday
                        ? AssetImage('images/day.jpg')
                        : AssetImage('images/night.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 200, 0.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      FlatButton.icon(
                        icon: Icon(
                          Icons.edit_location,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          clockbloc.add(EditLocation());
                        },
                        label: Text(
                          'Choose Location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(state.worldTime.location,
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(state.worldTime.time,
                          style: TextStyle(fontSize: 50.0, color: Colors.white))
                    ])
                  ],
                )),
          )),
        );
      } else if (state is LocationState) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                ),
                backgroundColor: Colors.white,
                body: ListView.builder(
                    itemCount: collection.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            title: Text(collection[index].location,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            onTap: () {
                              clockbloc.add(ShowTime(
                                  location: collection[index].location,
                                  flag: collection[index].flag,
                                  url: collection[index].url));
                            },
                            leading: CircleAvatar(
                              radius: 18.0,
                              backgroundImage: AssetImage(
                                  'images/${collection[index].flag}'),
                            )),
                      );
                    })));
      } else {
        return Text('error');
      }
    });
  }

  void _snackbarshow(BuildContext context, String str) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
      content: Text(str,style: TextStyle(fontSize:18),),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
