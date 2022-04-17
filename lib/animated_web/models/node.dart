import 'dart:math';
import 'dart:ui';

/// Consider a node which movement vector is deviated by 30 degrees from the
/// x-axis vector (pi/6 in radians). It moves to the right and slightly to the
/// top.
///
/// When the node hits the right edge (meaning that its x coordinate is equal
/// to or greater than 1), then it should start moving in the direction
/// represented by a vector that is deviated by 150 degrees from the x-axis
/// vector (5pi/6 in radians).
///
/// In order to calculate the new direction after hitting the right edge,
/// we can use the following formula:
///
/// ```
/// newDirection = pi - oldDirection
/// ```
///
/// When the node hits the left edge (meaning that its x coordinate is equal
/// to or less than 0), then it should start moving in the direction
/// represented by a vector that is deviated by 30 degrees from the x-axi
/// vector (pi/6 in radians).
///
/// The node has bounced once from the right edge and once from the left edge
/// and it continues to move to the right and slightly to the top.
///
/// When the node hits the top edge (meaning that its y coordinate is equal to or
/// less that 0), then it should start moving in the direction
/// represented by a vector that is deviated by 330 degrees from the x-axis
/// vector (11pi/6 or -pi/6 in radians).
///
/// In order to calculate the new direction after hitting the top edge,
/// we can use the following formula:
///
/// ```
/// newDirection = oldDirection * -1;
/// ```
///
/// The node has bounced once from the right edge and once from the left edge
/// and once from the top edge it continues to move down and slightly to the
/// right.
///
/// When the node hits the bottom edge (meaning that its y coordinate is equal
/// to or greater that 1), then it should start moving in the direction
/// represented by a vector that is deviated by 30 degrees from the x-axis
/// vector (pi/6 in radians).
///
/// In order to calculate the new direction after hitting the top edge,
/// we can use the following formula:
///
/// ```
/// newDirection = oldDirection * -1;
/// ```
///
/// To sum up:
/// (1) If the x coordinate exceeds either left or right edge,
///     then we need to subtract pi from the current direction value.
/// (2) If the y coordinate exceeds either top or bottom edge,
///     then we need to multiply current direction value by -1.
class Node {
  /// A constructor that constructs a node with an initial offset.
  Node({
    required Offset initialOffset,
    required double initialDirection,
    required double moveDistance,
  })  : _currentOffset = initialOffset,
        _direction = initialDirection,
        _moveDistance = moveDistance;

  /// A value that represents the distance that the node makes when the [move]
  /// method is invoked.
  ///
  /// The [_moveDistance] is a value added to the node's current position
  /// towards a direction represented by the [_direction] field (in radians).
  final double _moveDistance;

  /// Offset representing relative position of this node on the screen.
  Offset _currentOffset;
  Offset get currentOffset => _currentOffset;

  /// A direction in which this node is moving.
  ///
  /// Represented in radians clockwise from the positive x-axis.
  ///
  /// * 0 means that the node moves to the right.
  /// * pi/2 means that the node moves up.
  /// * pi means that the node moves to the left.
  /// * 3pi/2 means that the node moves down.
  /// * 2pi means that the node moves to the right.
  double _direction;

  void move() {
    /// If the x coordinate exceeds either left or right edge,
    /// then we need to subtract pi from the current direction value.
    if (_currentOffset.dx <= 0 || _currentOffset.dx >= 1) {
      _direction = pi - _direction;
    }

    /// If the y coordinate exceeds either top or bottom edge,
    /// then we need to multiply current direction value by -1.
    if (_currentOffset.dy <= 0 || _currentOffset.dy >= 1) {
      _direction = _direction * -1;
    }

    /// Calculate the move offset based on direction and the step value.
    final moveOffset = Offset.fromDirection(_direction, _moveDistance);

    /// Update the current offset value.
    _currentOffset = _currentOffset + moveOffset;
  }
}
