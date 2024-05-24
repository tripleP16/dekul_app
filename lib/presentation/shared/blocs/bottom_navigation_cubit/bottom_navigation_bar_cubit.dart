import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit()
      : super(const BottomNavigationBarState(currentPage: Pages.reports));

  void changePage(Pages page) => emit(state.copyWith(currentPage: page));
}
