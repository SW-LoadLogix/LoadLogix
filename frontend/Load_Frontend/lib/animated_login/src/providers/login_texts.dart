import 'package:load_frontend/animated_login/src/models/language_option.dart';
//import 'package:load_frontend/animated_login/'
import 'package:flutter/material.dart';

/// [LoginTexts] is the provider for all texts in the login screen.
class LoginTexts extends ChangeNotifier {
  /// Provides default texts for those aren't provided in the constructor.
  LoginTexts({
    String? welcome,
    String? welcomeDescription,
    String? signUp,
    String? signUpFormTitle,
    String? signUpUseEmail,
    String? welcomeBack,
    String? welcomeBackDescription,
    String? login,
    String? loginFormTitle,
    String? loginUseEmail,
    String? forgotPassword,
    String? notHaveAnAccount,
    String? alreadyHaveAnAccount,
    String? nameHint,
    String? signupEmailHint,
    String? signupPasswordHint,
    String? loginEmailHint,
    String? loginPasswordHint,
    String? confirmPasswordHint,
    String? passwordMatchingError,
    String? dialogButtonText,
    String? chooseLanguageTitle,
    String? agreementText,
    String? privacyPolicyText,
    String? termsConditionsText,
    String? privacyPolicyLink,
    String? termsConditionsLink,
    String? checkboxError,
    LanguageOption? selectedLanguage,
  })  : _welcome = welcome,
        _welcomeDescription = welcomeDescription,
        _signUp = signUp,
        _signUpFormTitle = signUpFormTitle,
        _signUpUseEmail = signUpUseEmail,
        _welcomeBack = welcomeBack,
        _welcomeBackDescription = welcomeBackDescription,
        _login = login,
        _loginFormTitle = loginFormTitle,
        _loginUseEmail = loginUseEmail,
        _forgotPassword = forgotPassword,
        _notHaveAnAccount = notHaveAnAccount,
        _alreadyHaveAnAccount = alreadyHaveAnAccount,
        _nameHint = nameHint,
        _signupEmailHint = signupEmailHint,
        _signupPasswordHint = signupPasswordHint,
        _loginEmailHint = loginEmailHint,
        _loginPasswordHint = loginPasswordHint,
        _confirmPasswordHint = confirmPasswordHint,
        _passwordMatchingError = passwordMatchingError,
        _dialogButtonText = dialogButtonText,
        _chooseLanguageTitle = chooseLanguageTitle,
        _agreementText = agreementText,
        _privacyPolicyText = privacyPolicyText,
        _termsConditionsText = termsConditionsText,
        _privacyPolicyLink = privacyPolicyLink,
        _termsConditionsLink = termsConditionsLink,
        _checkboxError = checkboxError,
        language = selectedLanguage;

  /// Welcome title in signUp mode for the informing part.
  /// Default value is given in [_defaultWelcome].
  /// Custom value in the constructor is assigned to [_welcome].
  String get welcome => _welcome ?? _defaultWelcome;

  /// Welcome description in signUp mode for the informing part.
  /// Default value is given in [_defaultWelcomeDescription].
  /// Custom value in the constructor is assigned to [_welcomeDescription].
  String get welcomeDescription =>
      _welcomeDescription ?? _defaultWelcomeDescription;

  /// Action button text for sign up mode.
  /// Default value is given in [_defaultSignUp].
  /// Custom value in the constructor is assigned to [_signUp].
  String get signUp => _signUp ?? _defaultSignUp;

  /// Form title for sign up mode.
  /// Default value is given in [_defaultSignUpFormTitle].
  /// Custom value in the constructor is assigned to [_signUpFormTitle].
  String get signUpFormTitle => _signUpFormTitle ?? _defaultSignUpFormTitle;

  /// Use email CTA for sign up mode.
  /// Default value is given in [_defaultSignUpUseEmail].
  /// Custom value in the constructor is assigned to [_signUpUseEmail].
  String get signUpUseEmail => _signUpUseEmail ?? _defaultSignUpUseEmail;

  /// Welcome title in login mode for the informing part.
  /// Default value is given in [_defaultWelcomeBack].
  /// Custom value in the constructor is assigned to [_welcomeBack].
  String get welcomeBack => _welcomeBack ?? _defaultWelcomeBack;

  /// Welcome description in login mode for the informing part.
  /// Default value is given in [_defaultWelcomeBackDescription].
  /// Custom value in the constructor is assigned to [_welcomeBackDescription].
  String get welcomeBackDescription =>
      _welcomeBackDescription ?? _defaultWelcomeBackDescription;

  /// Action button text for login mode.
  /// Default value is given in [_defaultLogin].
  /// Custom value in the constructor is assigned to [_login].
  String get login => _login ?? _defaultLogin;

