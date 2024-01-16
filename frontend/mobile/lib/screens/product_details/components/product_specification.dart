import 'package:flutter/material.dart';

// ProductSpecificationsTable widget
class ProductSpecification extends StatelessWidget {
  final Map<String, dynamic>? specifications;

  const ProductSpecification({super.key, this.specifications});

  @override
  Widget build(BuildContext context) {
    // Function to generate specification rows
    List<DataRow> getSpecificationRows() {
      if (specifications == null || specifications!.isEmpty) {
        return [];
      }
      return specifications!.entries.map((spec) => DataRow(cells: [
        DataCell(Text(spec.key)),
        DataCell(Text(spec.value.toString())),
      ]))
          .toList();
    }

    // Check if there are no specifications to display
    if (specifications == null || specifications!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No specifications available", textAlign: TextAlign.center),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Feature')),
          DataColumn(label: Text('Detail')),
        ],
        rows: getSpecificationRows(),
      ),
    );
  }
}

