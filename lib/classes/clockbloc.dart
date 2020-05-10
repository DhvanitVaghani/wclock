import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'worldtime.dart';


// Bloc Pattern
class ClockEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class EditLocation extends ClockEvent {}

class ShowTime extends ClockEvent {
  String location;
  String flag;
  String url;
  ShowTime({this.location, this.flag, this.url});
  @override
  List<Object> get props => [location, flag, url];
}

class ClockState extends Equatable {
  @override
  List<Object> get props => null;
}

class HomeState extends ClockState {
  WorldTime worldTime;
  HomeState(this.worldTime);

  @override
  List<Object> get props => [worldTime];
}

class LoadingState extends ClockState {}

class LocationState extends ClockState {}

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  WorldTime worldTime;

  ClockBloc(this.worldTime);
  @override
  ClockState get initialState => LocationState();

  @override
  Stream<ClockState> mapEventToState(ClockEvent event) async* {
    if (event is EditLocation) {
      yield LocationState();
    } else if (event is ShowTime) {
      WorldTime worldTime =
          WorldTime(location: event.location, flag: event.flag, url: event.url);
      await worldTime.getData();
      yield HomeState(worldTime);
    } else {
      print('erorr');
    }
  }
}
