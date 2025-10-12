import src.characters.guards.patrollGuard.PatrolGuard
import src.characters.guards.staticsGuard.*
import src.system.system.*
import wollok.game.*

import src.characters.snake.*
import src.system.visual.*
import src.levels.areaManager.*

// Defino las areas del nivel
// Ver si conviene hacer una clase abstracta Area y que las areas hereden de ella
class Area {
    const property changeEvents = [] // Lista de eventos de cambio de area
    var property name = ""
    const background // Imagen de fondo del area 

    method load() { 
        console.println("Cargando área: " + name) // Debug
        game.addVisual(background)
        game.addVisual(solidSnake)
    }
    method removeArea() { levels.clearGame() }

    method addChangeEvent(event) {
        changeEvents.add(event)
    }

    method checkAreaChange(character) {
        return changeEvents.findOrDefault({e => e.canCharacterChangeArea(character)}, null)
    }
}

// Instancias de areas del nivel 1
const area01 = new Area(
    background = area01BG,
    name = "Area 01",
    changeEvents = [goToArea02, goToArea03A, goToArea03B]
)

const area02 = new Area(
    background = area02BG,
    name = "Area 02",
    changeEvents = [goToArea01]
)

const area03 = new Area(
    background = area03BG,
    name = "Area 03",
    changeEvents = [goToArea01A, goToArea01B] // Agregar eventos de cambio de area
)

const area04 = new Area(
    background = area04BG,
    name = "Area 04",
    changeEvents = [] // Agregar eventos de cambio de area
)

const area05 = new Area(
    background = area05BG,
    name = "Area 05",
    changeEvents = [] // Agregar eventos de cambio de area
)

/*
object area01 {
    const changeEvents = []
    method name() = "Area 01"
    method load() { 
        console.println("Cargando área 01") // Debug
        game.addVisual(area01BG)
        game.addVisual(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }

        method addChangeEvent(event) {
        changeEvents.add(event)
    }

    method checkAreaChange(character) {
        return changeEvents.findOrDefault({e => e.canCharacterChangeArea(character)}, null)
    }
}

object area02 {
    // Liista de guardias en el area
    const guards = []
    method name() = "Area 02"
    method load() { 
        console.println("Cargando área 02") // Debug
        game.addVisual(area02BG)
        game.addVisual(solidSnake)
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
}

object area03 {
    method name() = "Area 03"
    method load() { 
        console.println("Cargando área 03") // Debug
        game.addVisual(area03BG)
        game.addVisual(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }
}

object area04 {
    method name() = "Area 04"
    method load() { 
        game.addVisual(area04BG)
        console.println("Cargando área 04") // Debug
        game.addVisual(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }
}

object area05 {
    method name() = "Area 05"
    method load() { 
        game.addVisual(area05BG)
        console.println("Cargando área 05") // Debug
        game.addVisual(solidSnake)
        // TODO: cargar enemigos y objetos
    }
    method removeArea() { levels.clearGame() }
}
*/