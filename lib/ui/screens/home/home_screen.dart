import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:award_ticket/index.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String ticketId = '';
  String ticketNumber = '';

  final List<String> _tables = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];
  final List<String> _seats = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];

  Widget get _space => Gap(10.0.h);

  bool _isSaving = false;
  bool _showTickets = false;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  void _generateTicketId() {
    ticketId = HelperFunctions.generateTicketId();
    // update the state of the form field
    _formKey.currentState?.fields['ticket_id']?.didChange(ticketId);
    // call setState to update the UI
    setState(() {});
  }

  void _generateTicketNumber(tableNo, seatNo) {
    ticketId = HelperFunctions.generateTicketNumber(tableNo: tableNo, seatNo: seatNo);
    // update the state of the form field
    _formKey.currentState?.fields['ticket_number']?.didChange(ticketId);
    // call setState to update the UI
    setState(() {});
  }

  _createTicket(ticketData) async {
    // Map<String, dynamic> ticketData = _formKey.currentState!.value;
    Map<String, dynamic> ticket = {
      'ticketId': ticketData['ticketId'],
      'ticketNumber': HelperFunctions.generateTicketNumber(
        tableNo: ticketData['numberOfTables'],
        seatNo: ticketData['numberOfSeats'],
      ),
      'firstName': ticketData['firstName'],
      'lastName': ticketData['lastName'],
      'numberOfSeats': int.tryParse(ticketData['numberOfSeats']),
      'numberOfTables': int.tryParse(ticketData['numberOfTables']),
      'qrCode': ticketData['ticketId'],
    };
    TicketModel? ticketModel = await helperMethods.createTicket(data: ticket);
    if (!mounted) return;
    if (ticketModel == null) {
      showCustomFlushBar(context: context, message: "Failed to create ticket");
      setState(() {
        _isSaving = false;
      });
    }
    return ticketModel;
  }

  void _saveTicket() async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        _isSaving = true;
      });
      Map<String, dynamic> ticketData = _formKey.currentState!.value;
      Map<String, dynamic> ticket = {
        'ticketId': ticketData['ticket_id'] ?? HelperFunctions.generateTicketId(),
        'ticketNumber': ticketData['ticket_number'],
        'firstName': ticketData['first_name'],
        'lastName': ticketData['last_name'],
        'numberOfSeats': ticketData['number_of_seats'],
        'numberOfTables': ticketData['number_of_tables'],
        'qrCode': ticketData['ticket_id'],
      };
      // int numberOfSeats = int.parse(ticketData['number_of_seats']);
      // from 1 to the number of seats, create a ticket for each seat
      // for (int i = 1; i < numberOfSeats; i++) {
      //   ticket['number_of_seats'] = (i + 1).toString();
      //   ticket['ticket_id'] = HelperFunctions.generateTicketId();
      //   TicketModel ticketModel = await _createTicket(ticket);
      //   logger.i(ticketModel.toJson());
      // }

      ticket['ticket_id'] = HelperFunctions.generateTicketId();
      TicketModel ticketModel = await _createTicket(ticket);
      logger.i(ticketModel.toJson());

      setState(() {
        _isSaving = false;
      });
      helperMethods.getTickets();
    }
  }

  _saveTicketImg(id) async {
    await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((var image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/ticket_$id.png').create();
        await imagePath.writeAsBytes(image);

        // logger.e('Image path ${imagePath.path}');
        if (!mounted) return;
        showCustomFlushBar(context: context, message: "Ticket saved to ${imagePath.path}");
      }
    });
  }

  @override
  void initState() {
    _isSaving = false;
    _showTickets = false;
    ticketId = HelperFunctions.generateTicketId();
    ticketNumber = HelperFunctions.generateTicketNumber(seatNo: _seats[0], tableNo: _tables[0]);
    WidgetsBinding.instance.addPostFrameCallback((Duration callback) {
      helperMethods.getTickets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Ticket Form View
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0.h,
                  horizontal: 8.0.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0.h,
                        horizontal: 5.0.w,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 5.0.h,
                        horizontal: 0.0.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CustomOutlineButton(
                            title: "Tickets",
                            color: Theme.of(context).colorScheme.primary,
                            textColor: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              // clear the form
                              _formKey.currentState?.reset();
                              setState(() {
                                _showTickets = !_showTickets;
                              });
                            },
                          ),
                          if (ticketController.activeTicket != null)
                            CustomOutlineButton(
                              title: "Download",
                              color: Theme.of(context).colorScheme.primary,
                              textColor: Theme.of(context).colorScheme.primary,
                              onPressed: () => _saveTicketImg(
                                ticketController.activeTicket == null
                                    ? ticketId
                                    : ticketController.activeTicket!.ticketNumber,
                              ),
                            ),
                          if (_showTickets)
                            CustomOutlineButton(
                              title: "New Ticket",
                              color: Theme.of(context).colorScheme.primary,
                              textColor: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                ticketController.clearActiveTicket();
                                setState(() {
                                  _showTickets = false;
                                });
                              },
                            ),
                        ],
                      ),
                    ),

                    if (_showTickets)
                      Expanded(
                        child: Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0.h,
                              horizontal: 5.0.w,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(20.0.r),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.5.h,
                              ),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(0.8, 5.0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                _space,
                                Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          ticketController.updateActiveTicket(ticketController.tickets[index]);
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0.h,
                                            horizontal: 5.0.w,
                                          ),
                                          decoration: BoxDecoration(
                                            // different background color for active ticket
                                            color: ticketController.activeTicket?.ticketId ==
                                                    ticketController.tickets[index].ticketId
                                                ? Theme.of(context).colorScheme.primary
                                                : Theme.of(context).colorScheme.surface,
                                            borderRadius: BorderRadius.circular(10.0.r),
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 3.0,
                                                spreadRadius: 2.0,
                                                offset: Offset(0.4, 3.0),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    CustomText(
                                                      "Ticket #:",
                                                      fontWeight: FontWeight.w900,
                                                      color: ticketController.activeTicket?.ticketNumber ==
                                                              ticketController.tickets[index].ticketNumber
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                    _space,
                                                    CustomText(
                                                      ticketController.tickets[index].ticketNumber,
                                                      color: ticketController.activeTicket?.ticketNumber ==
                                                              ticketController.tickets[index].ticketNumber
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _space,
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    CustomText(
                                                      "Table:",
                                                      fontWeight: FontWeight.w900,
                                                      color: ticketController.activeTicket?.ticketId ==
                                                              ticketController.tickets[index].ticketId
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                    _space,
                                                    CustomText(
                                                      ticketController.tickets[index].numberOfTables.toString(),
                                                      color: ticketController.activeTicket?.ticketId ==
                                                              ticketController.tickets[index].ticketId
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _space,
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    CustomText(
                                                      "Seat:",
                                                      fontWeight: FontWeight.w900,
                                                      color: ticketController.activeTicket?.ticketId ==
                                                              ticketController.tickets[index].ticketId
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                    _space,
                                                    CustomText(
                                                      ticketController.tickets[index].numberOfSeats.toString(),
                                                      color: ticketController.activeTicket?.ticketId ==
                                                              ticketController.tickets[index].ticketId
                                                          ? Theme.of(context).colorScheme.onPrimary
                                                          : Theme.of(context).colorScheme.primary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return Gap(15.0.h);
                                    },
                                    itemCount: ticketController.tickets.length,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),

                    /// Ticket Form
                    if (!_showTickets)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0.h,
                          horizontal: 5.0.w,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20.0.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 0.5.h,
                          ),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0.8, 5.0),
                            ),
                          ],
                        ),
                        child: FormBuilder(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                _space,
                                CustomText(
                                  "Ticket Details".toUpperCase(),
                                  fontSize: 10.0.sp,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                _space,
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 0.0.h,
                                    horizontal: 35.0.w,
                                  ),
                                  child: BrandDivider(
                                    color: Theme.of(context).colorScheme.primary,
                                    height: 1.5.h,
                                  ),
                                ),
                                _space,
                                _space,
                                _space,
                                _space,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: FormBuilderTextField(
                                        name: 'ticket_id',
                                        enabled: false,
                                        initialValue: ticketId,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          labelText: "Ticket ID",
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.lock_solid,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            gapPadding: 5.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _space,
                                    Expanded(
                                      flex: 1,
                                      child: CustomOutlineButton(
                                        title: "GEN ID",
                                        color: Theme.of(context).colorScheme.primary,
                                        textColor: Theme.of(context).colorScheme.primary,
                                        onPressed: () => _generateTicketId(),
                                      ),
                                    ),
                                  ],
                                ),
                                _space,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: FormBuilderTextField(
                                        name: 'ticket_number',
                                        enabled: false,
                                        initialValue: ticketNumber,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          labelText: "Ticket #",
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.lock_solid,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            gapPadding: 5.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _space,
                                    _space,
                                    Expanded(
                                      flex: 1,
                                      child: CustomOutlineButton(
                                        title: "GEN #",
                                        color: Theme.of(context).colorScheme.primary,
                                        textColor: Theme.of(context).colorScheme.primary,
                                        onPressed: () {
                                          // save the form data
                                          _formKey.currentState?.save();
                                          Map<String, dynamic>? ticketData = _formKey.currentState?.value;
                                          String? tableNo = ticketData?['number_of_tables'];
                                          String? seatNo = ticketData?['number_of_seats'];
                                          if (tableNo == null || seatNo == null) {
                                            showCustomFlushBar(
                                              context: context,
                                              message: "Please select the number of tables and seats",
                                            );
                                            return;
                                          }
                                          _generateTicketNumber(tableNo, seatNo);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                _space,
                                _space,
                                FormBuilderTextField(
                                  name: 'first_name',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (String? value) {
                                    setState(() {});
                                  },
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.user,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gapPadding: 5.0,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                _space,
                                _space,
                                FormBuilderTextField(
                                  name: 'last_name',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  onChanged: (String? value) {
                                    setState(() {});
                                  },
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.user,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gapPadding: 5.0,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                _space,
                                _space,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: FormBuilderTextField(
                                        name: 'number_of_tables',
                                        initialValue: "1",
                                        // items: _tables
                                        //     .map((String value) => DropdownMenuItem<String>(
                                        //           value: value,
                                        //           child: Text(value),
                                        //         ))
                                        //     .toList(),
                                        keyboardType: TextInputType.number,
                                        onChanged: (String? value) {
                                          setState(() {});
                                        },
                                        onSaved: (String? value) {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Table Number",
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.table_solid,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            gapPadding: 5.0,
                                          ),
                                        ),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                      ),
                                    ),
                                    _space,
                                    Expanded(
                                      child: FormBuilderDropdown(
                                        name: 'number_of_seats',
                                        initialValue: _seats[0],
                                        items: _seats
                                            .map((String value) => DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {});
                                        },
                                        onSaved: (String? value) {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          labelText: "No of Seats",
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.chair_solid,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            gapPadding: 5.0,
                                          ),
                                        ),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                _space,
                                _space,
                                if (_isSaving)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.0.h,
                                      horizontal: 20.0.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const CircularProgressIndicator(),
                                  )
                                else
                                  CustomButton(
                                    title: "Save",
                                    isCaps: true,
                                    color: Theme.of(context).colorScheme.primary,
                                    onPressed: () => _saveTicket(),
                                    textSize: 6.0.sp,
                                  ),
                                _space,
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// Ticket View
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0.h,
                  horizontal: 0.0.w,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(0.0.r),
                ),
                child: Screenshot(
                  controller: screenshotController,
                  child: TicketView(formKey: _formKey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  const TicketView({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesTicket),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// Ticket Id
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.545,
              left: MediaQuery.of(context).size.width * 0.245,
              child: ticketController.activeTicket == null
                  ? AutoSizeText(
                      _formKey.currentState?.fields['ticket_number']?.value ?? "-",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                      ),
                    )
                  : AutoSizeText(
                      ticketController.activeTicket?.ticketNumber ?? "-", //$backendUrl/ticket/verify/
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                      ),
                    ),
            ),

            /// Table Number
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.481,
              left: MediaQuery.of(context).size.width * 0.246,
              child: ticketController.activeTicket == null
                  ? AutoSizeText(
                      _formKey.currentState?.fields['number_of_tables']?.value ?? "-",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : AutoSizeText(
                      ticketController.activeTicket?.numberOfTables.toString() ?? "-",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            ),

            /// Seat Number
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.412,
              left: MediaQuery.of(context).size.width * 0.248,
              child: ticketController.activeTicket == null
                  ? AutoSizeText(
                      "# ${_formKey.currentState?.fields['number_of_seats']?.value ?? "-"}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : AutoSizeText(
                      "# ${ticketController.activeTicket?.numberOfSeats.toString() ?? "-"}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            ),

            /// QR Code
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.040,
              left: MediaQuery.of(context).size.width * 0.189,
              child: ticketController.activeTicket == null
                  ? QrImageView(
                      data: '${_formKey.currentState?.fields['ticket_id']?.value}', //$backendUrl/ticket/verify/
                      version: QrVersions.auto,
                      size: 120.0,
                    )
                  : QrImageView(
                      data: ticketController.activeTicket?.qrCode ?? '12B54H8G',
                      version: QrVersions.auto,
                      size: 120.0,
                    ),
            ),
          ],
        );
      },
    );
  }
}
