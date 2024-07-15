part of 'bottom_navigation_bar_cubit.dart';

enum Pages { reports, beneficiaries, settings }

class BottomNavigationBarState {
  final Pages currentPage;

  const BottomNavigationBarState({required this.currentPage});

  BottomNavigationBarState copyWith({Pages? currentPage}) {
    return BottomNavigationBarState(
        currentPage: currentPage ?? this.currentPage);
  }
}
