import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget {
  final Map ListData;
  const DetailProduk({super.key, required this.ListData});

  // const DetailProduk({super.key});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_produk.text = widget.ListData['id_produk'];
    nama_produk.text = widget.ListData['nama_produk'];
    harga_produk.text = widget.ListData['harga_produk'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('ID_Produk'),
              subtitle: Text(widget.ListData['id_produk']),
            ),
            ListTile(
              title: Text('Nama Produk'),
              subtitle: Text(widget.ListData['nama_produk']),
            ),
            ListTile(
              title: Text('Harga Produk'),
              subtitle: Text(widget.ListData['harga_produk']),
            )
          ],
        ),
      ),
    );
  }
}
