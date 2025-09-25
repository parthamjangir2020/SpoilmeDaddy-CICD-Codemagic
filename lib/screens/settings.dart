import 'package:active_ecommerce_cms_demo_app/custom/aiz_route.dart';
import 'package:active_ecommerce_cms_demo_app/custom/device_info.dart';
import 'package:active_ecommerce_cms_demo_app/custom/lang_text.dart';
import 'package:active_ecommerce_cms_demo_app/custom/toast_component.dart';
import 'package:active_ecommerce_cms_demo_app/helpers/auth_helper.dart';
import 'package:active_ecommerce_cms_demo_app/l10n/app_localizations.dart';

import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
import 'package:active_ecommerce_cms_demo_app/repositories/auth_repository.dart';
import 'package:active_ecommerce_cms_demo_app/screens/change_language.dart';
import 'package:active_ecommerce_cms_demo_app/screens/currency_change.dart';
import 'package:active_ecommerce_cms_demo_app/screens/home.dart';
import 'package:active_ecommerce_cms_demo_app/screens/profile_edit.dart';
import 'package:active_ecommerce_cms_demo_app/screens/address.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late BuildContext loadingContext;

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  Widget buildView(BuildContext context) {
    return SizedBox(
      height: DeviceInfo(context).height,
      child: Stack(
        children: [
          Container(
            height: DeviceInfo(context).height! / 1,
            width: DeviceInfo(context).width,
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: Image.asset("assets/background_1.png", color: Colors.grey),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            body: buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          buildBottomVerticalCardListItem(
            "assets/language.png",
            AppLocalizations.of(context)!.language_ucf,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeLanguage()),
              );
            },
          ),
          Divider(thickness: 1, color: MyTheme.light_grey),
          buildBottomVerticalCardListItem(
            "assets/currency.png",
            AppLocalizations.of(context)!.currency_ucf,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrencyChange()),
              );
            },
          ),
          Divider(thickness: 1, color: MyTheme.light_grey),
          buildBottomVerticalCardListItem(
            "assets/edit.png",
            AppLocalizations.of(context)!.edit_profile_ucf,
            onPressed: () {
              AIZRoute.push(context, ProfileEdit());
            },
          ),
          Divider(thickness: 1, color: MyTheme.light_grey),
          buildBottomVerticalCardListItem(
            "assets/location.png",
            AppLocalizations.of(context)!.address_ucf,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Address()),
              );
            },
          ),
          Divider(thickness: 1, color: MyTheme.light_grey),
          buildBottomVerticalCardListItem(
            "assets/delete.png",
            LangText(context).local.delete_my_account,
            onPressed: () {
              deleteWarningDialog(context);
            },
          ),
          Divider(thickness: 1, color: MyTheme.light_grey),
        ],
      ),
    );
  }

  deleteWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              LangText(context).local.delete_account_warning_title,
              style: TextStyle(fontSize: 15, color: MyTheme.dark_font_grey),
            ),
            content: Text(
              LangText(context).local.delete_account_warning_description,
              style: TextStyle(fontSize: 13, color: MyTheme.dark_font_grey),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  pop(context);
                },
                child: Text(LangText(context).local.no_ucf),
              ),
              TextButton(
                onPressed: () {
                  pop(context);
                  deleteAccountReq(context);
                },
                child: Text(LangText(context).local.yes_ucf),
              ),
            ],
          ),
    );
  }

  deleteAccountReq(BuildContext context) async {
    if (!mounted) return; // Ensure the widget is still mounted

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text(AppLocalizations.of(context)!.please_wait_ucf),
            ],
          ),
        );
      },
    );

    // Perform delete request
    var response = await AuthRepository().getAccountDeleteResponse();

    // If widget is not mounted, prevent further context-related actions
    if (!mounted) return;

    // Close loading dialog safely by checking if we can pop the context
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Close the loading dialog
    }

    // If deletion is successful, clear user data and navigate to home
    if (response.result) {
      AuthHelper().clearUserData();

      // Use post-frame callback to ensure navigation happens after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Ensure the context is still valid before navigating
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // This ensures it's safe to pop the context
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (route) => false,
          );
        }
      });
    }

    // Show response message as toast
    ToastComponent.showDialog(response.message);
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  SizedBox buildBottomVerticalCardListItem(
    String img,
    String label, {
    Function()? onPressed,
    bool isDisable = false,
  }) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Image.asset(
                img,
                height: 16,
                width: 16,
                color: isDisable ? MyTheme.grey_153 : MyTheme.dark_font_grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDisable ? MyTheme.grey_153 : MyTheme.dark_font_grey,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
