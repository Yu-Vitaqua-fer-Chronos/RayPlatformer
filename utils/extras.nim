import raylib
import chipmunk7

proc createStaticShape*(space:Space, a:Vect, b:Vect, radius:Float, friction:Float):Shape =
    var segmentShape:SegmentShape = newSegmentShape(space.staticBody, a, b, radius)
    segmentShape.friction = friction
    result = space.addShape(segmentShape)