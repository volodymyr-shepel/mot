import 'package:flutter/material.dart';

class ProductSpecification extends StatelessWidget {
  final Map<String, dynamic>? specifications;

  const ProductSpecification({Key? key, this.specifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> getSpecificationRows() {
      if (specifications == null || specifications!.isEmpty) {
        return [];
      }

      List<DataRow> rows = [];
      specifications!.forEach((key, value) {
        List<Widget> valueWidgets = [];

        // Split long values into multiple lines
        List<String> valueLines = value.toString().split('\n');
        for (String line in valueLines) {
          valueWidgets.add(Text(
            line,
            style: TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ));
        }

        rows.add(DataRow(cells: [
          DataCell(Text(
            key,
            style: TextStyle(fontSize: 11),
          )),
          DataCell(
            Container(
              alignment: Alignment.center, // Center both horizontally and vertically
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: valueWidgets,
              ),
            ),
          ),
        ]));
      });

      return rows;
    }

    if (specifications == null || specifications!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No specifications available", textAlign: TextAlign.center),
      );
    }

    return DataTable(
      columnSpacing: 16,
      headingRowHeight: 0,
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: getSpecificationRows(),
    );
  }
}
