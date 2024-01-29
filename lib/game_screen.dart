import 'dart:math';
import 'dart:ui' as ui;

import 'package:advanced_graphview/world_map.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'advanced_graphview.dart';
import 'flame_game_screen.dart';
import 'image_loader.dart';

class AdvancedGraphview extends StatefulWidget {
  // final GraphNode head;
  final double nodeSize;
  final double nodePadding;
  final GraphNode graphNode;
  final bool isDebug;
  final Paint? Function(GraphNode lineFrom, GraphNode lineTwo)? onDrawLine;
  final Widget Function(GraphNode graphNode) builder;
  final AdvancedGraphviewController? advancedGraphviewController;
  final Color? backgroundColor;
  final double pixelRatio;
  final Function(GraphNode)? onNodeTap;
  const AdvancedGraphview({
    super.key,
    // required this.head,
    required this.nodePadding,
    required this.nodeSize,
    required this.graphNode,
    required this.builder,
    this.isDebug = false,
    this.advancedGraphviewController,
    this.onDrawLine,
    this.backgroundColor,
    this.pixelRatio = 1,
    this.onNodeTap,
  });
  static late BuildContext context;
  @override
  State<AdvancedGraphview> createState() => _AdvancedGraphviewState();
}

class _AdvancedGraphviewState extends State<AdvancedGraphview> {
  bool loader = true;
  late FlameGame myGame;
  late GraphDataStructure graphDataStructure;
  late int length;
  late Map<String, GraphNode> nodeMap;
  @override
  void initState() {
    super.initState();
    AdvancedGraphview.context = context;
    startLoadingImage();
  }

  void startLoadingImage() async {
    await loadImage();
    if (widget.advancedGraphviewController?.chachedGraphNode != null) {
      graphDataStructure = GraphDataStructure(
          graphNode: widget.advancedGraphviewController!.chachedGraphNode!);
    } else {
      graphDataStructure = GraphDataStructure(graphNode: widget.graphNode);
      if (widget.advancedGraphviewController != null) {
        widget.advancedGraphviewController!.chachedGraphNode = widget.graphNode;
      }
    }

    Set<String> items = graphDataStructure.getListOfItems();
    length = sqrt(items.length).ceil();
    WorldMap.size = (widget.nodeSize + (widget.nodePadding * 2)) * length;
    nodeMap = graphDataStructure.getAllItems();
    if (widget.advancedGraphviewController != null) {
      widget.advancedGraphviewController?.maxScrollExtent = WorldMap.size;
    }
    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loader) return const SizedBox();
    return Stack(
      children: [
        ...graphDataStructure.getList().map(
              (e) => NodeModuleImageRenderer(
                graphDataStructure: graphDataStructure,
                graphNode: e,
                nodeSize: Vector2(widget.nodeSize, widget.nodeSize),
                pixelRatio: widget.pixelRatio,
                child: widget.builder(e),
              ),
            ),
        GameWidget(
          game: FollowComponentExample(
            nodePadding: widget.nodePadding,
            graphDataStructure: graphDataStructure,
            nodeSize: widget.nodeSize,
            context: context,
            isDebug: widget.isDebug,
            onDrawLine: widget.onDrawLine,
            flameBackgroundColor: widget.backgroundColor,
            advancedGraphviewController: widget.advancedGraphviewController,
            pixelRatio: widget.pixelRatio,
            onNodeTap: widget.onNodeTap,
          ),
        ),

        //const PickerScreen(pickerScreenDataFirst: ,)
      ],
    );
  }
}

class NodeModuleImageRenderer extends StatefulWidget {
  final Widget child;
  final Vector2 nodeSize;
  final GraphNode graphNode;
  final GraphDataStructure graphDataStructure;
  final double pixelRatio;
  const NodeModuleImageRenderer({
    super.key,
    required this.child,
    required this.nodeSize,
    required this.graphDataStructure,
    required this.graphNode,
    required this.pixelRatio,
  });

  @override
  State<NodeModuleImageRenderer> createState() =>
      _NodeModuleImageRendererState();
}

class _NodeModuleImageRendererState extends State<NodeModuleImageRenderer> {
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(
        const Duration(seconds: 1),
        () => _capturePng(),
      );
    });
  }

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: widget.pixelRatio);
    widget.graphDataStructure.nodeImages[widget.graphNode.id] = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.nodeSize.x,
        height: widget.nodeSize.y,
        child: RepaintBoundary(
          key: globalKey,
          child: Align(
            child: SizedBox(
              width: widget.nodeSize.x,
              height: widget.nodeSize.y,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
