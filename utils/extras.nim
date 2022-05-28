import tables
import std/sequtils

import raylib
import chipmunk7

import converters

const timestep:Float = 1/60
var curframe*:int8 = 1

var playerTextures:Table[string,seq[Texture2D]]

proc initTextures*() =
    playerTextures["idle"] = @[
        loadTexture("assets/player/idle/1.png")
    ]

type EntityType* = enum
    Player
    Enemy
    Other

type Entity* = object
    entityType:EntityType
    shape:Shape
    width:Float
    height:Float
    outlineColour:Color
    fillColour:Color
    maxFrames:int8
    currentFrame:int8

type Ground* = object
    shape:Shape
    a:Vect
    b:Vect
    outlineColour:Color
    fillColour:Color

template body*(g:Ground):Body = g.shape.body
template body*(e:Entity):Body = e.shape.body

template position*(g:Ground):Vect = g.body.position
template position*(e:Entity):Vect = e.body.position

var Entities:seq[Entity] = @[]
var GroundPieces:seq[Ground] = @[]

proc createGroundPiece*(space:Space, a:Vect, b:Vect, radius:Float, friction:Float, outlineColour:Color, fillColour:Color):Ground =
    var segmentShape:SegmentShape = newSegmentShape(space.staticBody, a, b, radius)
    segmentShape.friction = friction
    var shape:Shape = space.addShape(segmentShape)
    var ground:Ground = Ground(shape:shape, a:a, b:b, outlineColour:outlineColour, fillColour:fillColour)
    GroundPieces.add(ground)
    result = ground

proc createBoxEntity*(space:Space, mass:Float, position:Vect, width:Float, height:Float, friction:Float, entityType:EntityType, outlineColour:Color, fillColour:Color, maxFrames:int8, currentFrame:int8):Entity =
    var moment:Float = momentForBox(mass, width, height)
    var body:Body = space.addBody(newBody(mass, moment))
    body.position = position
    var shape:Shape = space.addShape(body.newBoxShape(width, height, 0))
    shape.friction = friction
    var entity:Entity = Entity(entityType:entityType, shape:shape, width:width, height:height, outlineColour:outlineColour, fillColour:fillColour, maxFrames:maxFrames, currentFrame:currentFrame)
    Entities.add(entity)
    result = entity

proc updatePhysics*(space:Space) =
    space.step(timestep)

proc updateScreen*() =
    for ground in GroundPieces:
        drawLineV(ground.b, v(ground.b.x, ground.a.y), ground.outlineColour)
        drawLineV(ground.a, v(ground.b.x, ground.a.y), ground.outlineColour)
        drawLineV(ground.b, v(ground.a.x, ground.b.y), ground.outlineColour)
        drawLineV(ground.a, v(ground.a.x, ground.b.y), ground.outlineColour)

    for entity in Entities:
        #[
        if entity.entityType == Player:
            entity.currentFrame += 1
            if entity.currentFrame > entity.maxFrames:
                entity.currentFrame = 0
            # drawTexturePro() ]#
        drawRectangleRec(Rectangle(x:entity.position.x, y:entity.position.y, width:entity.width, height:entity.height), entity.outlineColour)