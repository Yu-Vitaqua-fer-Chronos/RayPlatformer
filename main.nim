import raylib
import chipmunk7

import utils/[converters,extras]

const
    screenWidth = 800
    screenHeight = 450

proc main =
    var space:Space = newSpace()
    space.gravity = v(0, 100)

    initWindow screenWidth, screenHeight, "Hello World!"
    setTargetFPS 60
    initTextures()

    discard createGroundPiece(space, v(20, 400), v(500, 370), 0, 1, Green, Black)

    var player:Entity = createBoxEntity(space, 1, v(100, 280), 10, 10, 0.7, EntityType.Player, White, Green, 1, 1)
    var camera:Camera2D = Camera2D(offset:v(0, 0), target:v(0, 0), rotation:0, zoom:1)

    while not windowShouldClose():
        if curframe == 61: curframe = 1
        beginDrawing()
        beginMode2D(camera)

        camera.target = player.position
        camera.offset = v(screenWidth / 2, screenHeight / 2)

        updateScreen()
        clearBackground Black
        updatePhysics(space)

        endMode2D()
        endDrawing()
        curframe += 1

main()
closeWindow()