import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: JasakuApp(), 
    debugShowCheckedModeBanner: false,
  ));
}

class JasakuApp extends StatelessWidget {
  const JasakuApp({super.key});

  Future<void> kirimPesanWA(String layanan, String subLayanan, String harga) async {
    String nomorAdmin = "6281247868253"; 
    String pesan = "Halo Admin JASAKU By. Roads, saya ingin memesan:\n\n"
                   "*Layanan Utama:* $layanan\n"
                   "*Pilihan:* $subLayanan\n"
                   "*Harga:* $harga";
    final Uri url = Uri.parse("https://wa.me/$nomorAdmin?text=${Uri.encodeComponent(pesan)}");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Gagal membuka WA');
    }
  }

  void tampilkanSubMenu(BuildContext context, String judul, List<Map<String, String>> pilihan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Pilih Jenis $judul", style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pilihan.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pilihan[index]['nama']!),
                subtitle: Text(pilihan[index]['harga']!, style: const TextStyle(color: Colors.green)),
                onTap: () {
                  Navigator.pop(context);
                  kirimPesanWA(judul, pilihan[index]['nama']!, pilihan[index]['harga']!);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JASAKU By. Roads"),
        backgroundColor: const Color(0xFFD32F2F),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        children: [
          _menuCard(context, "Jasa Pijat", Icons.spa, Colors.orange, [
            {'nama': 'Refleksi', 'harga': '100rb/jam'},
          ]),
          _menuCard(context, "Jasa Tukang", Icons.build, Colors.blue, [
            {'nama': 'Cuci Toren', 'harga': '150rb'},
          ]),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, String nama, IconData icon, Color color, List<Map<String, String>> sub) {
    return Card(
      child: InkWell(
        onTap: () => tampilkanSubMenu(context, nama, sub),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, color: color, size: 40), Text(nama)],
        ),
      ),
    );
  }
}
