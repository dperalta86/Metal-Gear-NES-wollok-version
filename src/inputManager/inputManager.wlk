import src.inputManager.movements.*
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
            movement.moveUp(solidSnake)
        })
        keyboard.down().onPressDo({ 
            movement.moveDown(solidSnake)
    })
        keyboard.left().onPressDo({ 
            movement.moveLeft(solidSnake)
    })
        keyboard.right().onPressDo({ 
            movement.moveRight(solidSnake)
    })

        // Iniciar nivel 1 desde pantalla inicial
        keyboard.space().onPressDo({ levels.loadLevel1() }) // TODO: Verificar que estemos en pantalla inicial
        keyboard.f().onPressDo( {
        solidSnake.accionUsarItem()
    })
    }
}