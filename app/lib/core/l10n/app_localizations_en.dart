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
  String devCodeHint(String code) {
    return 'Test mode — code: $code';
  }

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

  @override
  String get savedMessages => 'Saved Messages';

  @override
  String get deletedAccount => 'Deleted Account';

  @override
  String get newChat => 'New chat';

  @override
  String get searchHint => 'Search by @username or phone number';

  @override
  String get noResults => 'No results';

  @override
  String get notOnWasla => 'This number isn\'t on Wasla';

  @override
  String get contactsSection => 'Contacts';

  @override
  String get globalSection => 'Global results';

  @override
  String get noChatsYet => 'No chats yet. Start a new chat.';

  @override
  String get loadError => 'Couldn\'t load chats';

  @override
  String get messageHint => 'Message';

  @override
  String get typing => 'typing…';

  @override
  String get edited => 'edited';

  @override
  String forwardedFrom(String name) {
    return 'Forwarded from $name';
  }

  @override
  String get locationMsg => '📍 Location';

  @override
  String get contactMsg => '👤 Contact';

  @override
  String get unsupportedMsg =>
      'This message isn\'t supported, please update the app';

  @override
  String get you => 'You';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get reply => 'Reply';

  @override
  String get copy => 'Copy';

  @override
  String get edit => 'Edit';

  @override
  String get forward => 'Forward';

  @override
  String get forwardToSaved => 'To Saved Messages';

  @override
  String get chooseChat => 'Choose a chat';

  @override
  String get pin => 'Pin';

  @override
  String get unpin => 'Unpin';

  @override
  String get delete => 'Delete';

  @override
  String get deleteForMe => 'Delete for me';

  @override
  String get deleteForEveryone => 'Delete for everyone';

  @override
  String get report => 'Report';

  @override
  String get block => 'Block';

  @override
  String get unblock => 'Unblock';

  @override
  String blockConfirm(String name) {
    return 'Block $name? Neither of you will be able to message the other.';
  }

  @override
  String get youBlocked => 'You blocked this user';

  @override
  String get copied => 'Copied';

  @override
  String get sendFailed => 'Not sent — tap to retry';

  @override
  String get retry => 'Retry';

  @override
  String get discard => 'Delete';

  @override
  String get editing => 'Editing message';

  @override
  String replyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get pinChat => 'Pin chat';

  @override
  String get unpinChat => 'Unpin chat';

  @override
  String get mute => 'Mute';

  @override
  String get unmute => 'Unmute';

  @override
  String get archive => 'Archive';

  @override
  String get unarchive => 'Unarchive';

  @override
  String get archived => 'Archived';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get reportTitle => 'Report';

  @override
  String get reportWhy => 'What\'s the problem?';

  @override
  String get reportComment => 'More details (optional)';

  @override
  String get reportAlsoBlock => 'Also block this user';

  @override
  String get reportSend => 'Send report';

  @override
  String get reportSent => 'Thanks — our moderators will review your report.';

  @override
  String get reasonSpam => 'Spam';

  @override
  String get reasonScam => 'Scam';

  @override
  String get reasonViolence => 'Violence';

  @override
  String get reasonTerrorism => 'Terrorism';

  @override
  String get reasonChildAbuse => 'Child abuse';

  @override
  String get reasonPornography => 'Pornography';

  @override
  String get reasonIllegalGoods => 'Illegal goods';

  @override
  String get reasonPersonalData => 'Personal data';

  @override
  String get reasonHarassment => 'Harassment';

  @override
  String get reasonFakeAccount => 'Fake account';

  @override
  String get reasonCopyright => 'Copyright';

  @override
  String get reasonOther => 'Other';

  @override
  String errRateLimitedMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutes',
      one: '1 minute',
    );
    return 'Too many attempts. Try again in $_temp0';
  }

  @override
  String get photoMsg => '📷 Photo';

  @override
  String fileMsg(String name) {
    return '📎 $name';
  }

  @override
  String get attach => 'Attach';

  @override
  String get attachGallery => 'Photo from gallery';

  @override
  String get attachCamera => 'Take a photo';

  @override
  String get attachFile => 'File';

  @override
  String get captionHint => 'Add a caption…';

  @override
  String get sendPhoto => 'Send photo';

  @override
  String get sendFile => 'Send file';

  @override
  String get myPhoto => 'My profile photo';

  @override
  String get photoUpdated => 'Your photo was updated';

  @override
  String get openFailed => 'No app on your phone can open this file';

  @override
  String sizeKb(String n) {
    return '$n KB';
  }

  @override
  String sizeMb(String n) {
    return '$n MB';
  }

  @override
  String get mediaUnavailable => 'This photo is no longer available';

  @override
  String get photoTooBig => 'The file is too large';

  @override
  String get storageTitle => 'Data and storage';

  @override
  String get storageUsage => 'Downloaded media on your phone';

  @override
  String storageUsageValue(int files, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      files,
      locale: localeName,
      other: '$files files',
      one: '1 file',
      zero: 'Nothing',
    );
    return '$_temp0 · $size';
  }

  @override
  String get keepMedia => 'Keep downloaded media';

  @override
  String get keepMediaHint =>
      'Downloaded photos and files are removed from your phone after this long since you last opened them. They stay in the chat and download again when opened.';

  @override
  String get keepDays3 => '3 days';

  @override
  String get keepDays7 => '1 week';

  @override
  String get keepDays30 => '30 days (default)';

  @override
  String get keepForever => 'Forever';

  @override
  String get clearMedia => 'Clear downloaded media';

  @override
  String get clearMediaConfirm =>
      'Delete all downloaded photos and files from this phone? They stay in your chats and can be downloaded again.';

  @override
  String clearMediaDone(String size) {
    return 'Freed $size';
  }

  @override
  String get clear => 'Clear';
}
