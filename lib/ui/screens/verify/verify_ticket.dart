import 'dart:io';

import 'package:award_ticket/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class VerifyTicketScreen extends StatefulWidget {
  static const String id = 'verify-ticket';
  const VerifyTicketScreen({super.key});

  @override
  State<VerifyTicketScreen> createState() => _VerifyTicketScreenState();
}

class _VerifyTicketScreenState extends State<VerifyTicketScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String id = '';
  String message = '';
  TicketModel? ticket;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    id = "";
    message = "";
    helperMethods.getTickets();
    super.initState();
  }

  // listen for changes on the id and search for the ticket

  Widget get _space => Gap(10.0.h);

  _saveTicket() async {
    if (id != '') {
      bool done = await ticketController.saveScannedTicket(ticket!.id);
      if (!mounted) return;
      if (done) {
        showCustomFlushBar(
          context: context,
          message: "Saved",
        );
      } else {
        showCustomFlushBar(
          context: context,
          message: "Something went wrong",
        );
      }
    } else {
      showCustomFlushBar(
        context: context,
        message: "No Ticket has been scanned.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      ticket = ticketController.searchTicket(result!.code!);
      if (ticket != null && ticket?.image == 'scanned') {
        message = "Ticket Already Scanned";
      }
      // logger.i("Ticket : $ticket");
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(
            LineAwesomeIcons.bars_solid,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Verify Ticket'.toUpperCase(),
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.flash_auto_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              controller?.toggleFlash();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              controller?.flipCamera();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
                vertical: 10.0.h,
              ),
              color: Colors.green,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AdmittedScreen();
                      },
                    ),
                  );
                },
                leading: Icon(
                  LineAwesomeIcons.users_solid,
                  color: Theme.of(context).colorScheme.surface,
                  size: 35.0.w,
                ),
                title: CustomText(
                  "Admitted Seats",
                  fontSize: 16.0.sp,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (result != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _space,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CustomText(
                                          "Ticket Details".toUpperCase(),
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 16.sp,
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Gap(5.0.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 2.h,
                                          width: 50.w,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ],
                                    ),
                                    _space,
                                    _space,
                                    // first name
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          "Ticket # :",
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        _space,
                                        CustomText(
                                          ticket?.ticketNumber ?? '',
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                    _space,
                                    // last name
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          "First Name :",
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        _space,
                                        CustomText(
                                          ticket?.firstName ?? '',
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                    _space,
                                    // last name
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          "Last Name :",
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        _space,
                                        CustomText(
                                          ticket?.lastName ?? '',
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                    _space,
                                    if (message == '')
                                      Container(
                                        color: Colors.red.withOpacity(0.3),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.0.w,
                                          vertical: 4.0.h,
                                        ),
                                        child: CustomText(
                                          message,
                                          fontSize: 18.0.sp,
                                          maxLines: 3,
                                          color: Theme.of(context).colorScheme.error,
                                        ),
                                      )
                                  ],
                                ),

                                /// tick icon
                                Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: message == '' ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(500.0),
                                  ),
                                  child: Icon(
                                    message == '' ? LineAwesomeIcons.check_circle : LineAwesomeIcons.times_solid,
                                    color: message == '' ? Colors.green : Colors.red,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                            Gap(10.0.h),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        result = null;
                                        id = '';
                                        ticket = null;
                                      });
                                    },
                                    child: Text(
                                      "Clear".toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontSize: 18.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(20.0.w),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: _saveTicket,
                                    child: Text(
                                      "Save".toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontSize: 18.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _space,
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0.r),
                                        side: BorderSide(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return const AdmittedScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "See Admitted".toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontSize: 18.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Scan a code',
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) {
      setState(() {
        result = scanData;
        id = result?.code ?? '';
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    logger.i('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
