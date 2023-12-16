import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: inputBorderColor),
  borderRadius: BorderRadius.all(Radius.circular(5)),
);

const inputBorderColor = Color(0xFFE5E5E5);
const primaryColor = Color(0xFFFC9191);
const accentCircleColor = Color(0xFFE5E5E5);
const brandColor = Color(0xFF2947AE);
const surfacePrimary = Color(0xFFEFF2F4);
const surfaceMedium = Color(0xFFCED0D1);
const cardBackground = Color(0xFFEFFFFF);
const secondaryColor = Color(0xFF124E78); //Color(0xFFFFED00);
const secondaryColorLight = Color(0xFFe5ffff);
const secondaryColorDark = Color(0xFF82ada9);
const textHeading = Color(0xFF080DCB);
const textColorPrimary = Color(0xFF3E4E58);
const labelText = Color(0xFFADAFB2);
const navBarButton = Color(0xFF8A8D90);
const errorColor = Color(0xFFEB5757);
const successColor = Color(0xFF27AE60);
const warningColor = Color(0xFFE2B93B);
const infoColor = Color(0xFF2F80ED);
const inActiveText = Color(0xFF6F6C90);
const appBackground = Color(0xFFF5F5F5);
const buttonPrimary = Color(0xFFFC9191);
const buttonRadius = 32.0;
const buttonPrimaryTextColor = Color(0xFF124E78);
const buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 8);
const gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.9],
  colors: [
    Color(0xFF3748AB),
    Color(0xFF17226E),
  ],
);

class AppTheme {
  static final ThemeData defaultTheme = _buildAppTheme();

  static ButtonStyle registerGradientButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all(buttonPadding),
      minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static ButtonStyle roundedTextButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(textHeading),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all(buttonPadding),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.minPositive, 56)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(1151)),
      ),
    );
  }

  static InputDecoration inputTextBox(String label, Widget? suffixIcon,
      Widget? prefixIcon, BuildContext context) {
    return InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: const EdgeInsets.all(0),
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF232452),
            width: 0.8, // Adjust the width as needed
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF232452),
            width: 0.8, // Adjust the width as needed
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF232452),
            width: 0.8, // Adjust the width as needed
          ),
        ),
        filled: true,
        hintText: label,
        fillColor: Colors.white,
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.error)
              ? Theme.of(context).colorScheme.error
              : Colors.black;
          return TextStyle(
              color: color, letterSpacing: 1.3, fontWeight: FontWeight.w500);
        }),
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon // suffixIcon: IconButton(
        //   icon: Icon(
        //     !_obscureText
        //         ? Icons.visibility_off
        //         : Icons
        //             .visibility, //change icon based on boolean value
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       _obscureText =
        //           !_obscureText; //change boolean value
        //     });
        //   },
        // ),
        );
  }

  static ButtonStyle roundedGreenTextButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(successColor),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.minPositive, 56)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius)),
      ),
    );
  }

  static ButtonStyle roundedWarningTextButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.minPositive, 56)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius)),
      ),
    );
  }

  static ButtonStyle roundedDangerTextButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.minPositive, 56)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius)),
      ),
    );
  }

  static const tertiaryBtnTextStyle =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400);
  static ButtonStyle tertiaryBtnStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(surfaceMedium),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ));

  static ButtonStyle roundedSecondaryTextButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.maxFinite, 56)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(1151)),
      ),
    );
  }

  static ButtonStyle roundedSecondaryOutlineButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          Colors.transparent), // Set background color to transparent
      foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white), // Set text color to white
      side: MaterialStateProperty.all<BorderSide>(
        // Define the border side
        const BorderSide(
          color: Colors.white, // Set the border color to your desired color
          width: 1, // Set the border width
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(double.minPositive, 56),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1151),
        ),
      ),
    );
  }

  static ButtonStyle cancelButtonStyle() => OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red, width: 1),
        minimumSize: const Size.fromHeight(50),
        // maximumSize: const Size.fromWidth(250),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(buttonRadius)),
        ),
      );
  static ButtonStyle warningButtonStyle() => OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.yellow, width: 1),
        minimumSize: const Size.fromHeight(50),
        // maximumSize: const Size.fromWidth(250),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(buttonRadius)),
        ),
      );

  static InputDecoration inputDecoration(
    BuildContext context,
    String label, {
    bool isRequired = false,
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: isRequired ? '*$label' : label,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF232452),
          width: 0.8, // Adjust the width as needed
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF232452),
          width: 0.8, // Adjust the width as needed
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF232452),
          width: 0.8, // Adjust the width as needed
        ),
      ),
      filled: true,
      hintText: hint,
      fillColor: Colors.white,
      floatingLabelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final Color color = states.contains(MaterialState.error) || isRequired
            ? Theme.of(context).colorScheme.error
            : Colors.black;
        return TextStyle(color: color, letterSpacing: 1.3);
      }),
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  static ThemeData _buildAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        primaryColor: primaryColor,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: secondaryColor,
        ),
        scaffoldBackgroundColor: appBackground,
        cardColor: cardBackground,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: secondaryColor,
          primaryContainer: brandColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
        appBarTheme: const AppBarTheme(
            backgroundColor: secondaryColor,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.0),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: brandColor),
            shape: Border(
                bottom: BorderSide(
              color: primaryColor,
              width: 2,
            ))),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF8F8F9),
          hintStyle: TextStyle(
            color: Color(0xFF838383),
          ),
          border: defaultOutlineInputBorder,
          enabledBorder: defaultOutlineInputBorder,
          focusedBorder: defaultOutlineInputBorder,
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
                color: Color(0xFFfFFFFF))),
            backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
            foregroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF232452)),
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(double.maxFinite, 56)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1151)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,

            side: const BorderSide(color: primaryColor, width: 1),
            minimumSize: const Size.fromHeight(50),
            padding: buttonPadding,
            // maximumSize: const Size.fromWidth(250),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(buttonRadius)),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
            ),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          margin: EdgeInsets.only(left: 30.0, right: 30, top: 8, bottom: 16),
          elevation: 2,
        ));
  }
}
