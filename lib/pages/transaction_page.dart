import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  List<String> list = ['Kebutuhan', 'Pendidikan', 'Transportasi'];
  late String dropdownValue = list.first;

  TextEditingController dateController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi', style: TextStyle(
          fontSize: 18
        )),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Switch(
                      value: isExpense, 
                      onChanged: (bool value) {
                        setState(() {
                          isExpense = value;
                        });
                      },
                      inactiveTrackColor: Colors.lightBlue[200],
                      inactiveThumbColor: Colors.lightBlue,
                      activeColor: Colors.red,
                    ),
                
                    const SizedBox(width: 10),
                
                    Text((isExpense) ? 'Expense' : 'Income', style: GoogleFonts.montserrat(
                      fontSize: 14, 
                    ))
                  ]
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    label: Text('Nominal')
                  ),
                ),
              ),
            
              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Kategori', style: GoogleFonts.montserrat(
                  fontSize: 14, 
                )),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  items: list.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  }, 
                ),
              ),
            
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context, 
                      firstDate: DateTime(2020), 
                      lastDate: DateTime(2099),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      dateController.text = formattedDate;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Transaksi'
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Center(
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: const Text('Simpan')
                ),
              )
            ],
          )
        ),
      )
    );
  }
}