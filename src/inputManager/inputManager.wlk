import src.gameManager.*
import src.system.gameStatus.*
import src.inputManager.movements.*
import src.system.system.*
import src.characters.snake.snake.solidSnake
import wollok.game.*
import src.ui.visual.*


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
            if(gameManager.isGameOver()) { gameManager.restartGame() }  
        })
        
        keyboard.a().onPressDo({ solidSnake.pickItem() })   // recoger
        keyboard.s().onPressDo({ solidSnake.dropItem() })   // soltar
        keyboard.d().onPressDo({ solidSnake.useItem() })    // usar

        keyboard.p().onPressDo({ gameManager.togglePause() })  // pausar/reanudar juego})

        // TODO: implementar función de salir del juego
        keyboard.q().onPressDo( {  })

    }
}