import 'package:flutter_riverpod/flutter_riverpod.dart';

class StringNotifier extends StateNotifier<String> {
  StringNotifier(String state) : super(state);
  void setState(String value) {
    state = value;
  }
}
