import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;

  void openDialog() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text((isExpense) ? 'Tambah Pengeluaran' : 'Tambah Pemasukan', style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: (isExpense) ? Colors.red : Colors.lightBlue
                  )),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: (isExpense) ? 'Tulis Pengeluaran' : 'Tulis Pemasukan',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {}, 
                    style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith((states) => (isExpense) ? Colors.red : Colors.lightBlue),
                      foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
                    ),
                    child: const Text('Simpan')
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _actionHeading(),
          const SizedBox(height: 10),
          _cardTransaction(),
          _cardTransaction(),
        ],
      ),
    );
  }

  Padding _cardTransaction() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          child: ListTile(
            title: const Text('Bensin Transport'),
            leading: (isExpense) ? _expenseIcon() : _incomeIcon(),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 10),
                Icon(Icons.edit, color: Colors.lightBlue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _actionHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          IconButton(onPressed: () => openDialog(), icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}

Container _incomeIcon() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8)
    ),
    child: const Icon(Icons.download, color: Colors.lightBlue),
  );
}

Container _expenseIcon() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8)
    ),
    child: const Icon(Icons.upload, color: Colors.red),
  );
}
