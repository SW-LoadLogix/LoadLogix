//import 'package:animated_login/animated_login.dart';
import 'package:async/async.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:load_frontend/animated_login/animated_login.dart';

import '../constaints.dart';
import '../routes/app_router.dart';
import '../services/user_service.dart';
import '../utils/dialog_builders.dart';

@RoutePage()
class SignInUpPage extends StatefulWidget {
  const SignInUpPage({Key? key}) : super(key: key);
  @override
  State<SignInUpPage> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<SignInUpPage> {
  /// Example selected language, default is English.
  LanguageOption language = _languageOptions[0];

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(

       onLogin: (LoginData data) async =>
           _authOperation(LoginFunctions(context).onLogin(data)),
       onSignup: (SignUpData data) async =>
           _authOperation(LoginFunctions(context).onSignUp(data)),
      //onForgotPassword: _onForgotPassword,

      logo: Image.asset('assets/images/logo.gif'),
      //backgroundImage: 'images/background_image.jpg',
      signUpMode: SignUpModes.both,
      socialLogins: _socialLogins(context),
      loginDesktopTheme: _desktopTheme,
      loginMobileTheme: _mobileTheme,
      loginTexts: _loginTexts,
      emailValidator: ValidatorModel(
          validatorCallback: (String? email) => '이메일을 확인해주세요! $email'),
      changeLanguageCallback: (LanguageOption? _language) {
        // if (_language != null) {
        //   DialogBuilder(context).showResultDialog(
        //       'Successfully changed the language to: ${_language.value}.');
        //   if (mounted) setState(() => language = _language);
        // }
      },
      changeLangDefaultOnPressed: () async => _operation?.cancel(),
      languageOptions: _languageOptions,
      selectedLanguage: language,
      initialMode: currentMode,
      onAuthModeChange: (AuthMode newMode) async {
        currentMode = newMode;
        await _operation?.cancel();
      },
    );
  }

  Future<String?> _authOperation(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      if (res == "failed") {
        DialogBuilder(context).showResultDialog('Failed to login.');
      }
      else if (res == "success") {
        DialogBuilder(context).showResultDialog('Successfully logged in.');
        AutoRouter.of(context).push(DashboardRoute());
        //Navigator.of(context).pushNamed('/dashboard');
      }
      else if (res == null) {
        DialogBuilder(context).showResultDialog('Failed to login.');
      }
      else {
        DialogBuilder(context).showResultDialog(res);
      }
    }
    return res;
  }

  // Future<String?> _onForgotPassword(String email) async {
  //   await _operation?.cancel();
  //   return await LoginFunctions(context).onForgotPassword(email);
  // }

  static List<LanguageOption> get _languageOptions =>
      const <LanguageOption>[
        // LanguageOption(
        //   value: 'Turkish',
        //   code: 'TR',
        //   iconPath: 'assets/images/tr.png',
        // ),
        LanguageOption(
          value: '한국어',
          code: 'KR',
          //iconPath: 'assets/images/en.png',
        ),
      ];


  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme =>
      _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
        loadingSocialButtonColor: primary,//Color.fromARGB(255, 0x3A,0xB9,0xFF),
        //Colors.blue,
        loadingButtonColor: Colors.white,
        privacyPolicyStyle: const TextStyle(color: Colors.black87),
        privacyPolicyLinkStyle: const TextStyle(
            color: primary,//Color.fromARGB(255, 0x3A,0xB9,0xFF), //Colors.blue,
            decoration: TextDecoration.underline),
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme =>
      LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: primary,//const Color.fromARGB(255, 0x3A,0xB9,0xFF),
        //Colors.blue, // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primary),
        ),
        animatedComponentOrder: const <AnimatedComponent>[
          /*AnimatedComponent(
            component: LoginComponents.logo,
            animationType: AnimationType.right,
          ),*/
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          //AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(component: LoginComponents.forgotPassword),
          AnimatedComponent(component: LoginComponents.policyCheckbox),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
        privacyPolicyStyle: const TextStyle(color: Colors.white70),
        privacyPolicyLinkStyle: const TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      );

  LoginTexts get _loginTexts =>
      LoginTexts(
        nameHint: _username,
        login: _login,
        signUp: _signup,
        // signupEmailHint: 'Signup Email',
        // loginEmailHint: 'Login Email',
        // signupPasswordHint: 'Signup Password',
        // loginPasswordHint: 'Login Password',
      );

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage scren.
  String get _username => '사용자 이름';

  String get _login => 'Login';

  String get _signup =>  'Sign Up';

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) =>
      <SocialLogin>[
        // SocialLogin(
        //     callback: () async => _socialCallback('Google'),
        //     iconPath: 'assets/images/google.png'),
        // SocialLogin(
        //     callback: () async => _socialCallback('Facebook'),
        //     iconPath: 'assets/images/facebook.png'),
        // SocialLogin(
        //     callback: () async => _socialCallback('LinkedIn'),
        //     iconPath: 'assets/images/linkedin.png'),
      ];

//   Future<String?> _socialCallback(String type) async {
//     await _operation?.cancel();
//     _operation = CancelableOperation.fromFuture(
//         LoginFunctions(context).socialLogin(type));
//     final String? res = await _operation?.valueOrCancellation();
//     if (_operation?.isCompleted == true && res == null) {
//       DialogBuilder(context)
//           .showResultDialog('Successfully logged in with $type.');
//     }
//     return res;
//   }

}


// /// Example forgot password screen
// class ForgotPasswordScreen extends StatelessWidget {
//   /// Example forgot password screen that user is navigated to
//   /// after clicked on "Forgot Password?" text.
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('FORGOT PASSWORD'),
//       ),
//     );
//   }
// }

