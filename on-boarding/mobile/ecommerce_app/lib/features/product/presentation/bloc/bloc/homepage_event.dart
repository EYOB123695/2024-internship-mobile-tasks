part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class HomePageLoadEvent extends HomepageEvent {
  HomePageLoadEvent();
}

class RefreshPageLoadEvent extends HomepageEvent {
  RefreshPageLoadEvent();
}
