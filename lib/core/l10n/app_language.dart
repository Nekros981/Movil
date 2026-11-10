import 'package:flutter/widgets.dart';

import 'app_strings.dart';

class AppLanguage extends ChangeNotifier {
  AppStrings _strings = AppStrings.spanish;

  AppStrings get strings => _strings;

  bool get isEnglish => _strings.isEnglish;

  void setLocale(AppLocale locale) {
    final next =
        locale == AppLocale.en ? AppStrings.english : AppStrings.spanish;
    if (identical(next, _strings)) {
      return;
    }
    _strings = next;
    notifyListeners();
  }

  void setSpanish() => setLocale(AppLocale.es);

  void setEnglish() => setLocale(AppLocale.en);
}

class AppLanguageScope extends InheritedWidget {
  const AppLanguageScope({
    required this.language,
    required this.strings,
    required super.child,
    super.key,
  });

  final AppLanguage language;
  final AppStrings strings;

  static AppLanguage of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    assert(scope != null, 'AppLanguageScope not found in context');
    return scope!.language;
  }

  static AppStrings stringsOf(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    assert(scope != null, 'AppLanguageScope not found in context');
    return scope!.strings;
  }

  @override
  bool updateShouldNotify(AppLanguageScope oldWidget) =>
      strings != oldWidget.strings;
}
