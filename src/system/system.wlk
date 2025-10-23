import src.inputManager.movements.movement
import src.system.colissions.colissionHandler
import src.inputManager.inputManager.keyboardManager
import src.levels.level01.*
import wollok.game.*
import src.characters.snake.*
import src.system.visual.*
import src.levels.areaManager.*

object config {
  method load()
  {
    // Configuraciones globales del juego
    game.title("Metal Gear NES")
    game.cellSize(64)
    game.height(12)
    game.width(20)
    game.boardGround("black.png")

    // Inicializo el manejador de inputs
    keyboardManager.initKeyboard()

    // Iniciliazo el manejador de colisiones
    colissionHandler.initialize()

    // Inicializo movimientos de los guardias
    movement.launchGuardsBehavior()

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

object levelsManager {

  /*
   * Carga video inicial y espera input para iniciar nivel 1
  */
  method loadIntro() {
    self.clearGame()
    game.addVisual(start)
    game.addVisual(startMessage)

  }

  method loadLevel1() {
    self.clearGame()
    solidSnake.position(game.at(13,1))
    area01.load()
  }

  method clearGame() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual) })
	}
}
