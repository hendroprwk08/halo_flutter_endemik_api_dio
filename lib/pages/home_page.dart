import 'package:flutter/material.dart';
import '../model/endemik.dart';
import '../service/endemik_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Endemik> endemik = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final endemikService = EndemikService();
    final endemik = await endemikService.getData();

    setState(() {
      this.endemik = endemik;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('EndemikDB'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: List.generate(endemik == null ? 0 : endemik.length,
                  (index) {
                final endemikItem = endemik[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: {
                          'a_id': endemikItem.id,
                          'a_nama': endemikItem.nama,
                          'a_nama_latin': endemikItem.nama_latin,
                          'a_deskripsi': endemikItem.deskripsi,
                          'a_asal': endemikItem.asal,
                          'a_foto': endemikItem.foto,
                          'a_status': endemikItem.status,
                        });
                  },
                  child: Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          child: Image.network(
                            endemikItem.foto,
                            height: 170,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Text(endemikItem.nama.length >= 20
                            ? endemikItem.nama.substring(0, 20)
                            : endemikItem.nama)
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
