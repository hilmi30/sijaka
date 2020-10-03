import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaka/utils/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String dropdownValue = "Banjarmasin Tengah";

  @override
  void initState() {
    super.initState();
    // token();
  }

  void token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    ApiServices().dataPresentase(token);
  }

  @override
  Widget build(BuildContext context) {

    Widget ketuntasan() {
      return DataTable(
        showBottomBorder: true,
        columns: [
          DataColumn(label: Text('Kecamatan')),
          DataColumn(
            label: Text('Tuntas'),
            numeric: true
          ),
          DataColumn(
            label: Text('Non Tuntas'),
            numeric: true
          )
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Banjarmasin Tengah')),
            DataCell(Text('40')),
            DataCell(Text('4'))
          ]),
          DataRow(cells: [
            DataCell(Text('Banjarmasin Barat')),
            DataCell(Text('20')),
            DataCell(Text('3'))
          ])
        ],
      );
    }

    Widget presentase() {
      return DataTable(
        showBottomBorder: true,
        columns: [
          DataColumn(label: Text('Kelurahan')),
          DataColumn(
            label: Text('Persen Tuntas (%)'),
            numeric: true
          ),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Sungai Jingah')),
            DataCell(Text('40%'))
          ]),
          DataRow(cells: [
            DataCell(Text('Sungai Miai')),
            DataCell(Text('20%'))
          ])
        ],
      );
    }

    Widget dropDown() {
      return DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Banjarmasin Barat', 'Banjarmasin Tengah', 'Banjarmasin Utara', 'Banjarmasin Selatan']
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList(),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kota Banjarmasin'),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            )
          ],
        ),
        body: ListView(
          children: [
            ketuntasan(),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  dropDown()
                ]
              ),
            ),
            presentase(),
          ],
        )
      )
    );
  }
}