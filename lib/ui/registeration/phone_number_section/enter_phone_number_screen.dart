import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  static const String routeName = 'Enter Phone Number Screen';

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://img.icons8.com/external-flaticons-lineal-color-flat-icons/2x/external-mobile-phone-resume-flaticons-lineal-color-flat-icons.png',
                  width: 280,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                FadeInDown(
                    child: Text(
                      AppLocalizations.of(context)!.phoneNumber,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                FadeInDown(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        AppLocalizations.of(context)!
                            .enterYourPhoneNumberToContinueWeWillSendYouCodeToVerify,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                FadeInDown(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffeeeeee),
                                blurRadius: 10,
                                offset: Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.circular(8),
                          border:
                          Border.all(color: Colors.black.withOpacity(0.13))),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                        onInputChanged: (value) {
                          phoneNumber = value.phoneNumber!;
                        },
                        cursorColor: Colors.black,
                        formatInput: false,
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG),
                        inputDecoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)!.phoneNumber,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16)),
                          ),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .04,
                              width: 1,
                              color: Colors.black.withOpacity(0.13),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .10,
                ),
                FadeInDown(
                    child: MaterialButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    await auth.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        // ANDROID ONLY!

                        // Sign the user in (or link) with the auto-generated credential
                        await auth.signInWithCredential(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                        }

                        // Handle other errors
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        // Update the UI - wait for the user to enter the SMS code
                        String smsCode = 'xxxx';

                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                      },
                      timeout: const Duration(seconds: 60),
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // Auto-resolution timed out...
                      },
                    );
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  minWidth: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.requestVerificationCode,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                FadeInDown(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .alreadyHaveAnAccount,
                              style: TextStyle(color: Colors.grey.shade700),
                            ))
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}