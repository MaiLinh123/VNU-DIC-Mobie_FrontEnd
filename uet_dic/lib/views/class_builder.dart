import 'package:uet_dic/views/profile.dart';
import 'package:uet_dic/views/home_screen.dart';
import 'package:uet_dic/views/setting.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomeScreen>(() => HomeScreen());
    register<Profile>(() => Profile());
    register<SettingsPage>(() => SettingsPage());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}