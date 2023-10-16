import 'package:csse/models/site_model.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/local_prefs.dart';
import 'package:csse/services/site_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/auth/auth_checker.dart';
import 'package:csse/widgets/input_field.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserProvider userProvider;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController siteName = TextEditingController();
  final TextEditingController siteLocation = TextEditingController();
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      name.text = userProvider.user?.name ?? '';
      email.text = userProvider.user?.email ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          MaterialButton(
            onPressed: () async {
              LocalPreferences.instance.clearePrefs();
              await FirebaseAuth.instance.signOut();
              context.navigator(context, AuthChecker());
            },
            child: const Text("Logout"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(defaultPadding),
              children: [
                CustomInputField(
                  label: 'Email',
                  hint: 'Email',
                  controller: email,
                  disabled: false,
                ),
                CustomInputField(
                  label: 'Name',
                  hint: 'Name',
                  controller: name,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: defaultPadding,
            ),
            child: MainButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomInputField(
                            label: 'Name',
                            hint: 'Site name',
                            controller: siteName,
                          ),
                          CustomInputField(
                            label: 'Location',
                            hint: 'Site location',
                            controller: siteLocation,
                          ),
                          MainButton(
                            onPressed: () async {
                              try {
                                SiteModel site = SiteModel(
                                  name: siteName.text,
                                  createdBy: userProvider.user!.id!,
                                  location: siteLocation.text,
                                );
                                await SiteService().createSite(site);
                                Navigator.pop(context);
                                context
                                    .showSnackBar('site created successfully');
                              } catch (e) {
                                context.showSnackBar('$e');
                              }
                            },
                            title: 'Add',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              title: 'Add Site',
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 2,
          //     horizontal: defaultPadding,
          //   ),
          //   child: MainButton(
          //     onPressed: () {},
          //     title: 'Update',
          //   ),
          // ),
        ],
      ),
    );
  }
}
