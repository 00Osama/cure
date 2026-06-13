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

  /// `Egypt's First Healthcare Intermediary`
  String get splashSlide1Title {
    return Intl.message(
      'Egypt\'s First Healthcare Intermediary',
      name: 'splashSlide1Title',
      desc: '',
      args: [],
    );
  }

  /// `Egypt's first intermediary`
  String get splashSlide1Line1 {
    return Intl.message(
      'Egypt\'s first intermediary',
      name: 'splashSlide1Line1',
      desc: '',
      args: [],
    );
  }

  /// `between nurse and patient`
  String get splashSlide1Line2 {
    return Intl.message(
      'between nurse and patient',
      name: 'splashSlide1Line2',
      desc: '',
      args: [],
    );
  }

  /// `in Egypt`
  String get splashSlide1Line3 {
    return Intl.message(
      'in Egypt',
      name: 'splashSlide1Line3',
      desc: '',
      args: [],
    );
  }

  /// `Connecting Nurses and Patients`
  String get splashSlide1Subtitle {
    return Intl.message(
      'Connecting Nurses and Patients',
      name: 'splashSlide1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare is Everyone's Right`
  String get splashSlide2Title {
    return Intl.message(
      'Healthcare is Everyone\'s Right',
      name: 'splashSlide2Title',
      desc: '',
      args: [],
    );
  }

  /// `CURE is a smart platform that connects patients with home nursing service providers in a safe, fast, and organized manner, aimed at facilitating access to high-quality home healthcare at a fair price.`
  String get splashSlide2Subtitle {
    return Intl.message(
      'CURE is a smart platform that connects patients with home nursing service providers in a safe, fast, and organized manner, aimed at facilitating access to high-quality home healthcare at a fair price.',
      name: 'splashSlide2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Daily Struggles in Fayoum`
  String get splashSlide3Title {
    return Intl.message(
      'Daily Struggles in Fayoum',
      name: 'splashSlide3Title',
      desc: '',
      args: [],
    );
  }

  /// `Patients suffer in silence`
  String get splashSlide3Subtitle {
    return Intl.message(
      'Patients suffer in silence',
      name: 'splashSlide3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Hours of Waiting`
  String get waitingHours {
    return Intl.message(
      'Hours of Waiting',
      name: 'waitingHours',
      desc: '',
      args: [],
    );
  }

  /// `Patients wait 2-6 hours for a nurse who might not come at all`
  String get waitingDesc {
    return Intl.message(
      'Patients wait 2-6 hours for a nurse who might not come at all',
      name: 'waitingDesc',
      desc: '',
      args: [],
    );
  }

  /// `73% of patients suffered from long waiting times`
  String get waitingPercent {
    return Intl.message(
      '73% of patients suffered from long waiting times',
      name: 'waitingPercent',
      desc: '',
      args: [],
    );
  }

  /// `Price Manipulation`
  String get priceManipulation {
    return Intl.message(
      'Price Manipulation',
      name: 'priceManipulation',
      desc: '',
      args: [],
    );
  }

  /// `Same service costs 50 pounds in one street, 500 in the next — for no reason`
  String get priceDesc {
    return Intl.message(
      'Same service costs 50 pounds in one street, 500 in the next — for no reason',
      name: 'priceDesc',
      desc: '',
      args: [],
    );
  }

  /// `68% paid unfair prices`
  String get unfairPrice {
    return Intl.message(
      '68% paid unfair prices',
      name: 'unfairPrice',
      desc: '',
      args: [],
    );
  }

  /// `No Guarantee or Verification`
  String get noVerification {
    return Intl.message(
      'No Guarantee or Verification',
      name: 'noVerification',
      desc: '',
      args: [],
    );
  }

  /// `No way to verify a nurse's qualifications or professional background`
  String get noVerificationDesc {
    return Intl.message(
      'No way to verify a nurse\'s qualifications or professional background',
      name: 'noVerificationDesc',
      desc: '',
      args: [],
    );
  }

  /// `81% felt unsafe`
  String get unsafeFeel {
    return Intl.message(
      '81% felt unsafe',
      name: 'unsafeFeel',
      desc: '',
      args: [],
    );
  }

  /// `No Unified System`
  String get noSystem {
    return Intl.message(
      'No Unified System',
      name: 'noSystem',
      desc: '',
      args: [],
    );
  }

  /// `Booking done through unofficial WhatsApp groups and personal connections — no organized platform`
  String get noSystemDesc {
    return Intl.message(
      'Booking done through unofficial WhatsApp groups and personal connections — no organized platform',
      name: 'noSystemDesc',
      desc: '',
      args: [],
    );
  }

  /// `100% — No app in Fayoum`
  String get noApp {
    return Intl.message(
      '100% — No app in Fayoum',
      name: 'noApp',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare at Your Doorstep in 15 Minutes`
  String get splashSlide4Title {
    return Intl.message(
      'Healthcare at Your Doorstep in 15 Minutes',
      name: 'splashSlide4Title',
      desc: '',
      args: [],
    );
  }

  /// `A platform connecting patients with certified nurses through a smart system ensuring speed, safety, and complete transparency`
  String get splashSlide4Subtitle {
    return Intl.message(
      'A platform connecting patients with certified nurses through a smart system ensuring speed, safety, and complete transparency',
      name: 'splashSlide4Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Our Services`
  String get splashSlide5Title {
    return Intl.message(
      'Our Services',
      name: 'splashSlide5Title',
      desc: '',
      args: [],
    );
  }

  /// `Comprehensive Medical Coverage for All Your Needs`
  String get splashSlide5Subtitle {
    return Intl.message(
      'Comprehensive Medical Coverage for All Your Needs',
      name: 'splashSlide5Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `We provide a wide range of home nursing services tailored to all cases`
  String get servicesIntro {
    return Intl.message(
      'We provide a wide range of home nursing services tailored to all cases',
      name: 'servicesIntro',
      desc: '',
      args: [],
    );
  }

  /// `📋 Basic Care`
  String get basicCareTitle {
    return Intl.message(
      '📋 Basic Care',
      name: 'basicCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `💉 Giving injections (IM / SC / IV)\n🩸 Random and cumulative blood sugar measurement\n❤️ Blood pressure measurement\n🌡️ Temperature measurement\n📊 Measuring vital signs (Pulse – O2 – R)\n💊 Administering medications on schedule\n🧪 IV Cannula insertion\n💧 Setting up intravenous fluids\n🧴 Monitoring dehydration and fluid replacement`
  String get basicCareItems {
    return Intl.message(
      '💉 Giving injections (IM / SC / IV)\n🩸 Random and cumulative blood sugar measurement\n❤️ Blood pressure measurement\n🌡️ Temperature measurement\n📊 Measuring vital signs (Pulse – O2 – R)\n💊 Administering medications on schedule\n🧪 IV Cannula insertion\n💧 Setting up intravenous fluids\n🧴 Monitoring dehydration and fluid replacement',
      name: 'basicCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🩹 Wound and Skin Care`
  String get woundCareTitle {
    return Intl.message(
      '🩹 Wound and Skin Care',
      name: 'woundCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🩹 Dressing simple and deep wounds\n🧬 Cleaning and sterilizing wounds\n🦶 Diabetic foot dressing\n🧴 Treating bed sores\n🪡 Monitoring post-operative wounds\n🧷 Simple suture removal`
  String get woundCareItems {
    return Intl.message(
      '🩹 Dressing simple and deep wounds\n🧬 Cleaning and sterilizing wounds\n🦶 Diabetic foot dressing\n🧴 Treating bed sores\n🪡 Monitoring post-operative wounds\n🧷 Simple suture removal',
      name: 'woundCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🧓 Elderly Care`
  String get elderlyCareTitle {
    return Intl.message(
      '🧓 Elderly Care',
      name: 'elderlyCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🛏️ Complete care for bedridden patients\n🚿 Bathing and cleaning unable patients\n🔄 Changing patient position to prevent sores\n🍽️ Assistance with nutrition\n🚻 Assistance with toilet needs\n🧠 Monitoring mental state and consciousness\n💊 Organizing daily medications`
  String get elderlyCareItems {
    return Intl.message(
      '🛏️ Complete care for bedridden patients\n🚿 Bathing and cleaning unable patients\n🔄 Changing patient position to prevent sores\n🍽️ Assistance with nutrition\n🚻 Assistance with toilet needs\n🧠 Monitoring mental state and consciousness\n💊 Organizing daily medications',
      name: 'elderlyCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🫀 Chronic Diseases Care`
  String get chronicCareTitle {
    return Intl.message(
      '🫀 Chronic Diseases Care',
      name: 'chronicCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🫀 Monitoring heart disease patients\n🩸 Monitoring diabetes patients\n🧠 Monitoring high blood pressure\n🫁 Monitoring asthma and breathing difficulty patients\n📅 Preparing periodic follow-up plan\n📊 Recording and analyzing daily readings`
  String get chronicCareItems {
    return Intl.message(
      '🫀 Monitoring heart disease patients\n🩸 Monitoring diabetes patients\n🧠 Monitoring high blood pressure\n🫁 Monitoring asthma and breathing difficulty patients\n📅 Preparing periodic follow-up plan\n📊 Recording and analyzing daily readings',
      name: 'chronicCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🚑 Post-Operative Care`
  String get postOpCareTitle {
    return Intl.message(
      '🚑 Post-Operative Care',
      name: 'postOpCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🏥 Post-operative surgical monitoring\n🩹 Changing surgical bandages\n💉 Administering post-operative antibiotics\n🧼 Cleaning surgical wounds\n📉 Monitoring infections or complications\n🛏️ Helping patient gradual movement`
  String get postOpCareItems {
    return Intl.message(
      '🏥 Post-operative surgical monitoring\n🩹 Changing surgical bandages\n💉 Administering post-operative antibiotics\n🧼 Cleaning surgical wounds\n📉 Monitoring infections or complications\n🛏️ Helping patient gradual movement',
      name: 'postOpCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🫁 Home Respiratory Care`
  String get respiratoryCareTitle {
    return Intl.message(
      '🫁 Home Respiratory Care',
      name: 'respiratoryCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `💨 Nebulizer sessions (steam)\n🫁 Suctioning phlegm\n😮‍💨 Monitoring home oxygen\n🧴 Teaching use of respiratory devices\n📊 Monitoring asthma cases`
  String get respiratoryCareItems {
    return Intl.message(
      '💨 Nebulizer sessions (steam)\n🫁 Suctioning phlegm\n😮‍💨 Monitoring home oxygen\n🧴 Teaching use of respiratory devices\n📊 Monitoring asthma cases',
      name: 'respiratoryCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🚿 Catheter and Special Procedures`
  String get catheterCareTitle {
    return Intl.message(
      '🚿 Catheter and Special Procedures',
      name: 'catheterCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🚿 Urinary catheter insertion\n🧼 Changing and monitoring catheter\n💧 Care for catheterized patient\n🧪 Monitoring urine and catheter complications`
  String get catheterCareItems {
    return Intl.message(
      '🚿 Urinary catheter insertion\n🧼 Changing and monitoring catheter\n💧 Care for catheterized patient\n🧪 Monitoring urine and catheter complications',
      name: 'catheterCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🧠 Psychological and Rehabilitation Support`
  String get psychologicalCareTitle {
    return Intl.message(
      '🧠 Psychological and Rehabilitation Support',
      name: 'psychologicalCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🧠 Basic psychological support for patient\n👨‍👩‍👧 Family support in dealing with condition\n🧘 Simple rehabilitation exercises at home\n🦵 Light physical therapy (Mobility)\n🪑 Training patient on movement`
  String get psychologicalCareItems {
    return Intl.message(
      '🧠 Basic psychological support for patient\n👨‍👩‍👧 Family support in dealing with condition\n🧘 Simple rehabilitation exercises at home\n🦵 Light physical therapy (Mobility)\n🪑 Training patient on movement',
      name: 'psychologicalCareItems',
      desc: '',
      args: [],
    );
  }

  /// `🚨 Emergency and Rapid Assessment Services`
  String get emergencyCareTitle {
    return Intl.message(
      '🚨 Emergency and Rapid Assessment Services',
      name: 'emergencyCareTitle',
      desc: '',
      args: [],
    );
  }

  /// `🚨 Emergency case assessment at home\n📉 Rapid health status measurement\n🏥 Preparing patient for hospital transfer\n📞 Urgent nursing consultation`
  String get emergencyCareItems {
    return Intl.message(
      '🚨 Emergency case assessment at home\n📉 Rapid health status measurement\n🏥 Preparing patient for hospital transfer\n📞 Urgent nursing consultation',
      name: 'emergencyCareItems',
      desc: '',
      args: [],
    );
  }

  /// `How It Works`
  String get howItWorks {
    return Intl.message(
      'How It Works',
      name: 'howItWorks',
      desc: '',
      args: [],
    );
  }

  /// `3 Steps Only for Home Care`
  String get threeSteps {
    return Intl.message(
      '3 Steps Only for Home Care',
      name: 'threeSteps',
      desc: '',
      args: [],
    );
  }

  /// `For Patient`
  String get forPatient {
    return Intl.message(
      'For Patient',
      name: 'forPatient',
      desc: '',
      args: [],
    );
  }

  /// `Choose Service`
  String get step1Title {
    return Intl.message(
      'Choose Service',
      name: 'step1Title',
      desc: '',
      args: [],
    );
  }

  /// `Browse the list of 15 home medical services with fixed announced prices. No negotiation, what you see is what you pay.`
  String get step1Desc {
    return Intl.message(
      'Browse the list of 15 home medical services with fixed announced prices. No negotiation, what you see is what you pay.',
      name: 'step1Desc',
      desc: '',
      args: [],
    );
  }

  /// `Set Location and Time`
  String get step2Title {
    return Intl.message(
      'Set Location and Time',
      name: 'step2Title',
      desc: '',
      args: [],
    );
  }

  /// `Use GPS to automatically identify your address or enter it manually, then choose the time that suits you.`
  String get step2Desc {
    return Intl.message(
      'Use GPS to automatically identify your address or enter it manually, then choose the time that suits you.',
      name: 'step2Desc',
      desc: '',
      args: [],
    );
  }

  /// `Receive Nurse`
  String get step3Title {
    return Intl.message(
      'Receive Nurse',
      name: 'step3Title',
      desc: '',
      args: [],
    );
  }

  /// `The closest certified nurse is automatically selected for you. Track their location on the map until arrival in less than 15 minutes.`
  String get step3Desc {
    return Intl.message(
      'The closest certified nurse is automatically selected for you. Track their location on the map until arrival in less than 15 minutes.',
      name: 'step3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Pay and Rate`
  String get step4Title {
    return Intl.message(
      'Pay and Rate',
      name: 'step4Title',
      desc: '',
      args: [],
    );
  }

  /// `After service completion, pay securely and rate the nurse. Your ratings help maintain service quality for everyone.`
  String get step4Desc {
    return Intl.message(
      'After service completion, pay securely and rate the nurse. Your ratings help maintain service quality for everyone.',
      name: 'step4Desc',
      desc: '',
      args: [],
    );
  }

  /// `Select Account Type`
  String get selectAccountType {
    return Intl.message(
      'Select Account Type',
      name: 'selectAccountType',
      desc: '',
      args: [],
    );
  }

  /// `Choose whether you are a patient seeking care or a nurse offering services`
  String get selectAccountTypeDesc {
    return Intl.message(
      'Choose whether you are a patient seeking care or a nurse offering services',
      name: 'selectAccountTypeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up as a Patient`
  String get patientButton {
    return Intl.message(
      'Sign Up as a Patient',
      name: 'patientButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up as a Nurse`
  String get nurseButton {
    return Intl.message(
      'Sign Up as a Nurse',
      name: 'nurseButton',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to CURE`
  String get welcome {
    return Intl.message(
      'Welcome to CURE',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get errorRequired {
    return Intl.message(
      'This field is required',
      name: 'errorRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get errorInvalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get errorInvalidPassword {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'errorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get errorPasswordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'errorPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get errorInvalidPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'errorInvalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please select your date of birth`
  String get errorInvalidDOB {
    return Intl.message(
      'Please select your date of birth',
      name: 'errorInvalidDOB',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gender`
  String get errorSelectGender {
    return Intl.message(
      'Please select your gender',
      name: 'errorSelectGender',
      desc: '',
      args: [],
    );
  }

  /// `Please enter years of experience`
  String get errorExperienceRequired {
    return Intl.message(
      'Please enter years of experience',
      name: 'errorExperienceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your region`
  String get errorRegionRequired {
    return Intl.message(
      'Please enter your region',
      name: 'errorRegionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your skills or specialties`
  String get errorSkillsRequired {
    return Intl.message(
      'Please enter your skills or specialties',
      name: 'errorSkillsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Join as a Nurse`
  String get nurseSignupTitle {
    return Intl.message(
      'Join as a Nurse',
      name: 'nurseSignupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Provide Care. Make a Difference.`
  String get nurseSignupSubtitle {
    return Intl.message(
      'Provide Care. Make a Difference.',
      name: 'nurseSignupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Account Security`
  String get accountSecurity {
    return Intl.message(
      'Account Security',
      name: 'accountSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Professional Information`
  String get professionalInformation {
    return Intl.message(
      'Professional Information',
      name: 'professionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Personal Details`
  String get personalDetails {
    return Intl.message(
      'Personal Details',
      name: 'personalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Join as Nurse`
  String get joinAsNurse {
    return Intl.message(
      'Join as Nurse',
      name: 'joinAsNurse',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumberLabel {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Years of Experience`
  String get yearsOfExperience {
    return Intl.message(
      'Years of Experience',
      name: 'yearsOfExperience',
      desc: '',
      args: [],
    );
  }

  /// `Less than 1 year`
  String get experienceLessThanOneYear {
    return Intl.message(
      'Less than 1 year',
      name: 'experienceLessThanOneYear',
      desc: '',
      args: [],
    );
  }

  /// `1-3 years`
  String get experience1to3Years {
    return Intl.message(
      '1-3 years',
      name: 'experience1to3Years',
      desc: '',
      args: [],
    );
  }

  /// `3-5 years`
  String get experience3to5Years {
    return Intl.message(
      '3-5 years',
      name: 'experience3to5Years',
      desc: '',
      args: [],
    );
  }

  /// `More than 5 years`
  String get experienceMoreThan5Years {
    return Intl.message(
      'More than 5 years',
      name: 'experienceMoreThan5Years',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get regionLabel {
    return Intl.message(
      'Region',
      name: 'regionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Fayoum City`
  String get regionFayoumCity {
    return Intl.message(
      'Fayoum City',
      name: 'regionFayoumCity',
      desc: '',
      args: [],
    );
  }

  /// `Itsa`
  String get regionItsa {
    return Intl.message(
      'Itsa',
      name: 'regionItsa',
      desc: '',
      args: [],
    );
  }

  /// `Tamiya`
  String get regionTamiya {
    return Intl.message(
      'Tamiya',
      name: 'regionTamiya',
      desc: '',
      args: [],
    );
  }

  /// `Youssef El Seddik`
  String get regionYoussefElSeddik {
    return Intl.message(
      'Youssef El Seddik',
      name: 'regionYoussefElSeddik',
      desc: '',
      args: [],
    );
  }

  /// `Snores`
  String get regionSnores {
    return Intl.message(
      'Snores',
      name: 'regionSnores',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get regionOther {
    return Intl.message(
      'Other',
      name: 'regionOther',
      desc: '',
      args: [],
    );
  }

  /// `Skills & Specialties`
  String get skillsSpecialties {
    return Intl.message(
      'Skills & Specialties',
      name: 'skillsSpecialties',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirthLabel {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderLabel {
    return Intl.message(
      'Gender',
      name: 'genderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get maleLabel {
    return Intl.message(
      'Male',
      name: 'maleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get femaleLabel {
    return Intl.message(
      'Female',
      name: 'femaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nurse account created successfully`
  String get nurseSignupSuccess {
    return Intl.message(
      'Nurse account created successfully',
      name: 'nurseSignupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Create your patient account`
  String get patientSignupTitle {
    return Intl.message(
      'Create your patient account',
      name: 'patientSignupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to access home nursing services`
  String get patientSignupSubtitle {
    return Intl.message(
      'Sign up to access home nursing services',
      name: 'patientSignupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Join as Patient`
  String get joinAsPatient {
    return Intl.message(
      'Join as Patient',
      name: 'joinAsPatient',
      desc: '',
      args: [],
    );
  }

  /// `Patient signup submitted`
  String get patientSignupSuccess {
    return Intl.message(
      'Patient signup submitted',
      name: 'patientSignupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBackTitle {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBackTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In to Continue`
  String get signInToContinue {
    return Intl.message(
      'Sign In to Continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButtonLabel {
    return Intl.message(
      'Sign In',
      name: 'signInButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Join our network of certified nurses and start providing high-quality, fast home care.`
  String get nurseButtonSubtitle {
    return Intl.message(
      'Join our network of certified nurses and start providing high-quality, fast home care.',
      name: 'nurseButtonSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get fast and secure home care from our network of certified nurses in less than 15 minutes.`
  String get patientButtonSubtitle {
    return Intl.message(
      'Get fast and secure home care from our network of certified nurses in less than 15 minutes.',
      name: 'patientButtonSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your account for quick access to home nursing services or to manage your nurse account.`
  String get alreadyHaveAccountSubtitle {
    return Intl.message(
      'Sign in to your account for quick access to home nursing services or to manage your nurse account.',
      name: 'alreadyHaveAccountSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get errorUserNotFoundAfterSignIn {
    return Intl.message(
      'User not found',
      name: 'errorUserNotFoundAfterSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get errorWrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'errorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get errorUnexpected {
    return Intl.message(
      'An unexpected error occurred',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `email already exists`
  String get errorUserAlreadyExists {
    return Intl.message(
      'email already exists',
      name: 'errorUserAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get accountDetailsHeaderTitle {
    return Intl.message(
      'Account Details',
      name: 'accountDetailsHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Secure your account with a strong password`
  String get accountDetailsHeaderSubtitle {
    return Intl.message(
      'Secure your account with a strong password',
      name: 'accountDetailsHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile Photo`
  String get profilePhotoHeaderTitle {
    return Intl.message(
      'Profile Photo',
      name: 'profilePhotoHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a profile photo to personalize your nurse profile`
  String get profilePhotoHeaderSubtitle {
    return Intl.message(
      'Choose a profile photo to personalize your nurse profile',
      name: 'profilePhotoHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Career Details`
  String get careerDetailsHeaderTitle {
    return Intl.message(
      'Career Details',
      name: 'careerDetailsHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about your experience and service area`
  String get careerDetailsHeaderSubtitle {
    return Intl.message(
      'Tell us about your experience and service area',
      name: 'careerDetailsHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal Details`
  String get personalDetailsHeaderTitle {
    return Intl.message(
      'Personal Details',
      name: 'personalDetailsHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complete your profile with birthdate and gender`
  String get personalDetailsHeaderSubtitle {
    return Intl.message(
      'Complete your profile with birthdate and gender',
      name: 'personalDetailsHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Photo`
  String get SelectPhoto {
    return Intl.message(
      'Select Photo',
      name: 'SelectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Profile photo helps patients recognize you easily.`
  String get NurseProfilePhotoNote {
    return Intl.message(
      'Profile photo helps patients recognize you easily.',
      name: 'NurseProfilePhotoNote',
      desc: '',
      args: [],
    );
  }

  /// `Storage permission denied. Please allow access to select a profile photo.`
  String get storagePermissionDenied {
    return Intl.message(
      'Storage permission denied. Please allow access to select a profile photo.',
      name: 'storagePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied issue`
  String get storagePermissionDenirdTitle {
    return Intl.message(
      'Permission Denied issue',
      name: 'storagePermissionDenirdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Storage Permission Required`
  String get storagePermissionDialogTitle {
    return Intl.message(
      'Storage Permission Required',
      name: 'storagePermissionDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Storage access is required to save and manage files. Please enable the permission from app settings.`
  String get storagePermissionDialogMessage {
    return Intl.message(
      'Storage access is required to save and manage files. Please enable the permission from app settings.',
      name: 'storagePermissionDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get storagePermissionDialogLater {
    return Intl.message(
      'Later',
      name: 'storagePermissionDialogLater',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get storagePermissionDialogOpenSettings {
    return Intl.message(
      'Open Settings',
      name: 'storagePermissionDialogOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `A profile photo helps nurses recognize you easily.`
  String get PatientProfilePhotoNote {
    return Intl.message(
      'A profile photo helps nurses recognize you easily.',
      name: 'PatientProfilePhotoNote',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the data is correct and try again`
  String get makeSure {
    return Intl.message(
      'Make sure the data is correct and try again',
      name: 'makeSure',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get deleteAccountDialogMessage {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'deleteAccountDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get signOutDialogMessage {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message(
      'Preferences',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get accountDeleted {
    return Intl.message(
      'Account deleted successfully',
      name: 'accountDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Customize Theme and Language`
  String get customizeThemeAndLanguage {
    return Intl.message(
      'Customize Theme and Language',
      name: 'customizeThemeAndLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language And Theme`
  String get languageAndTheme {
    return Intl.message(
      'Language And Theme',
      name: 'languageAndTheme',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message(
      'Theme Mode',
      name: 'themeMode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get featureFast {
    return Intl.message(
      'Fast',
      name: 'featureFast',
      desc: '',
      args: [],
    );
  }

  /// `Safe`
  String get featureSafe {
    return Intl.message(
      'Safe',
      name: 'featureSafe',
      desc: '',
      args: [],
    );
  }

  /// `Fair`
  String get featureFair {
    return Intl.message(
      'Fair',
      name: 'featureFair',
      desc: '',
      args: [],
    );
  }

  /// `15 minutes or less`
  String get splashSlide4Benefit1 {
    return Intl.message(
      '15 minutes or less',
      name: 'splashSlide4Benefit1',
      desc: '',
      args: [],
    );
  }

  /// `Selected certified nurses`
  String get splashSlide4Benefit2 {
    return Intl.message(
      'Selected certified nurses',
      name: 'splashSlide4Benefit2',
      desc: '',
      args: [],
    );
  }

  /// `Transparent and fair pricing`
  String get splashSlide4Benefit3 {
    return Intl.message(
      'Transparent and fair pricing',
      name: 'splashSlide4Benefit3',
      desc: '',
      args: [],
    );
  }

  /// `Please login again to delete your account.`
  String get reauthRequiredToDelete {
    return Intl.message(
      'Please login again to delete your account.',
      name: 'reauthRequiredToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Sign out failed`
  String get signOutFailed {
    return Intl.message(
      'Sign out failed',
      name: 'signOutFailed',
      desc: '',
      args: [],
    );
  }

  /// `Book a Service`
  String get bookService {
    return Intl.message(
      'Book a Service',
      name: 'bookService',
      desc: '',
      args: [],
    );
  }

  /// `Select a service`
  String get selectService {
    return Intl.message(
      'Select a service',
      name: 'selectService',
      desc: '',
      args: [],
    );
  }

  /// `Choose date & time`
  String get chooseDateTime {
    return Intl.message(
      'Choose date & time',
      name: 'chooseDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Available slots`
  String get availableSlots {
    return Intl.message(
      'Available slots',
      name: 'availableSlots',
      desc: '',
      args: [],
    );
  }

  /// `No available slots for this day`
  String get noSlots {
    return Intl.message(
      'No available slots for this day',
      name: 'noSlots',
      desc: '',
      args: [],
    );
  }

  /// `Select region`
  String get selectRegion {
    return Intl.message(
      'Select region',
      name: 'selectRegion',
      desc: '',
      args: [],
    );
  }

  /// `Clinical remarks`
  String get clinicalRemarks {
    return Intl.message(
      'Clinical remarks',
      name: 'clinicalRemarks',
      desc: '',
      args: [],
    );
  }

  /// `Symptoms, conditions, notes for the nurse (optional)`
  String get remarksHint {
    return Intl.message(
      'Symptoms, conditions, notes for the nurse (optional)',
      name: 'remarksHint',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressLabel {
    return Intl.message(
      'Address',
      name: 'addressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Building, street, area`
  String get addressHint {
    return Intl.message(
      'Building, street, area',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Review your booking`
  String get reviewBooking {
    return Intl.message(
      'Review your booking',
      name: 'reviewBooking',
      desc: '',
      args: [],
    );
  }

  /// `Confirm booking`
  String get confirmBooking {
    return Intl.message(
      'Confirm booking',
      name: 'confirmBooking',
      desc: '',
      args: [],
    );
  }

  /// `Booking confirmed`
  String get bookingConfirmed {
    return Intl.message(
      'Booking confirmed',
      name: 'bookingConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been sent. You can track it on your dashboard.`
  String get bookingConfirmedSubtitle {
    return Intl.message(
      'Your request has been sent. You can track it on your dashboard.',
      name: 'bookingConfirmedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Could not complete the booking`
  String get bookingFailed {
    return Intl.message(
      'Could not complete the booking',
      name: 'bookingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Requested`
  String get statusRequested {
    return Intl.message(
      'Requested',
      name: 'statusRequested',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get statusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'statusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get statusInProgress {
    return Intl.message(
      'In progress',
      name: 'statusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get statusCompleted {
    return Intl.message(
      'Completed',
      name: 'statusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get statusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'statusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `My Dashboard`
  String get dashboardTitle {
    return Intl.message(
      'My Dashboard',
      name: 'dashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Active requests`
  String get activeRequests {
    return Intl.message(
      'Active requests',
      name: 'activeRequests',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get bookingHistory {
    return Intl.message(
      'History',
      name: 'bookingHistory',
      desc: '',
      args: [],
    );
  }

  /// `No bookings yet`
  String get noBookings {
    return Intl.message(
      'No bookings yet',
      name: 'noBookings',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get totalBookings {
    return Intl.message(
      'Total',
      name: 'totalBookings',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activeLabel {
    return Intl.message(
      'Active',
      name: 'activeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completedLabel {
    return Intl.message(
      'Completed',
      name: 'completedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel booking`
  String get cancelBooking {
    return Intl.message(
      'Cancel booking',
      name: 'cancelBooking',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this booking?`
  String get cancelBookingConfirm {
    return Intl.message(
      'Are you sure you want to cancel this booking?',
      name: 'cancelBookingConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Incoming requests`
  String get incomingRequests {
    return Intl.message(
      'Incoming requests',
      name: 'incomingRequests',
      desc: '',
      args: [],
    );
  }

  /// `No incoming requests`
  String get noIncomingRequests {
    return Intl.message(
      'No incoming requests',
      name: 'noIncomingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated`
  String get profileUpdated {
    return Intl.message(
      'Profile updated',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Nurse`
  String get nurse {
    return Intl.message(
      'Nurse',
      name: 'nurse',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message(
      'Patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Book a Nurse`
  String get bookAnurse {
    return Intl.message(
      'Book a Nurse',
      name: 'bookAnurse',
      desc: '',
      args: [],
    );
  }

  /// `Check Nurses Profile`
  String get checkNurses {
    return Intl.message(
      'Check Nurses Profile',
      name: 'checkNurses',
      desc: '',
      args: [],
    );
  }

  /// `Nurses`
  String get nurses {
    return Intl.message(
      'Nurses',
      name: 'nurses',
      desc: '',
      args: [],
    );
  }

  /// `Nurse Details`
  String get nurseDetails {
    return Intl.message(
      'Nurse Details',
      name: 'nurseDetails',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get yearsOld {
    return Intl.message(
      'years old',
      name: 'yearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Skill set`
  String get skillSet {
    return Intl.message(
      'Skill set',
      name: 'skillSet',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Less than 1 year of experience`
  String get lessThanOneExperience {
    return Intl.message(
      'Less than 1 year of experience',
      name: 'lessThanOneExperience',
      desc: '',
      args: [],
    );
  }

  /// `1–3 years of experience`
  String get oneToThreeExperience {
    return Intl.message(
      '1–3 years of experience',
      name: 'oneToThreeExperience',
      desc: '',
      args: [],
    );
  }

  /// `3–5 years of experience`
  String get threeToFiveExperience {
    return Intl.message(
      '3–5 years of experience',
      name: 'threeToFiveExperience',
      desc: '',
      args: [],
    );
  }

  /// `5+ years of experience`
  String get moreThanFiveExperience {
    return Intl.message(
      '5+ years of experience',
      name: 'moreThanFiveExperience',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message(
      'Book Now',
      name: 'bookNow',
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
