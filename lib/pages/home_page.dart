import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardIncomeExpense(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Transactions', style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )),
            ),

            // ! LIST TRANSACTION
            _cardListExpense(),
            _cardListIncome()
          ],
        )
      ),
    );
  }

  Padding _cardListIncome() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Card(
        elevation: 10,
        child: ListTile(
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Icon(Icons.edit, color: Colors.lightBlue),
            ],
          ),
          title: const Text('Rp. 120.000'),
          subtitle: const Text('Bonus'),
          leading: _incomeIcon(),
        ),
      ),
    );
  }

  Padding _cardListExpense() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Card(
        elevation: 10,
        child: ListTile(
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Icon(Icons.edit, color: Colors.lightBlue),
            ],
          ),
          title: const Text('Rp. 20.000'),
          subtitle: const Text('Makan Siang'),
          leading: _expenseIcon(),
        ),
      ),
    );
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

  Padding _cardIncomeExpense() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _incomeIcon(),

                const SizedBox(width: 15),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Income', style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                    )),
                    const SizedBox(height: 6),
                    Text('Rp. 3.800.000', style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                    )),
                  ],
                )
              ],
            ),

            Row(
              children: [
                _expenseIcon(),

                const SizedBox(width: 15),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expense', style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                    )),
                    const SizedBox(height: 6),
                    Text('Rp. 2.100.000', style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                    )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}