import 'package:flutter/material.dart';

typedef TableTapCallback = void Function(int x, int y);

class TableWidget extends StatelessWidget {
  final double cellWidth;
  final double cellHeight;
  final double titleWidth;
  final List<Widget> columns;
  final List<Widget> headers;
  final TableTapCallback onTap;
  final List<Widget> data;

  const TableWidget({
    super.key,
    required this.cellWidth,
    required this.cellHeight,
    required this.titleWidth,
    required this.columns,
    required this.headers,
    required this.onTap,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          SizedBox(
            width: titleWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: cellHeight,
                  color: Colors.blue,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: columns.length,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return columns[index];
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    color: Colors.green,
                    height: cellHeight,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: headers.length,
                      itemBuilder: (context, index) {
                        return headers[index];
                      },
                    ),
                  ),
                  SizedBox(
                    height: columns.length * cellHeight,
                    child: Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: headers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, indexX) {
                            return SizedBox(
                              width: cellWidth,
                              child: ListView.builder(
                                itemCount: columns.length,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => onTap(indexX, index),
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      height: cellHeight,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: .5,
                                            color: Colors.grey[300]!,
                                          ),
                                          bottom: BorderSide(
                                            width: .5,
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        color: index % 2 != 0
                                            ? Colors.grey[200]
                                            : Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ...data
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
