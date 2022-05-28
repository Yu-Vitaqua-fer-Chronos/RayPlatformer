import raylib
import chipmunk7

import converters

const timestep:Float = 1/60

type EntityType* = enum
    Player
    Enemy
    Other

type Entity* = object
    entityType:EntityType
    shape:Shape
    body:Body
    width:Float
    height:Float
    outlineColour:Color
    fillColour:Color

type Ground* = object
    shape:Shape
    a:Vect
    b:Vect
    outlineColour:Color
    fillColour:Color

var Entities:seq[Entity] = @[]
var GroundPieces:seq[Ground] = @[]

proc createGroundPiece*(space:Space, a:Vect, b:Vect, radius:Float, friction:Float, outlineColour:Color, fillColour:Color):Ground =
    var segmentShape:SegmentShape = newSegmentShape(space.staticBody, a, b, radius)
    segmentShape.friction = friction
    var shape:Shape = space.addShape(segmentShape)
    var ground:Ground = Ground(shape:shape, a:a, b:b, outlineColour:outlineColour, fillColour:fillColour)
    GroundPieces.add(ground)
    result = ground

proc createBoxEntity*(space:Space, mass:Float, width:Float, height:Float, friction:Float, entityType:EntityType, outlineColour:Color, fillColour:Color):Entity =
    var moment:Float = momentForBox(mass, width, height)
    var body:Body = space.addBody(newBody(mass, moment))
    var shape:Shape = space.addShape(body.newBoxShape(width, height, 0))
    shape.friction = friction
    var entity:Entity = Entity(entityType:entityType, shape:shape, body:body, width:width, height:height, outlineColour:outlineColour, fillColour:fillColour)
    Entities.add(entity)
    result = entity

proc updatePhysics*(space:Space) =
    space.step(timestep)

proc updateScreen*() =
    for ground in GroundPieces:
        drawRectangleV(ground.a, ground.b, ground.outlineColour)
    #[
    for entity in Entities:
        drawSegment(entity.shape.a, entity.shape.b, entity.outlineColour)
        drawCircle(entity.shape.body.position, entity.shape.radius, entity.fillColour)]#