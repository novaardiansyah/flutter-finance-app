import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:finance_app/models/database.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  // List<String> list = ['Kebutuhan', 'Pendidikan', 'Transportasi'];
  // late String dropdownValue = list.first;

  TextEditingController amountController = TextEditingController(); 
  TextEditingController dateController = TextEditingController(); 
  TextEditingController nameController = TextEditingController(); 
  Category? selectedCategory;

  final AppDatabase database = AppDatabase();

  Future insert(int amount, String name, int categoryId, DateTime date, int type) async {
    DateTime now = DateTime.now();

    final row = await database.into(database.transactions)
      .insertReturning(
        TransactionsCompanion.insert(name: name, categoryId: categoryId, date: date, amount: amount, createdAt: now, updatedAt: now)
      );
    
    print('hasil insert: ' + row.toString());
  } 

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getByType(type);
  }

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
                          selectedCategory = null;
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
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    label: Text('Nominal')
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    label: Text('Keterangan')
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
              
              FutureBuilder<List<Category>>(
                future: getAllCategory((isExpense) ? 1 : 2), 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16),
                      child: CircularProgressIndicator()
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text('Belum ada data kategori tersedia.', style: TextStyle(
                            color: Colors.red,
                          )),
                        ],
                      ),
                    );
                  } else {
                    selectedCategory = snapshot.data!.first;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton<Category>(
                        isExpanded: true,
                        value: selectedCategory,
                        icon: const Icon(Icons.arrow_downward),
                        items: snapshot.data!.map((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(), 
                        onChanged: (Category? value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        }, 
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 8),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
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
                    labelText: 'Tanggal'
                  ),
                ),
              ),

              const SizedBox(height: 26),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith((states) => Colors.lightBlue),
                        foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
                      ),
                      onPressed: () {
                        insert(int.parse(amountController.text), nameController.text, selectedCategory!.id, DateTime.parse(dateController.text), (isExpense ? 1 : 2));
                      }, 
                      child: const Text('Simpan Transaksi')
                    )
                  ]
                ),
              )
            ],
          )
        ),
      )
    );
  }
}