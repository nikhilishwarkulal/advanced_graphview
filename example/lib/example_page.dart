import 'package:advanced_graphview/advanced_graphview.dart';
import 'package:advanced_graphview/game_screen.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final AdvancedGraphviewController advancedGraphviewController =
      AdvancedGraphviewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedGraphviewController.setZoomValue(zoom: 1.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getFirst(),
    );
  }

  Widget getSecond() {
    return AdvancedGraphview(
      nodePadding: 50,
      nodeSize: 200,
      isDebug: false,
      graphNode: getExampleNode(),
      backgroundColor: Colors.black,
      advancedGraphviewController: advancedGraphviewController,
      onDrawLine: (lineFrom, lineTwo) {
        return Paint()
          ..color = Colors.blue
          ..strokeWidth = 1.5;
      },
      builder: (GraphNode graphNode) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                (graphNode as TestGraphNode).value,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getThird() {
    TestGraphNode getExampleNode() {
      return TestGraphNode(
        id: '1',
        value: "Advanced Graphview",
        graphNodes: [
          TestGraphNode(
            id: "2",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "3",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "4",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "5",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "6",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "7",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "8",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "9",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "10",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "11",
            graphNodes: [],
            value: "Example",
          ),
          TestGraphNode(
            id: "12",
            graphNodes: [],
            value: "Example",
          ),
        ],
      );
    }

    return AdvancedGraphview(
      nodePadding: 10,
      nodeSize: 200,
      isDebug: false,
      graphNode: getExampleNode(),
      backgroundColor: Colors.black,
      pixelRatio: 10,
      advancedGraphviewController: advancedGraphviewController,
      onDrawLine: (lineFrom, lineTwo) {
        return Paint()
          ..color = Colors.red
          ..strokeWidth = 1;
      },
      builder: (GraphNode graphNode) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                "assets/images/screensh/${graphNode.id == "1" ? "dad" : "kid"}.png",
                width: graphNode.id == "1" ? 200 : 50,
                height: graphNode.id == "1" ? 200 : 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getFirst() {
    TestGraphNode getExampleNode() {
      return TestGraphNode(
        id: '1',
        value: "Advanced Graphview",
        graphNodes: [],
      );
    }

    return AdvancedGraphview(
      nodePadding: 50,
      nodeSize: 200,
      isDebug: false,
      graphNode: getExampleNode(),
      backgroundColor: Colors.black,
      pixelRatio: 10,
      onNodeTap: (graphNode) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Tap Event detected ${graphNode.id}"),
        ));
      },
      advancedGraphviewController: advancedGraphviewController,
      onDrawLine: (lineFrom, lineTwo) {
        if ((lineFrom.id == "1" && lineTwo.id == "2") ||
            (lineFrom.id == "2" && lineTwo.id == "1")) {
          return Paint()
            ..color = Colors.red
            ..strokeWidth = 1;
        }
        return Paint()
          ..color = Colors.blue
          ..strokeWidth = 1;
      },
      builder: (GraphNode graphNode) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                "assets/images/screensh/${(int.parse(graphNode.id) % 6 == 0 ? 1 : int.parse(graphNode.id) % 6).floor()}.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}

////--------Test --------

class TestGraphNode extends GraphNode {
  @override
  final String id;

  final String value;

  @override
  final List<GraphNode> graphNodes;
  TestGraphNode({
    required this.id,
    required this.graphNodes,
    required this.value,
  });
}

TestGraphNode getExampleNode() {
  final test = TestGraphNode(
    id: "3",
    graphNodes: [],
    value: "Assets",
  );
  return TestGraphNode(
    id: '1',
    value: "Advanced Graphview",
    graphNodes: [
      TestGraphNode(
        id: "2",
        graphNodes: [
          TestGraphNode(
            id: "5",
            graphNodes: [],
            value: "Hack Mode",
          ),
          TestGraphNode(
            id: "6",
            graphNodes: [],
            value: "Test Hack ",
          ),
          TestGraphNode(
            id: "7",
            graphNodes: [],
            value: "Beta Rays",
          ),
        ],
        value: "Example",
      ),
      test,
      TestGraphNode(
        id: "4",
        graphNodes: [
          TestGraphNode(
            id: "8",
            graphNodes: [],
            value: "Graphic Test",
          ),
          TestGraphNode(
            id: "9",
            graphNodes: [],
            value: "Gama Rays",
          ),
          TestGraphNode(
            id: "10",
            graphNodes: [],
            value: "Clone Test",
          ),
          test
        ],
        value: "Test",
      ),
    ],
  );
}
