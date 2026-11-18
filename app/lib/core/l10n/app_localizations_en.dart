// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Wasla';

  @override
  String get connecting => 'Connecting…';

  @override
  String get continueButton => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get phoneTitle => 'Your phone number';

  @override
  String get phoneSubtitle => 'We will text you a verification code.';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String get codeTitle => 'Enter the code';

  @override
  String codeSentSms(int length, String phone) {
    return 'We sent a $length-digit code to $phone';
  }

  @override
  String codeSentVoice(String phone) {
    return 'We will call $phone and read the code to you.';
  }

  @override
  String get codeLabel => 'Verification code';

  @override
  String resendIn(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds seconds',
      one: '1 second',
    );
    return 'Resend in $_temp0';
  }

  @override
  String get resendByCall => 'Call me with the code';

  @override
  String get wrongNumber => 'Change number';

  @override
  String get passwordTitle => 'Two-step verification';

  @override
  String get passwordSubtitle =>
      'Your account is protected with an extra password.';

  @override
  String get passwordLabel => 'Password';

  @override
  String passwordHint(String hint) {
    return 'Hint: $hint';
  }

  @override
  String get signUpTitle => 'Your info';

  @override
  String get signUpSubtitle => 'Enter your name so your friends recognise you.';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name (optional)';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get acceptTerms => 'I accept the Terms of Service and Privacy Policy';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatsEmpty =>
      'Your account is ready! Chats arrive in the next update.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get activeSessions => 'Active devices';

  @override
  String get thisDevice => 'This device';

  @override
  String get endSession => 'End session';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Log out of this device?';

  @override
  String get language => 'Language';

  @override
  String get errPhoneInvalid => 'Invalid phone number';

  @override
  String get errCodeInvalid => 'Wrong code';

  @override
  String get errCodeExpired => 'The code expired, request a new one';

  @override
  String get errPhoneBanned => 'This number is banned from Wasla';

  @override
  String get errPasswordInvalid => 'Wrong password';

  @override
  String errRateLimited(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds seconds',
      one: '1 second',
    );
    return 'Too many attempts. Try again in $_temp0';
  }

  @override
  String get errNetwork => 'No connection. Check your internet and try again';

  @override
  String get errUpdateRequired =>
      'A newer version of Wasla is available. Please update.';

  @override
  String get errGeneric => 'Something went wrong. Try again';
}
