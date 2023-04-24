
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'constants/nav_bar_items.dart';

import'navigation_state.dart';

class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  NavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [this.navbarItem, this.index];
}