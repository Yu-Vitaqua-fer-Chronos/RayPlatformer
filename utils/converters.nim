import raylib
import chipmunk7

# Vectors
type GenericVector = concept v
    v.x is Float
    v.y is Float

converter vectToRay*(v:GenericVector):Vector2 = Vector2(x:v.x, y:v.y)
converter vectToChip*(v:GenericVector):Vect = v(v.x, v.y)

