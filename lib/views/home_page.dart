import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/data_list_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class CustomDataTableSource extends DataTableSource {
  final List<DataRow> _dataRows;

  CustomDataTableSource(this._dataRows);

  @override
  DataRow? getRow(int index) {
    if (index >= _dataRows.length) return null;
    return _dataRows[index];
  }

  @override
  int get rowCount => _dataRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context);
    final dataRows = provider.data?.heliverseList?.map((e) {
      return DataRow(
          color: MaterialStateProperty.resolveWith((states) {
            if (e.id!.isOdd) {
              return Colors.grey.withOpacity(0.3);
            }
            return null;
          }),
          cells: [
            DataCell(Text(e.id.toString())),
            DataCell(
              CircleAvatar(
                radius: 20,
                child: Image(
                  image: NetworkImage(e.avatar.toString()),
                  fit: BoxFit.fill,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            DataCell(Text(e.firstName.toString())),
            DataCell(Text(e.lastName.toString())),
            DataCell(Text(e.email.toString())),
            DataCell(Text(e.gender.toString())),
            DataCell(Text(e.domain.toString())),
            DataCell(
              e.available.toString() == "true"
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.do_not_disturb_alt_outlined,
                      color: Colors.red,
                    ),
            ),
          ]);
    }).toList();

    provider.getData(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Heliverse App Assignment'),
      ),
      body: provider.data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PaginatedDataTable(
                        rowsPerPage: 10,
                        showCheckboxColumn: true,
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('AVATAR')),
                          DataColumn(label: Text('FIRST NAME')),
                          DataColumn(label: Text('LAST NAME')),
                          DataColumn(label: Text('EMAIL ID')),
                          DataColumn(label: Text('GENDER')),
                          DataColumn(label: Text('DOMAIN')),
                          DataColumn(label: Text('AVAILABLE')),
                        ],
                        source: CustomDataTableSource(dataRows!),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print(textEditingController.text);
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Add to Team",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        onPressed: () {},
        child: const Icon(Icons.filter_alt_rounded),
      ),
    );
  }
}
