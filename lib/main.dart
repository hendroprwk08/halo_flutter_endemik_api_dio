import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halo Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var jsonList;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      /* dengan base option
      var response = await Dio(BaseOptions(
        baseUrl: 'https://api.jikan.moe/v4/',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: 'application/json',
      )).get('recommendations/anime');
      */

      var response = await Dio()
          .get('https://hendroprwk08.github.io/data_endemik/endemik.json');

      // jika berhasil
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data as List; // jika tak ada key
          // jsonList = response.data['data'] as List; // jika ada key
          isLoading = false;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
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
          children: List.generate(jsonList == null ? 0 : jsonList.length, (index) { // 10 data saja
            return Card(
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
                      jsonList[index]['foto'],
                      height: 170,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Text( jsonList[index]['nama'].length >= 20 ? jsonList[index]['nama'].substring(0, 10) : jsonList[index]['nama'])
                ],
              ),
            );
          }),
        )
    );
  }
}
