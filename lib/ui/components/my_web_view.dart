import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:award_ticket/index.dart';

class MyWebView extends StatefulWidget {
  final String selectedUrl;
  final String? title;

  const MyWebView({
    super.key,
    required this.selectedUrl,
    this.title,
  });

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool _loaded = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 5.0,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
              ),
              borderRadius: BorderRadius.circular(5.0.r),
            ),
            child: Center(
              child: Icon(
                LineAwesomeIcons.angle_left_solid,
                color: Theme.of(context).colorScheme.surface,
                size: 20.0.w,
              ),
            ),
          ),
        ),
        title: CustomText(
          widget.title?.toUpperCase() ?? "",
          fontSize: 16.0.sp,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w900,
          maxLines: 4,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            !_loaded
                ? const LinearProgressIndicator(
                    value: null,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  )
                : Container(),
            error.isNotEmpty
                ? Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "HTTP 404 Error: Failed to load resource",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 24.0.sp,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(widget.selectedUrl)),
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        transparentBackground: true,
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {},
                      onLoadStart: (InAppWebViewController controller, Uri? url) {
                        setState(() {
                          _loaded = false;
                        });
                      },
                      onLoadStop: (InAppWebViewController controller, Uri? url) {
                        setState(() {
                          _loaded = true;
                        });
                      },
                      onReceivedError: (
                        InAppWebViewController controller,
                        WebResourceRequest request,
                        WebResourceError webResourceError,
                      ) {
                        setState(() {
                          setState(() {
                            error = webResourceError.description;
                          });
                          logger.e(webResourceError);
                        });
                      },
                      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                          Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer(),
                          ),
                        ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
