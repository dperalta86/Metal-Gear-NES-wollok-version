import src.system.system.levels
import src.characters.snake.solidSnake
import wollok.game.*

/*
 * Contiene la lógica para manejar los inputs del juego (keyboard, mouse, etc)
 */

// Keyboard inputs
object keyboardManager {
    /*
     * Genera los listener de eventos asociados al teclado
     */
    method initKeyboard() {
        // Movimiento Snake
        keyboard.up().onPressDo({
            solidSnake.moveTo(solidSnake.position().up(1))
            solidSnake.lastMovement("up")
        })
        keyboard.down().onPressDo({ 
            solidSnake.moveTo(solidSnake.position().down(1)) 
            solidSnake.lastMovement("down")
    })
        keyboard.left().onPressDo({ 
            solidSnake.moveTo(solidSnake.position().left(1)) 
            solidSnake.lastMovement("left")
    })
        keyboard.right().onPressDo({ 
            solidSnake.moveTo(solidSnake.position().right(1)) 
            solidSnake.lastMovement("right")
    })

        // Iniciar nivel 1 desde pantalla inicial
        keyboard.space().onPressDo({ levels.loadLevel1() })
    }
}