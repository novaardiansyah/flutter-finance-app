import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  Future<dynamic> requestAPI() async {
    final response = await http.get(Uri.parse("https://api.coincap.io/v2/assets"));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Terjadi kesalahan error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleBack() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cyrpto Currency API", style: GoogleFonts.poppins(
          color: Colors.white, 
          fontSize: 16
        )),
        backgroundColor: Colors.lightBlue,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => handleBack(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        )
      ),
      body: FutureBuilder(
        future: requestAPI(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Text('Data Tidak Tersedia!'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final crypto = snapshot.data![index];

                    return Card(
                      elevation: 3,
                      child: ListTile(
                        trailing: Text("${double.parse(crypto!['changePercent24Hr']).toStringAsFixed(2)}% (rank: ${crypto!['rank']})", style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                        title: Text("${crypto!['name']} (${crypto!['symbol']})", style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400
                        )),
                        subtitle: Text("${double.parse(crypto!['priceUsd']).toStringAsFixed(2)} \$USD", style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold
                        )),
                      ),
                    );
                  },
                ),
              );
            }
        },
      ),
    );
  }
}