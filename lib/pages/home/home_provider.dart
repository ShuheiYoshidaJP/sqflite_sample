import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/pages/home/home_notifier.dart';
import 'package:sqflite_sample/pages/home/home_state.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
    (ref) => HomeStateNotifier());
