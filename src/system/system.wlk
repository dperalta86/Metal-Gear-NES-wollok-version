import wollok.game.*

object config {
  method load()
  {
    // Configuraciones globales del juego
    game.title("Metal Gear NES")
	game.cellSize(64)
	game.height(12)
	game.width(20)

    game.boardGround("fondo.jpg")
  }
}

object levels {
  method load_level() {
    // TODO: Cargar nivel 1
  }
}
