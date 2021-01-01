// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$HomeEventTearOff {
  const _$HomeEventTearOff();

  LoadMovies loadMovie() {
    return const LoadMovies();
  }
}

// ignore: unused_element
const $HomeEvent = _$HomeEventTearOff();

mixin _$HomeEvent {}

abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res>;
}

class _$HomeEventCopyWithImpl<$Res> implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  final HomeEvent _value;
  // ignore: unused_field
  final $Res Function(HomeEvent) _then;
}

abstract class $LoadMoviesCopyWith<$Res> {
  factory $LoadMoviesCopyWith(
          LoadMovies value, $Res Function(LoadMovies) then) =
      _$LoadMoviesCopyWithImpl<$Res>;
}

class _$LoadMoviesCopyWithImpl<$Res> extends _$HomeEventCopyWithImpl<$Res>
    implements $LoadMoviesCopyWith<$Res> {
  _$LoadMoviesCopyWithImpl(LoadMovies _value, $Res Function(LoadMovies) _then)
      : super(_value, (v) => _then(v as LoadMovies));

  @override
  LoadMovies get _value => super._value as LoadMovies;
}

class _$LoadMovies with DiagnosticableTreeMixin implements LoadMovies {
  const _$LoadMovies();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeEvent.loadMovie()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HomeEvent.loadMovie'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadMovies);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class LoadMovies implements HomeEvent {
  const factory LoadMovies() = _$LoadMovies;
}
