import src.characters.guards.patrollGuard.PatrolGuard
import src.characters.guards.staticsGuard.*
import src.system.system.*
import wollok.game.*

import src.characters.snake.*
import src.system.visual.*



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
    method load() { 
        console.println("Cargando área central") // Debug
        game.addVisual(cetralAreaBG)
        game.addVisualCharacter(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }

    method northConnection() = northArea
    method southConnection() = southArea
    method eastConnection()  = eastArea
    method westConnection()  = westArea
}

object northArea {
    // Liista de guardias en el area
    const guardias = []
    method name() = "North Area"
    method load() { 
        console.println("Cargando área norte") // Debug
        game.addVisual(northAreaBG)
        game.addVisualCharacter(solidSnake)
        // TODO: cargar enemigos y objetos

        // Instancias de guardias
        const staticGuard1 = new StaticGuard(position=game.at(5, 5))
        const staticGuard2 = new StaticGuard(position=game.at(10, 7))
        const patrolGuard1 = new PatrolGuard(position=game.at(3, 3))

        // Agrego las "instancias" al area
        game.addVisual(staticGuard1)
        game.addVisual(staticGuard2)
        game.addVisual(patrolGuard1)
    }
    method removeArea() { levels.clearGame() }

    method northConnection() = null
    method southConnection() = centralArea
    method eastConnection()  = null
    method westConnection()  = null
}

object southArea {
    method name() = "South Area"
    method load() { 
        console.println("Cargando área sur") // Debug
        game.addVisual(southAreaBG)
        game.addVisualCharacter(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }

    method northConnection() = centralArea
    method southConnection() = null
    method eastConnection()  = null
    method westConnection()  = null
}

object eastArea {
    method name() = "East Area"
    method load() { 
        game.addVisual(eastAreaBG)
        console.println("Cargando área este") // Debug
        game.addVisualCharacter(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }

    method northConnection() = null
    method southConnection() = null
    method eastConnection()  = null
    method westConnection()  = centralArea
}

object westArea {
    method name() = "West Area"
    method load() { 
        game.addVisual(westAreaBG)
        console.println("Cargando área oeste") // Debug
        game.addVisualCharacter(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }

    method northConnection() = null
    method southConnection() = null
    method eastConnection()  = centralArea
    method westConnection()  = null
}
