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
    // Música en loop
    /*
     * Chiptune One.wav by CarlosCarty -- https://freesound.org/s/427513/ -- License: Attribution 4.0
    */
    const mainSound = game.sound("427513__carloscarty__chiptune-one.wav")
    mainSound.shouldLoop(true)
    game.schedule(500, { mainSound.play()} )
  }
}

object levels {

  /*
   * Carga video inicial y espera input para iniciar nivel 1
  */
  method start() {
    self.clearGame()
    game.addVisual(start)
    game.addVisual(startMessage)

  }

  method loadLevel1() {
    self.clearGame()
    areaManager.changeArea(centralArea, game.at(2, 2))
  }

  method clearGame() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual) })
	}
}
