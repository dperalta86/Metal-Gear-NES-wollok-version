import src.objectPool.objectPool
import src.levels.factory.*
import src.system.colissions.colissionHandler
import src.inputManager.inputManager.keyboardManager
import src.levels.level01.*
import wollok.game.*
import src.characters.snake.*
import src.system.visual.*
import src.levels.areaManager.*

/*
 * Configuración principal del juego
 * Inicializa todos los sistemas en el orden correcto
 */
object config {
    method load() {
        console.println("╔════════════════════════════════════════╗")
        console.println("║       METAL GEAR NES - INICIANDO       ║")
        console.println("╚════════════════════════════════════════╝")
        
        // 1. Configuraciones globales del juego
        game.title("Metal Gear NES")
        game.cellSize(64)
        game.height(12)
        game.width(20)
        game.boardGround("black.png")
        
        // 2. CRÍTICO: Pre-instanciar TODOS los objetos del nivel
        //    Esto toma 1-2 segundos PERO solo se hace UNA vez
        console.println("\n[1/6] Pre-creando objetos del nivel...")
        objectPool.initializeLevel01()
        
        // 3. Inicializar sistemas
        console.println("\n[2/6] Inicializando sistema de colisiones...")
        colissionHandler.initializeAll(objectPool.getAllObjects())
        
        console.println("[3/6] Inicializando controles de teclado...")
        keyboardManager.initKeyboard()
        
        console.println("[4/6] Inicializando comportamiento de guardias...")
        areaManager.launchGuardsBehavior()
        
        // 4. Cargar intro
        console.println("[5/6] Cargando pantalla de inicio...")
        levelsManager.loadIntro()
        
        // 5. Música
        console.println("[6/6] Iniciando música...")
        const mainSound = game.sound("427513__carloscarty__chiptune-one.wav")
        mainSound.shouldLoop(true)
        game.schedule(1000, { mainSound.play() })
        
        console.println("\n╔════════════════════════════════════════╗")
        console.println("║             ¡JUEGO LISTO!              ║")
        console.println("╚════════════════════════════════════════╝\n")
        
        // Debug: Mostrar estadísticas
        objectPool.printStats()
    }
}
/*
 * Manejador de niveles
 */
object levelsManager {
    method loadIntro() {
        self.clearGame()
        game.addVisual(start)
        game.addVisual(startMessage)
    }
    
    method loadLevel1() {
        self.clearGame()
        solidSnake.initialize()
        solidSnake.position(game.at(13, 1))
        area01.load()
    }
    
    method clearGame() {
        game.allVisuals().forEach { visual => 
            game.removeVisual(visual) 
        }
    }
}