import 'package:award_ticket/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdmittedScreen extends StatefulWidget {
  const AdmittedScreen({super.key});

  @override
  State<AdmittedScreen> createState() => _AdmittedScreenState();
}

class _AdmittedScreenState extends State<AdmittedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Admitted Seats",
          fontSize: 18.0.sp,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          TicketModel ticketModel = ticketController.tickets[index];
          if (ticketModel.image == 'scanned') {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.0.h,
                horizontal: 10.0.w,
              ),
              color: Colors.green.withOpacity(0.7),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0.r,
                  backgroundColor: Colors.green,
                  child: CustomText(
                    "${ticketModel.firstName[0]} ${ticketModel.lastName[0]}",
                    fontSize: 8.0.sp,
                    color: Colors.white,
                  ),
                ),
                title: CustomText(
                  "${ticketModel.firstName} ${ticketModel.lastName}",
                  fontSize: 16.0.sp,
                  color: Colors.white,
                ),
                subtitle: CustomText(
                  ticketModel.ticketNumber,
                  fontSize: 12.0.sp,
                  color: Colors.white,
                ),
              ),
            );
          }
          return Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Gap(10.0.h);
        },
        itemCount: ticketController.tickets.length,
      ),
    );
  }
}
