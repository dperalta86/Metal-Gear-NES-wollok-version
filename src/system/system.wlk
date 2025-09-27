import wollok.game.*
import src.characters.snake.*


object config {
  method load()
  {
    // Configuraciones globales del juego
    game.title("Metal Gear NES")
    game.cellSize(64)
    game.height(12)
    game.width(20)

    game.boardGround("fondo.jpg")
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

  method loadLevel() {
    //game.boardGround("fondo.jpg")

    // TODO: Cargar objetos

    // TODO: Cargar enemigos

    // cargar snake
    game.addVisualCharacter(solidSnake)
    
  }
}
