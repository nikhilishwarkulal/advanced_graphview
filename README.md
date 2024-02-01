<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Advanced Graphview enables user to create Tree, Graph, Topology Ui with simple Setup.
[![](https://luckyapp.in/assets/asstes/advanced_graphview1.gif)](https://luckyapp.in/assets/asstes/advanced_graphview1.gif)
[![](https://luckyapp.in/assets/asstes/advanced_graphview2.gif)](https://luckyapp.in/assets/asstes/advanced_graphview2.gif)
[![](https://luckyapp.in/assets/asstes/advanced_graphview3.gif)](https://luckyapp.in/assets/asstes/advanced_graphview3.gif)
## Features

Advanced Graphview can  create Tree, Graph, Topology Ui with simple Setup..

## Getting started

Add the package in pubspec.yaml and then use the widget AdvancedGraphview.

## Usage



```dart
Widget exampleWidget(){
  TestGraphNode getExampleNode() {
    return TestGraphNode(
      id: '1',
      value: "Advanced Graphview",
      graphNodes: [
      ],
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
      return Paint()
        ..color = Colors.blue
        ..strokeWidth = 1;
    },
    builder: (GraphNode graphNode) {
      return Container(
        width: 200,
        height: 200,
        child: const Center(
          child: Text("Hello"),
        ),
      );
    },
  );
}

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
```

## Additional information

For additional information contact us at nikhilishwar2@gmail.com or sharathkkotian@gmail.com. We welcome more contributors on this project. 
