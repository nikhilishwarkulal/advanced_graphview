import 'package:advanced_graphview/graph_node.dart';
import 'package:advanced_graphview/node_module/node_module_item.dart';
import 'package:flame/components.dart';

import '../advanced_graphview/advanced_graphview_flame.dart';
import '../graph_data_structure.dart';

/// [NodeModule] is the Component that holds the size and position
class NodeModule extends PositionComponent
    with HasGameRef<AdvancedGraphviewFlame> {
  final Vector2 nodeSize;
  final Vector2 nodePosition;
  final double nodePadding;
  final double nodeImageSize;
  final GraphDataStructure graphDataStructure;
  final GraphNode graphNode;

  /// [NodeModule] is the Component that holds the size and position
  NodeModule({
    required this.nodeSize,
    required this.nodePosition,
    required this.nodePadding,
    required this.graphDataStructure,
    required this.graphNode,
    required this.nodeImageSize,
  });

  /// [isUpdated] checks if the ui is updated
  bool isUpdated = false;
  @override
  Future<void> onLoad() async {
    size = nodeSize;
    position = nodePosition;

    /// add to the world
    game.world.add(NodeModuleItem(
        nodeSize: nodeSize,
        nodePosition: nodePosition,
        nodePadding: nodePadding,
        graphDataStructure: graphDataStructure,
        graphNode: graphNode,
        nodeImageSize: nodeImageSize));
    return super.onLoad();
  }
}
