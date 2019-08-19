import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../app_theme.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super(props);
}

class ThemeChanged extends ThemeEvent {
  final AppTheme appTheme;
  final bool darkOn;

  ThemeChanged({@required this.appTheme, this.darkOn}) : super([appTheme]);
}
