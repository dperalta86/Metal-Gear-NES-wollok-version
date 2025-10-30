import src.system.colissions.colissionHandler
import src.characters.snake.solidSnake
import src.objectPool.objectPool
import src.levels.areaManager.*
import src.system.visual.*


class Area {
    const property name        // "area01", "area02", etc.
    const property background  // Visual de fondo
    const property changeEvents = []
    
    /*
     * Carga el área activando objetos pre-creados
     * RÁPIDO: ~50-100ms vs 10 segundos antes
     */
    method load() { 
        console.println("\n>>> Cargando " + name + "...")
        const startTime = new Date()
        
        // 1. Cargar fondo
        game.addVisual(background)
        
        // 2. Activar objetos del pool
        objectPool.activateArea(name)
        
        // 3. Agregar a Snake
        game.addVisual(solidSnake)
        
        const endTime = new Date()
        console.println(">>> " + name + " cargada en " + (endTime - startTime) + "ms\n")
    }
    
    /*
     * Descarga el área desactivando objetos
     */
    method unload() { 
        console.println("\n<<< Descargando " + name + "...")
        
        // 1. Limpiar colisiones
        colissionHandler.unregisterAll()
        
        // 2. Desactivar objetos del pool
        objectPool.deactivateArea(name)
        
        // 3. Limpiar visuales
        game.allVisuals().forEach { visual => 
            game.removeVisual(visual) 
        }
        
        console.println("<<< " + name + " descargada\n")
    }
    
    method addChangeEvent(event) {
        changeEvents.add(event)
    }
    
    method checkAreaChange(character) {
        return changeEvents.findOrDefault(
            { e => e.canCharacterChangeArea(character) }, 
            null
        )
    }
    
    method getActiveGuards() {
        return objectPool.getActiveGuardsForArea(name)
    }
}

// ===== Instancias de áreas =====
const area01 = new Area(
    name = "area01",
    background = area01BG,
    changeEvents = [goToArea02, goToArea03A, goToArea03B]
)

const area02 = new Area(
    name = "area02",
    background = area02BG,
    changeEvents = [goToArea01]
)

const area03 = new Area(
    name = "area03",
    background = area03BG,
    changeEvents = [goToArea01A, goToArea01B]
)

const area04 = new Area(
    name = "area04",
    background = area04BG,
    changeEvents = []
)

const area05 = new Area(
    name = "area05",
    background = area05BG,
    changeEvents = []
)