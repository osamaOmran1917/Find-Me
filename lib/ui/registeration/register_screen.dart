import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool securePasswordI = true;
  bool securePasswordII = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .05),
        child: AppBar(
          shape: Theme.of(context).appBarTheme.shape,
          centerTitle: true,
          title: Text('Find Me'),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'User Name Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'E-mail Adress'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },
                  obscureText: securePasswordI,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            securePasswordI = !securePasswordI;
                            setState(() {});
                          },
                          child: Icon(securePasswordI
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },
                  obscureText: securePasswordII,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            securePasswordII = !securePasswordII;
                            setState(() {});
                          },
                          child: Icon(securePasswordII
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Confirm Password'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .09,
                ),
                ElevatedButton(
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    createAccountClicked();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red))),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccountClicked() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
