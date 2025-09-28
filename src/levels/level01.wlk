import src.characters.snake.*

/*
    Mapa de areas del nivel 01 (Fase inicial)
        ┌─────────────┐
        │    North    │
        │             |
        └──────┬──────┘
               │
┌──────────────┼────┐─────────┐
│         │         │         |
│   West  │ Central │   East  | 
│         │         │         |
└──────────────┼────┘─────────┘
               │
        ┌──────┴──────┐
        │   South     │
        │             │
        └─────────────┘

   Conexiones:
   - centralArea → norte, sur, este, oeste
   - northArea   → central (sur)
   - southArea   → central (norte)
   - eastArea    → central (oeste)
   - westArea    → central (este)
*/

// Defino las areas del nivel
object centralArea {
    method name() = "Central Area"
    method load() { game.boardGround("central.jpg") }
    method removeArea() {}

    method northConnection() = northArea
    method southConnection() = southArea
    method eastConnection()  = eastArea
    method westConnection()  = westArea
}

object northArea {
    method name() = "North Area"
    method load() { game.boardGround("north.jpg") }
    method removeArea() {}

    method northConnection() = null
    method southConnection() = centralArea
    method eastConnection()  = null
    method westConnection()  = null
}

object southArea {
    method name() = "South Area"
    method load() { game.boardGround("south.jpg") }
    method removeArea() {}

    method northConnection() = centralArea
    method southConnection() = null
    method eastConnection()  = null
    method westConnection()  = null
}

object eastArea {
    method name() = "East Area"
    method load() { game.boardGround("east.jpg") }
    method removeArea() {}

    method northConnection() = null
    method southConnection() = null
    method eastConnection()  = null
    method westConnection()  = centralArea
}

object westArea {
    method name() = "West Area"
    method load() { game.boardGround("west.jpg") }
    method removeArea() {}

    method northConnection() = null
    method southConnection() = null
    method eastConnection()  = centralArea
    method westConnection()  = null
}
