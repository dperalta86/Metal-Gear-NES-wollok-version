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
        
    // Configuraciones globales del juego
    game.title("Metal Gear NES")
    game.cellSize(64)
    game.height(12)
    game.width(20)
    game.boardGround("black.png")

    // Inicializo el manejador de inputs
    keyboardManager.initKeyboard()

    // Crear todos los objetos del nivel una sola vez
    objectPool.initializeLevel01()

    // Inicializo movimientos de los guardias
    areaManager.launchGuardsBehavior()

    // Inicializo levels
    levelsManager.loadIntro()
    // Música en loop
    /*
     * Chiptune One.wav by CarlosCarty -- https://freesound.org/s/427513/ -- License: Attribution 4.0
    */
    const mainSound = game.sound("427513__carloscarty__chiptune-one.wav")
    mainSound.shouldLoop(true)
    game.schedule(1000, { mainSound.play()} )
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