# Useful Notes for Future Reference
## Nim-Chipmunk
Code to initialize a Chipmunk2D Vector \
`proc v*(x: Float; y: Float): Vect {.inline, cdecl.}`

## Naylib
Nothing yet.

## Custom Functions and Types
Code to create a static shape
`createStaticShape*(s:Space, a:Vect, b:Vect, r:float):Shape`

## Additional Notes
### Converters
- Vectors
  - Any Vector-compatible type can be converted easily and automatically now