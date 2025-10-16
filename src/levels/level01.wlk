import src.system.colissions.*
import src.gameObject.GameObject
import src.characters.guards.patrollGuard.*
import src.characters.guards.staticsGuard.*
import src.obstacles.invisibleObject.*


import src.characters.snake.*
import src.system.system.*
import wollok.game.*
import src.system.visual.*
import src.levels.areaManager.*

// Defino las areas del nivel
// Ver si conviene hacer una clase abstracta Area y que las areas hereden de ella
class Area {
    const property changeEvents = [] // Lista de eventos de cambio de area
    const property guards = [] // Lista de guardias
    var property name = ""
    const background // Imagen de fondo del area 
    const invisibleObjects=[]

    method load() { 
        // Cargo el fondo del area
        game.addVisual(background)

        // Cargo a solidSnake
        game.addVisual(solidSnake)
        self.addInvisibleObjects()

        // Agrego los guardias (statics y patroll)
        guards.forEach { guard => game.addVisual(guard) }
        colissionHandler.loadAread(self)

        // TODO: Agregar objetos
    }

    method guards() { return guards } 
    method removeArea() { 
        colissionHandler.destroyArea(self)
        levels.clearGame()
    }

    method addChangeEvent(event) {
        changeEvents.add(event)
    }

    method checkAreaChange(character) {
        return changeEvents.findOrDefault({e => e.canCharacterChangeArea(character)}, null)
    }

    method addInvisibleObjects(){
        invisibleObjects.forEach({obj => game.addVisual(obj)})
    }
}

// Instancias de areas del nivel 1
const area01 = new Area(
    background = area01BG,
    name = "Area 01",
    changeEvents = [goToArea02, goToArea03A, goToArea03B],
    guards = [static01, patroll01],
    invisibleObjects=invisibleArea01
)

const area02 = new Area(
    background = area02BG,
    name = "Area 02",
    changeEvents = [goToArea01],
    guards = [static02, patroll02],
    invisibleObjects=[]
)

const area03 = new Area(
    background = area03BG,
    name = "Area 03",
    changeEvents = [goToArea01A, goToArea01B],
    guards = [static03A, static03B, patroll03],
    invisibleObjects=[]
)

const area04 = new Area(
    background = area04BG,
    name = "Area 04",
    changeEvents = [], // Agregar eventos de cambio de area
    guards = [patroll04A, patroll04B],
    invisibleObjects=[] 
    
)

const area05 = new Area(
    background = area05BG,
    name = "Area 05",
    changeEvents = [], // Agregar eventos de cambio de area
    invisibleObjects=[]
)

const allRegisteredAreas = [area01, area02, area03, area04, area05]