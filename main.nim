import raylib
import chipmunk7

import utils/[converters,extras]


proc main =
    var space:Space = newSpace()
    space.gravity = v(0, -100)

    initWindow 800, 450, "Hello World!"
    setTargetFPS 60

    discard createGroundPiece(space, v(-20, 5), v(20, -5), 0, 1, Black, Black)

    while not windowShouldClose():
        beginDrawing()
        updateScreen()
        clearBackground RayWhite
        updatePhysics(space)
        endDrawing()

main()
closeWindow()