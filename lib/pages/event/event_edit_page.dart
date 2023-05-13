import 'package:flutter/material.dart';
import 'package:glucovie/models/event.dart';
import 'package:glucovie/utils.dart';

import '../../constants/text_styles.dart';

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
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
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

  List<Widget> buildEditingActions() =>
      [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () => {},
          icon: const Icon(Icons.done),
          label: const Text("Salvează"),
        ),
      ];

  Widget buildTitle() =>
      TextFormField(
        style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
        onFieldSubmitted: (_) {},
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Titlu",
        ),
        controller: titleController,
        validator: (title) =>
        title != null && title.isEmpty
            ? "Acest câmp este obligatoriu"
            : null,
      );

  Widget buildDateTimePickers() =>
      Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() =>
      buildHeader(
        header: "DE LA",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () {},
                )),
            Expanded(
                child: buildDropDownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () {},
                )),
          ],
        ),
      );

  Widget buildTo() =>
      buildHeader(
        header: "PĂNĂ LA",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(toDate),
                  onClicked: () {},
                )),
            Expanded(
                child: buildDropDownField(
                  text: Utils.toTime(toDate),
                  onClicked: () {},
                )),
          ],
        ),
      );


  Widget buildDropDownField(
      {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) =>
      Column(
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

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
        fromDate, pickDate: pickDate);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate,
      }) async {
    if (pickDate) {
      final date = showDatePicker(context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute, seconds: initialDate.second);

    }
  }
}
