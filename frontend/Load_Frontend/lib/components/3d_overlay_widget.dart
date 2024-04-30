import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OverlayWidget {
  late OverlayEntry overlayEntry;
  Offset position;
  final Size size;
  final BuildContext context;

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;



  OverlayWidget({
    required this.context,

    this.position = const Offset(500, 500),
    this.size = const Size(500, 500),
  }) {
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
    overlayEntry = createOverlayEntry();
  }

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            position += details.delta;
            overlayEntry.markNeedsBuild();
          },
          child:
              Card(
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.white.withOpacity(0.8),
                  child: Center(
                    child: SfDataGrid(
                      source: employeeDataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: <GridColumn>[
                        GridColumn(
                            columnName: 'id',
                            label: Container(
                                padding: EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'ID',
                                ))),
                        GridColumn(
                            columnName: 'name',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Name'))),
                        GridColumn(
                            columnName: 'designation',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Designation',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'salary',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Salary'))),
                      ],
                    ),
                  ),
                ),
              )
          // Container(
          //   width: size.width,
          //   height: size.height,
          //   color: Colors.white.withOpacity(0.8),
          //   child: Center(
          //     child: SfDataGrid(
          //       source: employeeDataSource,
          //       columnWidthMode: ColumnWidthMode.fill,
          //       columns: <GridColumn>[
          //         GridColumn(
          //             columnName: 'id',
          //             label: Container(
          //                 padding: EdgeInsets.all(16.0),
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   'ID',
          //                 ))),
          //         GridColumn(
          //             columnName: 'name',
          //             label: Container(
          //                 padding: EdgeInsets.all(8.0),
          //                 alignment: Alignment.center,
          //                 child: Text('Name'))),
          //         GridColumn(
          //             columnName: 'designation',
          //             label: Container(
          //                 padding: EdgeInsets.all(8.0),
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   'Designation',
          //                   overflow: TextOverflow.ellipsis,
          //                 ))),
          //         GridColumn(
          //             columnName: 'salary',
          //             label: Container(
          //                 padding: EdgeInsets.all(8.0),
          //                 alignment: Alignment.center,
          //                 child: Text('Salary'))),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );

  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  void show() {
    Overlay.of(context)?.insert(overlayEntry);
  }

  void remove() {
    overlayEntry.remove();
  }
}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'designation', value: e.designation),
      DataGridCell<int>(columnName: 'salary', value: e.salary),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}