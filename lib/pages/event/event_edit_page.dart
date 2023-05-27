import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glucovie/models/event.dart';
import 'package:glucovie/utils.dart';
import 'package:provider/provider.dart';

import '../../api/apiClient.dart';
import '../../constants/text_styles.dart';
import '../../provider/event_provider.dart';

class EventEditPage extends StatefulWidget {
  final Event? event;

  const EventEditPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          actions: buildEditingActions(),
          backgroundColor: Colors.purple,
          title: Text(
            'ADAUGĂ EVENIMENT',
            style: appBarTitleTS,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                buildDateTimePickers(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed:_handleSaveEvent,
          icon: const Icon(Icons.done),
          label: const Text("Salvează"),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
        onFieldSubmitted: (_) {},
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Titlu",
        ),
        controller: titleController,
        validator: (title) => title != null && title.isEmpty
            ? "Acest câmp este obligatoriu"
            : null,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: "DE LA",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropDownField(
              text: Utils.toTime(fromDate),
              onClicked: () => pickFromDateTime(pickDate: false),
            )),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: "PÂNĂ LA",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropDownField(
              text: Utils.toTime(toDate),
              onClicked: () => pickToDateTime(pickDate: false),
            )),
          ],
        ),
      );

  Widget buildDropDownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          child,
        ],
      );

  final ApiClient _apiClient = ApiClient();

  Future<void> _handleSaveEvent() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Se procesează...'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> data = {
        "title": titleController.text,
        "from": fromDate.toString(),
        "to": toDate.toString(),
      };

      Response res = await _apiClient.saveEvent(data);
      if (res.statusCode == 200) {
        final event = Event(
          title: titleController.text,
          description: 'description',
          from: fromDate,
          to: toDate,
          isAllDay: false,
        );

        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.addEvent(event);

        Navigator.of(context).pop();
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${res.data['error']}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }

  // Future saveForm() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (isValid) {
  //     final event = Event(
  //       title: titleController.text,
  //       description: 'description',
  //       from: fromDate,
  //       to: toDate,
  //       isAllDay: false,
  //     );
  //
  //     final provider = Provider.of<EventProvider>(context, listen: false);
  //     provider.addEvent(event);
  //
  //     Navigator.of(context).pop();
  //   }
  // }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.purple,
              hintColor: Colors.purple,
              colorScheme: const ColorScheme.light(primary: Color(0xFFBD49DE)),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        },
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.purple,
              hintColor: Colors.purple,
              colorScheme: const ColorScheme.light(primary: Color(0xFFBD49DE)),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        },
      );
      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }
}
