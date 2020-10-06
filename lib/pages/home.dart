import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaka/models/data_kelurahan.dart';
import 'package:sijaka/utils/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String dropdownValue;
  Map<String, dynamic> dataTuntas = Map();
  List dataKecamatan = [];
  String token = "";
  List<DataKelurahan> dataKelurahan = [];
  bool loading = true;
  String namaKota = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    dataKelurahan.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    ApiServices().getDataKota(token).then((dataKota) {
      if (dataKota == null) {
        return;
      } 
      setState(() {
        loading = !loading;

        namaKota = prefs.getString("full_name");

        dataKecamatan = dataKota.data['data_kec'];
        if (dropdownValue == null) dropdownValue = dataKecamatan[0];
        dataTuntas = dataKota.data['ketuntasan'];

        Map<String, dynamic> kelurahan = dataKota.data['dataProvider'][dropdownValue];
        kelurahan.keys.forEach((element) {
          var kel = kelurahan[element]['kelurahan'];
          var presentase = kelurahan[element]['presentase'];
          dataKelurahan.add(
            DataKelurahan(kelurahan: kel, presentase: presentase)
          );
        });

        print(dataKelurahan[0].kelurahan);
      });
    });
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
        rows: dataKecamatan.map((kec) => DataRow(cells: [
          DataCell(Text(kec)),
          DataCell(Text(dataTuntas['tuntas'][kec].toString())),
          DataCell(Text(dataTuntas['belum_tuntas'][kec].toString()))
        ])).toList(),
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
        rows: dataKelurahan.map((data) => DataRow(cells: [
          DataCell(Text(data.kelurahan)),
          DataCell(Text('${data.presentase.toString()}%'))
        ])).toList(),
      );
    }

    Widget dropDown() {
      return DropdownButton(
        value: dropdownValue,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            loading = !loading;
            dropdownValue = newValue;
            getData();
          });
        },
        items: dataKecamatan
          .map((value) {
            return DropdownMenuItem(
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
          title: Text(namaKota ?? ""),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  loading = !loading;
                  dropdownValue = null;
                  getData();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Visibility(
              visible: loading,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: LinearProgressIndicator(),
              ),
            ),
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