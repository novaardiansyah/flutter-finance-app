import 'package:finance_app/models/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;

  final AppDatabase database = AppDatabase();

  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();

    return await database.into(database.categories)
      .insertReturning(
        CategoriesCompanion.insert(name: name, type: type, createdAt: now, updatedAt: now)
      );
  }

  Future update(int id, String name) async {
    return await database.updateCategory(id, name);
  }

  Future delete(int id) async {
    return await database.deleteCategory(id);
  }

  Future<List<Category>> getByType(int type) async {
    return await database.getByType(type);
  }

  void openDialog(Category? category) {
    String actionTitle = 'Tambah';

    if (category != null) {
      categoryNameController.text = category.name;
      actionTitle = 'Edit';
    }

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text((isExpense) ? '$actionTitle Kategori Pengeluaran' : '$actionTitle Kategori Pemasukan', style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: (isExpense) ? Colors.red : Colors.lightBlue
                  )),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: (isExpense) ? 'Tulis Pengeluaran' : 'Tulis Pemasukan',
                    ),
                    controller: categoryNameController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (category == null) {
                        insert(categoryNameController.text, (isExpense) ? 1 : 2);
                      } else {
                        update(category.id, categoryNameController.text);
                      }

                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      setState(() {
                        categoryNameController.clear(); 
                      });
                    }, 
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

          FutureBuilder <List<Category>>(
            future: getByType((isExpense) ? 1 : 2), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: CircularProgressIndicator()
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text('Error: (${snapshot.error})', style: const TextStyle(
                    color: Colors.red
                  ))
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text('Belum ada data kategori tersedia.'),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Category category = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          child: ListTile(
                            title: Text(category.name),
                            leading: (isExpense) ? _expenseIcon() : _incomeIcon(),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    delete(category.id);
                                    setState(() {
                                      
                                    });
                                  }, 
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    openDialog(category);
                                  }, 
                                  icon: const Icon(Icons.edit, color: Colors.lightBlue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                );
              }
            },
          ),
        ],
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
          IconButton(onPressed: () => openDialog(null), icon: const Icon(Icons.add))
        ],
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
}