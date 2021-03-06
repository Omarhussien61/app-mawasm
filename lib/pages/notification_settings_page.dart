import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool isAllNotifications = false;
  bool isOrderNotifications = true;
  bool isFaqNotifications = true;
  bool isReminderNotifications = true;
  bool isShoppingCartReminderNotifications = true;
  bool isDiscountReminderNotifications = true;
  bool isCustomizeUserDiscountReminderNotifications = true;
  bool isUpdateReminderNotifications = true;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, top: 24),
                  child: Text(
                   getTransrlate(context, 'Notification'),
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 28,
                  child: Divider(
                    color: themeColor.getColor(),
                    height: 3,
                    thickness: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isAllNotifications = !isAllNotifications;
                          });
                        },
                        value: isAllNotifications,
                        title: Text(
                          getTransrlate(context, 'AllowNotification'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isOrderNotifications = !isOrderNotifications;
                          });
                        },
                        value: isOrderNotifications,
                        title: Text(
                          getTransrlate(context, 'Order'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'discOrder'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isFaqNotifications = !isOrderNotifications;
                          });
                        },
                        value: isFaqNotifications,
                        title: Text(
                          getTransrlate(context, 'StoreQ&A'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'descStore'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isReminderNotifications = !isReminderNotifications;
                          });
                        },
                        value: isReminderNotifications,
                        title: Text(
                          getTransrlate(context, 'reminderCart'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'DescCart'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isShoppingCartReminderNotifications =
                                !isShoppingCartReminderNotifications;
                          });
                        },
                        value: isShoppingCartReminderNotifications,
                        title: Text(
                          getTransrlate(context, 'Opportunities'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'DescOpportunities'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isDiscountReminderNotifications =
                                !isDiscountReminderNotifications;
                          });
                        },
                        value: isDiscountReminderNotifications,
                        title: Text(
                          getTransrlate(context, 'SpecialBenefits'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'DescBenefits'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isCustomizeUserDiscountReminderNotifications =
                                !isCustomizeUserDiscountReminderNotifications;
                          });
                        },
                        value: isCustomizeUserDiscountReminderNotifications,
                        title: Text(
                          getTransrlate(context, 'updates'),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          getTransrlate(context, 'descupdates'),
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