  /// Form title for login mode.
  /// Default value is given in [_defaultLoginFormTitle].
  /// Custom value in the constructor is assigned to [_loginFormTitle].
  String get loginFormTitle => _loginFormTitle ?? _defaultLoginFormTitle;

  /// Use email CTA for login mode.
  /// Default value is given in [_defaultLoginUseEmail].
  /// Custom value in the constructor is assigned to [_loginUseEmail].
  String get loginUseEmail => _loginUseEmail ?? _defaultLoginUseEmail;

  /// Forgot password text for login mode.
  /// Default value is given in [_defaultForgotPassword].
  /// Custom value in the constructor is assigned to [_forgotPassword].
  String get forgotPassword => _forgotPassword ?? _defaultForgotPassword;

  /// Text above the sign up button to direct users who don't have an account.
  /// Default value is given in [_defaultNotHaveAnAccount].
  /// Custom value in the constructor is assigned to [_notHaveAnAccount].
  String get notHaveAnAccount => _notHaveAnAccount ?? _defaultNotHaveAnAccount;

  /// Text above the login button to direct users who already have an account.
  /// Default value is given in [_defaultAlreadyHaveAnAccount].
  /// Custom value in the constructor is assigned to [_alreadyHaveAnAccount].
  String get alreadyHaveAnAccount =>
      _alreadyHaveAnAccount ?? _defaultAlreadyHaveAnAccount;

  /// Hint text for name text form field.
  /// Default value is given in [_defaultNameHint].
  /// Custom value in the constructor is assigned to [_nameHint].
  String get nameHint => _nameHint ?? _defaultNameHint;

  /// Hint text for email text form field.
  /// Default value is given in [_defaultSignupEmailHint].
  /// Custom value in the constructor is assigned to [_signupEmailHint].
  String get signupEmailHint => _signupEmailHint ?? _defaultSignupEmailHint;

  /// Hint text for password text form field.
  /// Default value is given in [_defaultSignupPasswordHint].
  /// Custom value in the constructor is assigned to [_signupPasswordHint].
  String get signupPasswordHint =>
      _signupPasswordHint ?? _defaultSignupPasswordHint;

  /// Hint text for email text form field.
  /// Default value is given in [_defaultLoginEmailHint].
  /// Custom value in the constructor is assigned to [_loginEmailHint].
  String get loginEmailHint => _loginEmailHint ?? _defaultLoginEmailHint;

  /// Hint text for password text form field.
  /// Default value is given in [_defaultLoginPasswordHint].
  /// Custom value in the constructor is assigned to [_loginPasswordHint].
  String get loginPasswordHint =>
      _loginPasswordHint ?? _defaultLoginPasswordHint;

  /// Hint text for confirm password text form field.
  /// Default value is given in [_defaultConfirmPasswordHint].
  /// Custom value in the constructor is assigned to [_confirmPasswordHint].
  String get confirmPasswordHint =>
      _confirmPasswordHint ?? _defaultConfirmPasswordHint;

  /// The error text for not matching password and confirm password inputs.
  /// Default value is given in [_defaultPasswordMatchingError].
  /// Custom value in the constructor is assigned to [_passwordMatchingError].
  String get passwordMatchingError =>
      _passwordMatchingError ?? _defaultPasswordMatchingError;

  /// The button text of error dialog.
  /// Default value is given in [_defaultDialogButtonText].
  /// Custom value in the constructor is assigned to [_dialogButtonText].
  String get dialogButtonText => _dialogButtonText ?? _defaultDialogButtonText;

  /// The title of choose language dialog.
  /// Default value is given in [_defaultChooseLanguageTitle].
  /// Custom value in the constructor is assigned to [_chooseLanguageTitle].
  String get chooseLanguageTitle =>
      _chooseLanguageTitle ?? _defaultChooseLanguageTitle;

  /// The agreement text.
  /// Default value is given in [_defaultAgreementText].
  /// Custom value in the constructor is assigned to [_agreementText].
  String get agreementText => _agreementText ?? _defaultAgreementText;

  /// The privacy policy text.
  /// Default value is given in [_defaultPrivacyPolicyText].
  /// Custom value in the constructor is assigned to [_privacyPolicyText].
  String get privacyPolicyText =>
      _privacyPolicyText ?? _defaultPrivacyPolicyText;

  /// The terms&conditions text.
  /// Default value is given in [_defaultTermsConditionsText].
  /// Custom value in the constructor is assigned to [_termsConditionsText].
  String get termsConditionsText =>
      _termsConditionsText ?? _defaultTermsConditionsText;

  /// The link for the privacy policy website.
  /// Default value is given in [_defaultPrivacyPolicyLink].
  /// Custom value in the constructor is assigned to [_privacyPolicyLink].
  String get privacyPolicyLink =>
      _privacyPolicyLink ?? _defaultPrivacyPolicyLink;

