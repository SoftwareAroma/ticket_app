import 'package:award_ticket/index.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  static String id = "no_internet_screen";
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Assets.imagesNoInternet,
              color: Theme.of(context).colorScheme.error,
              height: 100.0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: CustomText(
                StringResource.noInternetConnection,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.normal,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: CustomText(
                "Check your connection, then refresh the page.",
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
              ),
              onPressed: () => _onRefresh,
              child: CustomText(
                "Refresh",
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onRefresh() async {
    // You can also check the internet connection through this below function as well
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    debugPrint(result.toString());
    if (!mounted) return;
    // if there is internet connection, then pop this context
    if (result.contains(ConnectivityResult.none)) {
      Navigator.of(context).pop();
    }
  }
}
