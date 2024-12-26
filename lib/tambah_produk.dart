import 'package:app_produk/halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();
  bool _isLoading = false; // Track loading state

  // Function to save data
  Future<bool> _simpan() async {
    try {
      final respon = await http
          .post(Uri.parse('https://localhost/api_produk/create.php'), body: {
        'nama_produk': nama_produk.text,
        'harga_produk': harga_produk.text,
      });

      if (respon.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to save data');
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Product Name Input
              TextFormField(
                controller: nama_produk,
                decoration: InputDecoration(
                  hintText: 'Nama Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Product Price Input
              TextFormField(
                controller: harga_produk,
                decoration: InputDecoration(
                  hintText: 'Harga Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harga produk tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Save Button
              _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          bool success = await _simpan();

                          setState(() {
                            _isLoading = false;
                          });

                          final snackBar = SnackBar(
                            content: Text(
                              success
                                  ? 'Data berhasil disimpan'
                                  : 'Data gagal disimpan',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          if (success) {
                            // Navigate back to HalamanProduk
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HalamanProduk(),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      },
                      child: Text('Simpan'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
