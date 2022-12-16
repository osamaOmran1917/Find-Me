import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  static const String routeName = 'Confirm Phone Number Screen';

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
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
              children: [
                Image.network(
                  'https://img.icons8.com/external-flaticons-lineal-color-flat-icons/2x/external-mobile-phone-resume-flaticons-lineal-color-flat-icons.png',
                  width: 280,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInDown(
                    child: Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                FadeInDown(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Enter your phone number to continue, we will send you OPT to verify.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                )),
                SizedBox(
                  height: 30,
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
                        onInputChanged: (value) {},
                        cursorColor: Colors.black,
                        formatInput: false,
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG),
                        inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16)),
                      ),
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: 100,
                ),
                FadeInDown(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Request OPT',
                    style: TextStyle(),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
