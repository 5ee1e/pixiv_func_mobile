import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixiv_func_mobile/app/url_scheme/url_scheme.dart';
import 'package:pixiv_func_mobile/pages/home/home.dart';
import 'package:pixiv_func_mobile/pages/login/login.dart';
import 'package:pixiv_func_mobile/pages/welcome/welcome.dart';
import 'package:pixiv_func_mobile/services/account_service.dart';
import 'package:pixiv_func_mobile/services/settings_service.dart';
import 'package:uni_links2/uni_links.dart' as uni_links;

class IndexWidget extends StatefulWidget {
  const IndexWidget({Key? key}) : super(key: key);

  @override
  State<IndexWidget> createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> {
  bool _linkChecked = false;

  late StreamSubscription<String?> _subscription;

  @override
  void initState() {
    uni_links.getInitialLink().then((url) async {
      if (null != url) {
        await UrlScheme.handler(url);
      }
      setState(() => _linkChecked = true);
    });
    _subscription = uni_links.linkStream.listen((url) async {
      if (null != url) {
        await UrlScheme.handler(url);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_linkChecked) {
      return const SizedBox();
    }
    if (!Get.find<SettingsService>().guideInit) {
      return const WelcomePage();
    } else {
      if (Get.find<AccountService>().isEmpty) {
        return const LoginPage();
      } else {
        return const HomePage();
      }
    }
  }
}
