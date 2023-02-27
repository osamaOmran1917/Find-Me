import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMissingPersonScreen extends StatefulWidget {
  EditMissingPersonScreen({required this.missingPerson});

  MissingPerson missingPerson;

  @override
  State<EditMissingPersonScreen> createState() =>
      _EditMissingPersonScreenState();
}

class _EditMissingPersonScreenState extends State<EditMissingPersonScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.missingPerson.name ??
                  AppLocalizations.of(context)!.nameNotAvailable,
              style: TextStyle(color: MyTheme.basicWhite)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.missingPerson.name,
                onSaved: (val) => MyDataBase.updateMissingPersonInfo(
                    missingPersonId: widget.missingPerson.id!, name: val),
                validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : AppLocalizations.of(context)!.requiredField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(
                      CupertinoIcons.person_alt,
                      color: Colors.blue,
                    ),
                    hintText: AppLocalizations.of(context)!.egAhmedAdam,
                    label: Text(AppLocalizations.of(context)!.name)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              TextFormField(
                initialValue: widget.missingPerson.name,
                onSaved: (val) => MyDataBase.updateMissingPersonInfo(
                    missingPersonId: widget.missingPerson.id!, name: val),
                validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : AppLocalizations.of(context)!.requiredField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(
                      CupertinoIcons.person_alt,
                      color: Colors.blue,
                    ),
                    hintText: AppLocalizations.of(context)!.egAhmedAdam,
                    label: Text(AppLocalizations.of(context)!.name)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              TextFormField(
                initialValue: widget.missingPerson.name,
                onSaved: (val) => MyDataBase.updateMissingPersonInfo(
                    missingPersonId: widget.missingPerson.id!, name: val),
                validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : AppLocalizations.of(context)!.requiredField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(
                      CupertinoIcons.person_alt,
                      color: Colors.blue,
                    ),
                    hintText: AppLocalizations.of(context)!.egAhmedAdam,
                    label: Text(AppLocalizations.of(context)!.name)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              TextFormField(
                initialValue: widget.missingPerson.name,
                onSaved: (val) => MyDataBase.updateMissingPersonInfo(
                    missingPersonId: widget.missingPerson.id!, name: val),
                validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : AppLocalizations.of(context)!.requiredField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(
                      CupertinoIcons.person_alt,
                      color: Colors.blue,
                    ),
                    hintText: AppLocalizations.of(context)!.egAhmedAdam,
                    label: Text(AppLocalizations.of(context)!.name)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
