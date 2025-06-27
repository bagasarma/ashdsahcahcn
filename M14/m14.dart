import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

class M14 extends StatefulWidget {
  const M14({super.key});

  @override
  State<M14> createState() => _M14State();
}

class _M14State extends State<M14> {
  double sliderVal = 0;
  String tgl = "";
  String tanggal = "";
  String tanggal2 = "";
  String tanggal3 = "";
  String waktu = "";
  String waktu2 = "";
  List<String> bln =
      "Januari Februari Maret April Mei Juni Juli Agustus September Oktober November Desember"
          .split(" ");
  final TextEditingController _dateRangeController = TextEditingController();

  String getStringTanggal(DateTime dt) {
    return "${dt.day} ${bln[dt.month - 1]} ${dt.year}";
  }

  String getStringWaktu(TimeOfDay td) {
    return "${td.hour.toString().padLeft(2, "0")}:${td.minute.toString().padLeft(2, "0")} WIB";
  }

  _pilihTanggal(BuildContext context) async {
    var tmp = await showDatePicker(
        context: context,
        firstDate: DateTime(2025, 1),
        lastDate: DateTime(2025, 12),
        initialDate: DateTime.now());
    if (tmp != null) {
      setState(() {
        tanggal2 = getStringTanggal(tmp);
        tanggal = tmp.toString();
      });
    }
  }

  DateTimeRange? selectedDateRange;

  _pilihTanggal2(BuildContext context) async {
    var tmp = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2025, 1),
        lastDate: DateTime(2025, 12));
    if (tmp != null) {
      setState(() {
        selectedDateRange = tmp;
        _dateRangeController.text = "${getStringTanggal(tmp.start)} - ${getStringTanggal(tmp.end)}";
      });
    }
  }

  _pilihWaktu(BuildContext context) async {
    var tmp = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 1));
    if (tmp != null) {
      setState(() {
        waktu = getStringWaktu(tmp);
      });
    }
  }

  List<DateTime> _getDateRangeList() {
    if (selectedDateRange == null) return [];
    
    List<DateTime> dates = [];
    DateTime current = selectedDateRange!.start;
    
    while (current.isBefore(selectedDateRange!.end) || 
           current.isAtSameMomentAs(selectedDateRange!.end)) {
      dates.add(current);
      current = current.add(Duration(days: 1));
    }
    
    return dates;
  }

  @override
  void dispose() {
    _dateRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final dateList = _getDateRangeList();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(children: [
            Icon(Icons.calendar_today),
            Text("${(DateTime.now())}"),
          ],)
          
          // leading: IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today))
          ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("")),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _dateRangeController,
                  textAlign: TextAlign.center, 
                  readOnly: true,
                  onTap: () {
                    _pilihTanggal2(context);
                  },
                ),
              ),
              Expanded(child: Text("")),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: ListView.builder(
                  itemCount: dateList.length,
                  itemBuilder: (context, index) {
                    final date = dateList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
                      color: index % 2 == 0 ? Colors.blue[100] : Colors.red[100],
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            "${date.day}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text(
                          bln[date.month - 1],
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Text(
                          "${date.year}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
