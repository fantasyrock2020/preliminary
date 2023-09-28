import 'package:flutter/material.dart';
import 'package:preliminary/widget/table.dart';

import 'model/schedule.dart';
import 'model/table.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _cellWidth = 30;
  final double _cellHeight = 40;
  final double _titleWidth = 50;
  var table = TableData();
  ScheduleData? scheduleData;

  void _onCancel() {
    setState(() {
      scheduleData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: TableWidget(
          cellWidth: _cellWidth,
          cellHeight: _cellHeight,
          titleWidth: _titleWidth,
          onTap: (x, y) {
            String data = table.headers[x];
            if (table.headers.length - 1 - x >= 24) {
              data = '$data - ${table.headers[x + 24]}';
            }
            scheduleData = ScheduleData(
              x.toDouble(),
              y.toDouble(),
              (table.headers.length - 1 - x < 24
                      ? table.headers.length - x
                      : 24)
                  .toDouble(),
              y.toDouble(),
              data,
            );
            setState(() {});
          },
          data: [
            scheduleData != null
                ? Positioned(
                    top: scheduleData!.minY * _cellHeight,
                    left: scheduleData!.minX * _cellWidth,
                    child: GestureDetector(
                      onTap: _onCancel,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: scheduleData!.maxX * _cellWidth,
                        height: _cellHeight,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        child: Text(scheduleData!.data),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
          columns: table.columns.map((e) {
            return Container(
              width: _titleWidth,
              height: _cellHeight,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(e),
            );
          }).toList(),
          headers: table.headers.map((e) {
            int index = table.headers.indexOf(e);
            return SizedBox(
              height: _cellHeight,
              width: _cellWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    index % 12 == 0 ? table.headers[index] : '',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Text('|'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
