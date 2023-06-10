import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/presentation/custom_widgets/bottom_nav_bar/curved_navigation_bar.dart';
import 'package:exchange/presentation/flows/home_flow/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../coming_soon/coming_soon.dart';
import '../../converter_flow/screens/converter_screen.dart';
import '../../settings_flow/screens/settings_page.dart';
import '../bloc/root_bloc.dart';

enum RootTabs { currency, converter, gold, settings }

class NavigationController {
  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: TranslationsKeys.myLocation,

      page: HomeScreen(),
    ),
    NavigationItem(
      title: TranslationsKeys.exchange,

      page: ConverterScreen(),
    ),
    NavigationItem(
      title: TranslationsKeys.settings,

      page: ComingSoonPage(),
    ),
    NavigationItem(
      title: TranslationsKeys.settings,

      page: SettingsPage(),
    ),
  ];

  NavigationItem currentNavigationItem(index) => _navigationItems[index];

  List<BottomNavigationBarItem> bottomNavigationBarItems(context) => _navigationItems
      .map((item) => BottomNavigationBarItem(
            icon: SvgPicture.asset(item.disabledIcon ?? item.enabledIcon),
            activeIcon: SvgPicture.asset(item.enabledIcon ?? item.disabledIcon),
            label: item.title.tr(context),
          ))
      .toList();
}

class NavigationItem {
  final String title;
  final String enabledIcon;
  final String disabledIcon;
  final Widget page;

  NavigationItem(
      {@required this.title, this.enabledIcon, this.disabledIcon, @required this.page});
}

class RootPageWidget extends StatefulWidget {
  @override
  _RootPageWidgetState createState() => _RootPageWidgetState();
}

class _RootPageWidgetState extends State<RootPageWidget> {
  final bloc = locator<RootBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: locator<NavigationController>().currentNavigationItem(state.currentIndex).page,
          bottomNavigationBar: CurvedNavigationBar(
            color: locator<AppThemeColors>().primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // height: 75.sp,
            items: <NavBarItem>[
              NavBarItem(
                  widget: SvgPicture.asset(
                    ImagesKeys.rain,
                  ),
                  name: "Currency".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain3,
                    ),
                  ),
                  name: "Converter".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain1,
                    ),
                  ),
                  name: "Gold".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain2,
                    ),
                  ),
                  name: "settings".tr(context)),
            ],
            onTap: (index) {
              //Handle button tap
              bloc.navigateTo(RootTabs.values[index]);
            },
          ),
        );
      },
    );
  }
}
