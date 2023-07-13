import 'package:bazzar_app/screens/account_screen/account_screen.dart';
import 'package:bazzar_app/screens/cart_screen/cart_screen.dart';
import 'package:bazzar_app/screens/home/home.dart';
import 'package:bazzar_app/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        Home(),
        CartScreen(),
        OrderScreen(),
        AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "ماڵەوە",
            inactiveIcon: Icon(Icons.home_outlined),
            activeColorPrimary: Color.fromARGB(255, 255, 137, 137),
            inactiveColorPrimary:
                Color.fromARGB(255, 255, 137, 137).withOpacity(0.4),
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          inactiveIcon: Icon(Icons.shopping_cart_outlined),
          title: "کارت",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.teal.withOpacity(.4),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_basket),
          inactiveIcon: Icon(Icons.shopping_basket_outlined),
          title: "کڕین",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.blueAccent.withOpacity(.4),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: Icon(Icons.person_2_outlined),
          title: "هەژمار",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.deepOrange.withOpacity(.4),
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Colors.white70,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