  /// The link for the terms&conditions website.
  /// Default value is given in [_defaultTermsConditionsLink].
  /// Custom value in the constructor is assigned to [_termsConditionsLink].
  String get termsConditionsLink =>
      _termsConditionsLink ?? _defaultTermsConditionsLink;

  /// The error text displayed when the terms are not accepted.
  /// Default value is given in [_defaultCheckboxError].
  /// Custom value in the constructor is assigned to [_checkboxError].
  String get checkboxError => _checkboxError ?? _defaultCheckboxError;

  static const String _defaultWelcome = 'L.O.A.D';
  static const String _defaultWelcomeDescription = 'Load Optimized Algorithm Dive';
  static const String _defaultSignUp = '회원가입';
  static const String _defaultSignUpFormTitle = '회원가입';
  static const String _defaultSignUpUseEmail = '또는 이메일을 사용하여 등록하세요:';
  static const String _defaultNotHaveAnAccount = '계정이 없으신가요?';
  static const String _defaultWelcomeBack = 'L.O.A.D';
  static const String _defaultWelcomeBackDescription = 'Load Optimized Algorithm Dive';
  static const String _defaultLogin = '로그인';
  static const String _defaultLoginFormTitle = '로그인';
  static const String _defaultLoginUseEmail = '또는 이메일 계정을 사용하세요:';
  static const String _defaultForgotPassword = '비밀번호를 잊으셨나요?';
  static const String _defaultAlreadyHaveAnAccount = '이미 계정이 있으신가요?';

  static const String _defaultNameHint = '이름';
  static const String _defaultSignupEmailHint = '이메일';
  static const String _defaultSignupPasswordHint = '비밀번호';
  static const String _defaultLoginEmailHint = '이메일';
  static const String _defaultLoginPasswordHint = '비밀번호';
  static const String _defaultConfirmPasswordHint = '비밀번호 확인';

  static const String _defaultPasswordMatchingError = '입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.';
  static const String _defaultDialogButtonText = '확인';
  static const String _defaultChooseLanguageTitle = '언어 선택';
  static const String _defaultAgreementText = '다음에 동의합니다: ';
  static const String _defaultPrivacyPolicyText = '개인 정보 처리 방침';
  static const String _defaultTermsConditionsText = '이용 약관';
  static const String _defaultPrivacyPolicyLink = 'https://https://github.com/ryuj-h';
  static const String _defaultTermsConditionsLink = 'https://https://github.com/ryuj-h';
  static const String _defaultCheckboxError = '! 개인 정보 처리방침 및 이용 약관에 동의해 주세요 !';

  final String? _welcome;

  /// Hint text of the password [TextField]
  final String? _welcomeDescription;

  /// Hint text of the confirm password [TextField]
  final String? _signUp;

  /// Forgot password button's label
  final String? _signUpFormTitle;

  /// Login button's label
  final String? _signUpUseEmail;

  /// Signup button's label
  final String? _welcomeBack;

  /// Recover password button's label
  final String? _welcomeBackDescription;

  /// Intro in password recovery form
  final String? _login;

  /// Description in password recovery form
  final String? _loginFormTitle;

  /// Go back button's label. Go back button is used to go back to to
  /// login/signup form from the recover password form
  final String? _loginUseEmail;

  /// The error message to show when the confirm password not match with the
  /// original password
  final String? _forgotPassword;

  /// The message to show above the sign up button. Call to action for
  /// directing users who doesn't have an account to the sign up mode.
  final String? _notHaveAnAccount;

  /// The message to show above the login button. Call to action for
  /// directing users who already have an account to the login mode.
  final String? _alreadyHaveAnAccount;

  /// The hint text for name text form field.
  final String? _nameHint;

  /// The hint text for email text form field.
  final String? _signupEmailHint;

  /// The hint text for password text form field.
  final String? _signupPasswordHint;

  /// The hint text for email text form field.
  final String? _loginEmailHint;

  /// The hint text for password text form field.
  final String? _loginPasswordHint;

  /// The hint text for confirm password text form field.
  final String? _confirmPasswordHint;

  /// The error text will be shown when the value of password field
  /// and confirm password field do not match.
  final String? _passwordMatchingError;

  /// The text for button in the error dialog.
  final String? _dialogButtonText;

  /// The title for choose language dialog.
  final String? _chooseLanguageTitle;

  /// Text for the agreement text.
  final String? _agreementText;

  /// Text for the privacy policy checkbox.
  final String? _privacyPolicyText;

  /// Text for the terms and conditions checkbox.
  final String? _termsConditionsText;

  /// Link of the corresponding privacy policy.
  final String? _privacyPolicyLink;

  /// Link of the corresponding privacy policy.
  final String? _termsConditionsLink;

  final String? _checkboxError;

  /// Currently selected language.
  LanguageOption? language;

  /// Sets the language
  void setLanguage(LanguageOption newLanguage) {
    if (newLanguage != language) {
      language = newLanguage;
      notifyListeners();
    }
  }
}
