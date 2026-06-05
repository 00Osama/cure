import 'package:cure/shared/theme_and_locals/app_gradients.dart';
import 'package:flutter/material.dart';

/// Custom Scaffold with gradient background
/// Automatically applies the appropriate gradient for light/dark mode
class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final ScaffoldGeometry Function(BuildContext)? extendBodyBehindAppBar;
  final bool extendBody;
  final bool extendBodyBehindBottomSheet;
  final bool primary;
  final bool? resizeToAvoidBottomInset;
  final bool drawerScrimColor;

  const GradientScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.extendBodyBehindAppBar,
    this.extendBody = false,
    this.extendBodyBehindBottomSheet = false,
    this.primary = true,
    this.resizeToAvoidBottomInset,
    this.drawerScrimColor = true,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = context.appGradient;

    return Scaffold(
      appBar: appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: gradient),
        child: body ?? const SizedBox.expand(),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: Colors.transparent,
      extendBody: extendBody,
      primary: primary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
