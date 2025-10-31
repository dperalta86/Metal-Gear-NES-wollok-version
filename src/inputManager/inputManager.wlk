import src.system.gameStatus.*
import src.inputManager.movements.*
import src.system.system.*
import src.characters.snake.solidSnake
import wollok.game.*
import src.system.visual.*


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
        keyboard.space().onPressDo({ 
            if(game.hasVisual(start)) { levelsManager.loadLevel1() } 
        })
        
        keyboard.f().onPressDo( {
        solidSnake.equipItem()
    })
    }
}