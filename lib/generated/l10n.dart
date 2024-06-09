// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `عربي`
  String get lagn {
    return Intl.message(
      'عربي',
      name: 'lagn',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Page`
  String get SignUpPage {
    return Intl.message(
      'Sign Up Page',
      name: 'SignUpPage',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get yournamesu {
    return Intl.message(
      'Your name',
      name: 'yournamesu',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `your name must be 4 charachters at least`
  String get shortName {
    return Intl.message(
      'your name must be 4 charachters at least',
      name: 'shortName',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email must contain @`
  String get emailError {
    return Intl.message(
      'Email must contain @',
      name: 'emailError',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get pass {
    return Intl.message(
      'password',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `enter password that at least 5 charachters`
  String get plspass {
    return Intl.message(
      'enter password that at least 5 charachters',
      name: 'plspass',
      desc: '',
      args: [],
    );
  }

  /// `confirmed password`
  String get confirmPass {
    return Intl.message(
      'confirmed password',
      name: 'confirmPass',
      desc: '',
      args: [],
    );
  }

  /// `please confirm your password`
  String get doublecheckpass {
    return Intl.message(
      'please confirm your password',
      name: 'doublecheckpass',
      desc: '',
      args: [],
    );
  }

  /// `passwords doesn't match`
  String get doesmatch {
    return Intl.message(
      'passwords doesn\'t match',
      name: 'doesmatch',
      desc: '',
      args: [],
    );
  }

  /// `weak Password`
  String get weakPass {
    return Intl.message(
      'weak Password',
      name: 'weakPass',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get alreadyInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'alreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `something went wrong, please try again`
  String get error {
    return Intl.message(
      'something went wrong, please try again',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get suc {
    return Intl.message(
      'success',
      name: 'suc',
      desc: '',
      args: [],
    );
  }

  /// `please check your password or email`
  String get error2 {
    return Intl.message(
      'please check your password or email',
      name: 'error2',
      desc: '',
      args: [],
    );
  }

  /// `Sign In Page`
  String get SignInPage {
    return Intl.message(
      'Sign In Page',
      name: 'SignInPage',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want to exit`
  String get ays {
    return Intl.message(
      'are you sure you want to exit',
      name: 'ays',
      desc: '',
      args: [],
    );
  }

  /// `you want to leave `
  String get wtl {
    return Intl.message(
      'you want to leave ',
      name: 'wtl',
      desc: '',
      args: [],
    );
  }

  /// `Pharma Tails`
  String get pharmaTails {
    return Intl.message(
      'Pharma Tails',
      name: 'pharmaTails',
      desc: '',
      args: [],
    );
  }

  /// `Never mind`
  String get nvm {
    return Intl.message(
      'Never mind',
      name: 'nvm',
      desc: '',
      args: [],
    );
  }

  /// `leave`
  String get leave {
    return Intl.message(
      'leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Search For Your Drug`
  String get searchDrug {
    return Intl.message(
      'Search For Your Drug',
      name: 'searchDrug',
      desc: '',
      args: [],
    );
  }

  /// `Nearest Pharmacies`
  String get nearPharma {
    return Intl.message(
      'Nearest Pharmacies',
      name: 'nearPharma',
      desc: '',
      args: [],
    );
  }

  /// ` Alarm For Drug Doses`
  String get alarm {
    return Intl.message(
      ' Alarm For Drug Doses',
      name: 'alarm',
      desc: '',
      args: [],
    );
  }

  /// ` Records`
  String get records {
    return Intl.message(
      ' Records',
      name: 'records',
      desc: '',
      args: [],
    );
  }

  /// `Search For Drug Via Voice or Text`
  String get textSearch {
    return Intl.message(
      'Search For Drug Via Voice or Text',
      name: 'textSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search By Name Using Camera`
  String get cameraSearch {
    return Intl.message(
      'Search By Name Using Camera',
      name: 'cameraSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search By Barcode Using Camera`
  String get barcodeSearch {
    return Intl.message(
      'Search By Barcode Using Camera',
      name: 'barcodeSearch',
      desc: '',
      args: [],
    );
  }

  /// `Enter Drug Name:`
  String get searchInput {
    return Intl.message(
      'Enter Drug Name:',
      name: 'searchInput',
      desc: '',
      args: [],
    );
  }

  /// `hold the button and start speaking`
  String get searchVoice {
    return Intl.message(
      'hold the button and start speaking',
      name: 'searchVoice',
      desc: '',
      args: [],
    );
  }

  /// `* if you don't see the suggetions\n please tap on the text form`
  String get plspress {
    return Intl.message(
      '* if you don\'t see the suggetions\n please tap on the text form',
      name: 'plspress',
      desc: '',
      args: [],
    );
  }

  /// `take photo of the drug package`
  String get titleCamera {
    return Intl.message(
      'take photo of the drug package',
      name: 'titleCamera',
      desc: '',
      args: [],
    );
  }

  /// `discover the drug`
  String get checkPhoto {
    return Intl.message(
      'discover the drug',
      name: 'checkPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission is denied`
  String get cameraPermission {
    return Intl.message(
      'Camera permission is denied',
      name: 'cameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `an error occured when scanning the text`
  String get camraError {
    return Intl.message(
      'an error occured when scanning the text',
      name: 'camraError',
      desc: '',
      args: [],
    );
  }

  /// ` Open Scanner`
  String get openScanner {
    return Intl.message(
      ' Open Scanner',
      name: 'openScanner',
      desc: '',
      args: [],
    );
  }

  /// `No Bar Code Were Found, Please Try Again.`
  String get NobarCode {
    return Intl.message(
      'No Bar Code Were Found, Please Try Again.',
      name: 'NobarCode',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get Result {
    return Intl.message(
      'Result',
      name: 'Result',
      desc: '',
      args: [],
    );
  }

  /// `uses:`
  String get uses {
    return Intl.message(
      'uses:',
      name: 'uses',
      desc: '',
      args: [],
    );
  }

  /// `SideEffects`
  String get SideEffects {
    return Intl.message(
      'SideEffects',
      name: 'SideEffects',
      desc: '',
      args: [],
    );
  }

  /// `Jordanian public price`
  String get jor_price {
    return Intl.message(
      'Jordanian public price',
      name: 'jor_price',
      desc: '',
      args: [],
    );
  }

  /// `Hospital price`
  String get hos_price {
    return Intl.message(
      'Hospital price',
      name: 'hos_price',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacist price`
  String get ph_price {
    return Intl.message(
      'Pharmacist price',
      name: 'ph_price',
      desc: '',
      args: [],
    );
  }

  /// `Packing`
  String get packing {
    return Intl.message(
      'Packing',
      name: 'packing',
      desc: '',
      args: [],
    );
  }

  /// `Generic Name`
  String get generic_name {
    return Intl.message(
      'Generic Name',
      name: 'generic_name',
      desc: '',
      args: [],
    );
  }

  /// `Bar Code`
  String get barcoden {
    return Intl.message(
      'Bar Code',
      name: 'barcoden',
      desc: '',
      args: [],
    );
  }

  /// `please enter the drug name `
  String get alarmMissingValue {
    return Intl.message(
      'please enter the drug name ',
      name: 'alarmMissingValue',
      desc: '',
      args: [],
    );
  }

  /// `please enter the pills number `
  String get alarmMissingValue2 {
    return Intl.message(
      'please enter the pills number ',
      name: 'alarmMissingValue2',
      desc: '',
      args: [],
    );
  }

  /// `please enter the daily dose `
  String get alarmMissingValue3 {
    return Intl.message(
      'please enter the daily dose ',
      name: 'alarmMissingValue3',
      desc: '',
      args: [],
    );
  }

  /// `your Drug`
  String get alarmName {
    return Intl.message(
      'your Drug',
      name: 'alarmName',
      desc: '',
      args: [],
    );
  }

  /// `Drug Name`
  String get alarmName2 {
    return Intl.message(
      'Drug Name',
      name: 'alarmName2',
      desc: '',
      args: [],
    );
  }

  /// `No alarm(s) is set yet`
  String get alarmEmpty {
    return Intl.message(
      'No alarm(s) is set yet',
      name: 'alarmEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add your drug`
  String get alarmAddbutton {
    return Intl.message(
      'Add your drug',
      name: 'alarmAddbutton',
      desc: '',
      args: [],
    );
  }

  /// `Pills Left!`
  String get alarmPillsLeft {
    return Intl.message(
      'Pills Left!',
      name: 'alarmPillsLeft',
      desc: '',
      args: [],
    );
  }

  /// `have no available price!`
  String get noPrice {
    return Intl.message(
      'have no available price!',
      name: 'noPrice',
      desc: '',
      args: [],
    );
  }

  /// `Packing`
  String get alarmPacking {
    return Intl.message(
      'Packing',
      name: 'alarmPacking',
      desc: '',
      args: [],
    );
  }

  /// `Number Of pills`
  String get alarmPacking2 {
    return Intl.message(
      'Number Of pills',
      name: 'alarmPacking2',
      desc: '',
      args: [],
    );
  }

  /// ` dayly Dose`
  String get alarmDose {
    return Intl.message(
      ' dayly Dose',
      name: 'alarmDose',
      desc: '',
      args: [],
    );
  }

  /// `Dose`
  String get alarmDose1 {
    return Intl.message(
      'Dose',
      name: 'alarmDose1',
      desc: '',
      args: [],
    );
  }

  /// `Way of taking the medication`
  String get alarmText {
    return Intl.message(
      'Way of taking the medication',
      name: 'alarmText',
      desc: '',
      args: [],
    );
  }

  /// `Pills`
  String get alarmPills {
    return Intl.message(
      'Pills',
      name: 'alarmPills',
      desc: '',
      args: [],
    );
  }

  /// `Syrup`
  String get alarmSyrup {
    return Intl.message(
      'Syrup',
      name: 'alarmSyrup',
      desc: '',
      args: [],
    );
  }

  /// `Drops`
  String get alarmDrops {
    return Intl.message(
      'Drops',
      name: 'alarmDrops',
      desc: '',
      args: [],
    );
  }

  /// `set Alarm`
  String get alarmSave {
    return Intl.message(
      'set Alarm',
      name: 'alarmSave',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get alarmCancel {
    return Intl.message(
      'Cancel',
      name: 'alarmCancel',
      desc: '',
      args: [],
    );
  }

  /// ` Something went wrong`
  String get errorText {
    return Intl.message(
      ' Something went wrong',
      name: 'errorText',
      desc: '',
      args: [],
    );
  }

  /// ` Loading...`
  String get Loading {
    return Intl.message(
      ' Loading...',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `Your Record Type`
  String get recordsText {
    return Intl.message(
      'Your Record Type',
      name: 'recordsText',
      desc: '',
      args: [],
    );
  }

  /// `Diabetes`
  String get recordsDiabetes {
    return Intl.message(
      'Diabetes',
      name: 'recordsDiabetes',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get recordsPressure {
    return Intl.message(
      'Pressure',
      name: 'recordsPressure',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get recordsSave {
    return Intl.message(
      'Save',
      name: 'recordsSave',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get recordscancel {
    return Intl.message(
      'Cancel',
      name: 'recordscancel',
      desc: '',
      args: [],
    );
  }

  /// `No records is set yet`
  String get Noyet {
    return Intl.message(
      'No records is set yet',
      name: 'Noyet',
      desc: '',
      args: [],
    );
  }

  /// `date:`
  String get sche {
    return Intl.message(
      'date:',
      name: 'sche',
      desc: '',
      args: [],
    );
  }

  /// `Open Now`
  String get pharmaOpen {
    return Intl.message(
      'Open Now',
      name: 'pharmaOpen',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get pharmaClosed {
    return Intl.message(
      'Closed',
      name: 'pharmaClosed',
      desc: '',
      args: [],
    );
  }

  /// `Loading Locations...`
  String get loading {
    return Intl.message(
      'Loading Locations...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `No pharmacies located with`
  String get nopharma {
    return Intl.message(
      'No pharmacies located with',
      name: 'nopharma',
      desc: '',
      args: [],
    );
  }

  /// ` Return`
  String get Return {
    return Intl.message(
      ' Return',
      name: 'Return',
      desc: '',
      args: [],
    );
  }

  /// `Your location`
  String get yourLcoation {
    return Intl.message(
      'Your location',
      name: 'yourLcoation',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection for better usage to directions and location information.`
  String get checkInt {
    return Intl.message(
      'Check your internet connection for better usage to directions and location information.',
      name: 'checkInt',
      desc: '',
      args: [],
    );
  }

  /// `Connect to Maps...`
  String get connect {
    return Intl.message(
      'Connect to Maps...',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Location Service Disabled.`
  String get locationServ {
    return Intl.message(
      'Location Service Disabled.',
      name: 'locationServ',
      desc: '',
      args: [],
    );
  }

  /// `Location Access Denied.`
  String get locationden {
    return Intl.message(
      'Location Access Denied.',
      name: 'locationden',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection, Check your internet connection. `
  String get nointcon {
    return Intl.message(
      'No Internet Connection, Check your internet connection. ',
      name: 'nointcon',
      desc: '',
      args: [],
    );
  }

  /// `alternatives`
  String get alter {
    return Intl.message(
      'alternatives',
      name: 'alter',
      desc: '',
      args: [],
    );
  }

  /// `quantity per dose`
  String get pillsPerDose {
    return Intl.message(
      'quantity per dose',
      name: 'pillsPerDose',
      desc: '',
      args: [],
    );
  }

  /// `Example: 2 pills or 50 mg in numbers only `
  String get pillsPerDoseH {
    return Intl.message(
      'Example: 2 pills or 50 mg in numbers only ',
      name: 'pillsPerDoseH',
      desc: '',
      args: [],
    );
  }

  /// `Time to take your medicine`
  String get remind {
    return Intl.message(
      'Time to take your medicine',
      name: 'remind',
      desc: '',
      args: [],
    );
  }

  /// `don't forget your medicine`
  String get remind2 {
    return Intl.message(
      'don\'t forget your medicine',
      name: 'remind2',
      desc: '',
      args: [],
    );
  }

  /// `I took it`
  String get Done {
    return Intl.message(
      'I took it',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// ` snooze for 5 mins`
  String get snooze {
    return Intl.message(
      ' snooze for 5 mins',
      name: 'snooze',
      desc: '',
      args: [],
    );
  }

  /// ` please Enter the record`
  String get pleaseenter {
    return Intl.message(
      ' please Enter the record',
      name: 'pleaseenter',
      desc: '',
      args: [],
    );
  }

  /// `enter your record `
  String get hintR {
    return Intl.message(
      'enter your record ',
      name: 'hintR',
      desc: '',
      args: [],
    );
  }

  /// `Water Reminder`
  String get waterR {
    return Intl.message(
      'Water Reminder',
      name: 'waterR',
      desc: '',
      args: [],
    );
  }

  /// `don't forget to drink some water`
  String get waterTitle {
    return Intl.message(
      'don\'t forget to drink some water',
      name: 'waterTitle',
      desc: '',
      args: [],
    );
  }

  /// `water Reminder has been set`
  String get waterSet {
    return Intl.message(
      'water Reminder has been set',
      name: 'waterSet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
