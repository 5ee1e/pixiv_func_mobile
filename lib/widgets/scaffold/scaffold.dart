import 'package:flutter/material.dart';
import 'package:pixiv_func_mobile/widgets/text/text.dart';

class ScaffoldWidget extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? emptyAppBar;
  final bool automaticallyImplyLeading;
  final Widget? child;

  const ScaffoldWidget({
    Key? key,
    this.title,
    this.titleWidget,
    this.actions,
    this.centerTitle,
    this.emptyAppBar,
    this.automaticallyImplyLeading = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBar? appBar;
    if (null != emptyAppBar) {
      if (emptyAppBar!) {
        appBar = AppBar(
          elevation: 0,
          toolbarHeight: 0,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      } else if (null != titleWidget) {
        appBar = AppBar(
          elevation: 0,
          title: titleWidget,
          centerTitle: centerTitle,
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      } else if (null != title) {
        appBar = AppBar(
          elevation: 0,
          title: TextWidget(title!),
          centerTitle: centerTitle,
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      } else {
        appBar = null;
      }
    } else {
      if (null != titleWidget) {
        appBar = AppBar(
          elevation: 0,
          title: titleWidget,
          centerTitle: centerTitle,
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      } else if (null != title) {
        appBar = AppBar(
          elevation: 0,
          title: TextWidget(title!),
          centerTitle: centerTitle,
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      } else {
        appBar = null;
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: child,
    );
  }
}
