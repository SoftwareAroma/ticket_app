import 'package:award_ticket/index.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  static final TicketController _instance = Get.find<TicketController>();
  static TicketController get instance => _instance;

  final RxList<TicketModel> _tickets = <TicketModel>[].obs;
  final _activeTicket = Rxn<TicketModel>(null);

  addTicket(TicketModel ticket) {
    _tickets.add(ticket);
    update();
  }

  addTickets(List<TicketModel> tickets) {
    _tickets.clear();
    _tickets.addAll(tickets);
    update();
  }

  removeTicket(TicketModel ticket) {
    _tickets.remove(ticket);
    update();
  }

  clearTickets() {
    _tickets.clear();
    update();
  }

  updateActiveTicket(TicketModel ticket) {
    _activeTicket.value = ticket;
    update();
  }

  clearActiveTicket() {
    _activeTicket.value = null;
    update();
  }

  TicketModel searchTicket(String id) {
    TicketModel model = _tickets.firstWhere((TicketModel ticket) => ticket.ticketId == id);
    updateActiveTicket(model);
    return model;
  }

  Future<bool> saveScannedTicket(String id) async {
    Map<String, dynamic> ticket = {
      'image': "scanned",
    };
    TicketModel? ticketModel = await helperMethods.updateTicket(id: id, data: ticket);
    if (ticketModel == null) return false;
    return true;
  }

  List<TicketModel> filterTickets(String id) {
    return _tickets.where((TicketModel ticket) => ticket.ticketId == id).toList();
  }

  List<TicketModel> get tickets => _tickets;
  TicketModel? get activeTicket => _activeTicket.value;
}
