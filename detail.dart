import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'edit.dart';
import 'mitems.dart';

class ProdukDetail extends StatefulWidget {
  final ItemModel sw;
  ProdukDetail({required this.sw});

  @override
  State<StatefulWidget> createState() => ProdukDetailState();
}

class ProdukDetailState extends State<ProdukDetail> {
  void deleteProduk(context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.Delete),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if (data['success']) {
      _showToast("Penghapusan Data Berhasil", Colors.green);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          title: Text("Konfirmasi Penghapusan",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Batal",
                  style: TextStyle(color: Colors.black54)),
            ),
            ElevatedButton(
              onPressed: () => deleteProduk(context),
              child: Text("Hapus"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.motorcycle,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              "Detail Pelanggan",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Detail Produk",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300, thickness: 1),
                SizedBox(height: 8),
                _buildDetailRow("Merk", widget.sw.merk),
                _buildDetailRow("Harga", widget.sw.harga.toString()),
                _buildDetailRow("Nama Pelanggan", widget.sw.nama_pembeli),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProdukEdit(sw: widget.sw)),
        ),
        label: const Text(
          "Edit Pelanggan",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
