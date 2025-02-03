import 'package:flutter/material.dart';
import 'dart:convert';
import 'api.dart';
import 'package:http/http.dart' as http;

class ProdukTambah extends StatefulWidget {
  const ProdukTambah({super.key});
  @override
  State<StatefulWidget> createState() => ProdukTambahState();
}

class ProdukTambahState extends State<ProdukTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController merkController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController namapelangganController = TextEditingController();



  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.Insert),
      body: {
        'merk': merkController.text,
        'harga': hargaController.text,
        'nama_pembeli': namapelangganController.text,
      },
    );
  }

  void _onConfirm(BuildContext context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Daftar Pembeli",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _inputField("Merk", merkController, Icons.tag_rounded),
            _inputField("Harga", hargaController, Icons.price_change),
            _inputField("Nama Pelanggan", namapelangganController, Icons.person_2_outlined),


            const SizedBox(height: 20.0),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }


  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        elevation: 5.0,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      child: const Text(
        'Tambah',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
