import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1500),
                      border: Border.all(color: Colors.black, width: 3.3)),
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .3,
                  child: ClipOval(
                    child: Image.network(
                      'https://img.freepik.com/free-icon/important-person_318-10744.jpg?w=2000',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * .021,
              ),
              Text(
                SharedData.user?.userName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.editProfile))
            ],
          ),
        ),
      ),
    );
  }
}
