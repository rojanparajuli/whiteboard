import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whiteboard/controller/drawing_controller.dart';
import 'package:whiteboard/widget/drawing_area.dart';
import 'package:whiteboard/widget/drawing_painter.dart';

class Whiteboard extends StatelessWidget {
  final DrawingController controller = Get.put(DrawingController());

  Whiteboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: 
            const Text(
              "Board",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
        
          actions: [
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isDarkMode.value ? Icons.circle : Icons.circle,
                  color:
                      controller.isDarkMode.value ? Colors.yellow : Colors.red,
                ),
                onPressed: () {
                  controller.toggleTheme();
                },
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.circle,
                color: Colors.blue,
              ),
              onPressed: () {
                controller.clearPoints();
                // Get.snackbar(
                //   'Cleared',
                //   'Objects cleared successfully',
                // );
              },
            ),
            PopupMenuButton<Color>(
              icon: const Icon(Icons.circle, color: Colors.green),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<Color>(
                  value: Colors.black,
                  child: Text("Black brush",
                      style: TextStyle(color: Colors.black)),
                ),
                const PopupMenuItem<Color>(
                  value: Colors.green,
                  child: Text("Green brush",
                      style: TextStyle(color: Colors.green)),
                ),
                const PopupMenuItem<Color>(
                  value: Colors.blue,
                  child:
                      Text("Blue brush", style: TextStyle(color: Colors.blue)),
                ),
                const PopupMenuItem<Color>(
                  value: Colors.red,
                  child: Text(
                    "Red brush",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const PopupMenuItem<Color>(
                  value: Colors.white,
                  child: Text(
                    "White brush",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
              onSelected: (Color color) {
                controller.changeColor(color);
              },
            ),
          ],
        ),
        backgroundColor:
            controller.isDarkMode.value ? Colors.black : Colors.grey[200]!,
        body: GestureDetector(
          onPanDown: (details) {
            controller.addPoint(DrawingArea(
              point: details.localPosition,
              areaPaint: Paint()
                ..color = controller.selectedColor.value
                ..strokeCap = StrokeCap.round
                ..isAntiAlias = true
                ..strokeWidth = controller.strokeWidth.value,
            ));
          },
          onPanUpdate: (details) {
            controller.addPoint(DrawingArea(
              point: details.localPosition,
              areaPaint: Paint()
                ..color = controller.selectedColor.value
                ..strokeCap = StrokeCap.round
                ..isAntiAlias = true
                ..strokeWidth = controller.strokeWidth.value,
            ));
          },
          onPanEnd: (details) {
            controller.addPoint(null);
          },
          child: Obx(
            () => CustomPaint(
              painter: DrawingPainter(pointsList: controller.points.toList()),
              size: Size.infinite,
              willChange: true,
              isComplex: true,
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.clear),
        //   onPressed: () {
        //     controller.clearPoints();
        //   },
        // ),
      ),
    );
  }
}
