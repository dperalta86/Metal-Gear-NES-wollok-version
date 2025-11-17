import src.utils.log.log
import src.items.bullet.bulletManager
import src.ui.hud.hud
import src.system.objectPool.objectPool
import src.levels.factory.*
import src.system.colissions.colissionHandler
import src.inputManager.inputManager.keyboardManager
import src.levels.level01.*
import wollok.game.*
import src.characters.snake.snake.*
import src.ui.visual.*
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

    // Inicializo el HUD
    hud.initHUD()

    // Inicializo movimientos de los guardias
    areaManager.launchGuardsBehavior()

    // Inicializo gestión de balas
    bulletManager.init()

    // Inicializo levels
    levelsManager.loadIntro()
    // Música en loop
    /*
     * Chiptune One.wav by CarlosCarty -- https://freesound.org/s/427513/ -- License: Attribution 4.0
    */
    const mainSound = game.sound("427513__carloscarty__chiptune-one.wav")
    mainSound.shouldLoop(true)
    game.schedule(1000, { mainSound.play()} )

    // utilidad pseudo log (por ahora solo printea en pantalla)
    log.info(self, "Configuración inicial completada correctamente.\n" +
    " ├─ Título: " + game.title() + "\n" +
    " ├─ Dimensiones: " + game.width() + "x" + game.height() +
    " ├─ Fondo: black.png\n" +
    " ├─ Subsistemas activos: keyboardManager, objectPool, hud, areaManager, bulletManager, levelsManager\n" +
    " └─ Recurso de audio cargado: 427513__carloscarty__chiptune-one.wav (loop habilitado)")
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
        log.debug(self, "Intro caragada")
    }
    
    method loadLevel1() {
        self.clearGame()
        solidSnake.position(game.at(13, 1))
        area01.load()
        log.debug(self, "Level 01 cargado")
    }
    
    method clearGame() {
        game.allVisuals().forEach { visual => 
            game.removeVisual(visual) 
        }
    }
}