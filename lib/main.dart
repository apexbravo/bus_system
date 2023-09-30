import 'package:bus_system/src/login/login.dart';
import 'package:bus_system/src/sample_feature/sample_item_details_view.dart';
import 'package:bus_system/src/sample_feature/sample_item_list_view.dart';
import 'package:bus_system/src/settings/settings_view.dart';
import 'package:bus_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MaterialApp(
    // Providing a restorationScopeId allows the Navigator built by the
    // MaterialApp to restore the navigation stack when a user leaves and
    // returns to the app after it has been killed while running in the
    // background.
    restorationScopeId: 'app',
    theme: AppTheme.defaultTheme,

    // Provide the generated AppLocalizations to the MaterialApp. This
    // allows descendant Widgets to display the correct translations
    // depending on the user's locale.
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''), // English, no country code
    ],
    home: LoginPage(),
    // Use AppLocalizations to configure the correct application title
    // depending on the user's locale.
    //
    // The appTitle is defined in .arb files found in the localization
    // directory.
    onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context)!.appTitle,

    // Define a light and dark color theme. Then, read the user's
    // preferred ThemeMode (light, dark, or system default) from the
    // SettingsController to display the correct theme.

    // Define a function to handle named routes in order to support
    // Flutter web url navigation and deep linking.
    onGenerateRoute: (RouteSettings routeSettings) {
      return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SettingsView.routeName:
            case SampleItemDetailsView.routeName:
              return const SampleItemDetailsView();
            case SampleItemListView.routeName:
            default:
              return const SampleItemListView();
          }
        },
      );
    },
  ));
}
