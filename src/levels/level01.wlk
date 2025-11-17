import src.utils.log.log
import src.ui.hud.hud
import src.system.objectPool.objectPool
import src.system.colissions.colissionHandler
import src.characters.snake.snake.solidSnake
import src.levels.areaManager.*
import src.ui.visual.*


class Area {
    const property name        // "area01", "area02", etc.
    const property background  // Visual de fondo
    const property changeEvents = []
    
    /*
     * Carga el área activando objetos pre-creados
     * RÁPIDO: ~50-100ms vs 10 segundos antes
     */
    method load() {
        log.info(self, "\n>>> Cargando " + name + "...")
        
        // 1. Cargar fondo
        game.addVisual(background)
        
        // 2. Activar objetos del pool (guardias, cajas, llaves, etc.)
        objectPool.activateArea(name)
        
        // 3. Agregar a Snake
        game.addVisual(solidSnake)

        // 4. Agregar HUD
        hud.drawHearts()
    }
    
    /*
     * Descarga el área desactivando objetos
     */
    method unload() {         
        // 1. Desactivar objetos del pool
        objectPool.deactivateArea(name)
        
        // 2. Limpiar visuales TODO: Optimizar para no eliminar todo cada vez (solo los del area)
        game.allVisuals().forEach { visual => 
            game.removeVisual(visual) 
        }
        
        log.info(self, "<<< " + name + " descargada\n")
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
    changeEvents = [goToArea01, goToArea05A, goToArea05B]
)

const area03 = new Area(
    name = "area03",
    background = area03BG,
    changeEvents = [goToArea01A, goToArea01B, goToArea04A, goToArea04B]
)

const area04 = new Area(
    name = "area04",
    background = area04BG,
    changeEvents = [goToArea03]
)

const area05 = new Area(
    name = "area05",
    background = area05BG,
    changeEvents = [goToArea02B]
)

const allAreasLevel01 = [
    area01,
    area02,
    area03,
    area04,
    area05
]