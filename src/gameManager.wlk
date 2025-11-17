import src.items.pickables.*
import src.items.winner.*
import src.utils.log.log
import src.utils.utils.utils
import src.system.objectPool.*
import src.system.gameStatus.*
import src.system.colissions.*
import src.ui.hud.hud
import src.system.system.config
import src.levels.areaManager.*
import src.levels.level01.*
import src.system.system.levelsManager
import src.characters.snake.snake.*
import src.ui.visual.*
import src.levels.factory.*



object gameManager {
    var isPaused = false
    var isGameOver = false

    method isGameOver() = isGameOver

    // --------------------
    // Inicialización
    // --------------------
    method startGame() {
        isPaused = false
        isGameOver = false

        if (!game.running()){
            console.println("🎮 Game started")
            game.start()
        }

        // TODO: resetar variables globales del juego
    }

    // --------------------
    // Winner
    // --------------------
    method winner(character) {
        if (character.meetsConditionToWin()){
            isGameOver = true
            log.info(self, "Congratulations! You won this game!")
            game.addVisual(winnerScreen)
        }else{
            game.addVisual(dontWinnerScreen)
            game.schedule(2000, { 
                game.removeVisual(dontWinnerScreen)
            })
        }
    }

    // --------------------
    // Pausa / Reanudar
    // --------------------
    method togglePause() {
        if (isGameOver) { return }
        
        if (!isPaused) {
            isPaused = true
            log.info(self, "⏸ Game paused")
            game.addVisual(pauseScreen)
        } else {
            isPaused = false
            log.info(self, "▶ Resumed")
            game.removeVisual(pauseScreen)
        }

        return
    }

    // --------------------
    // Game Over
    // --------------------
    method gameOver() {        
        isGameOver = true
        log.info(self, "💀 GAME OVER 💀")
        game.addVisual(gameOverScreen)
    }

    // --------------------
    // Reiniciar
    // --------------------
    method restartGame() {
        log.info(self, "🔄 Restarting game...")
        isGameOver = false

        // Limpiar estado previo
        colissionHandler.clear()
        objectPool.deactivateArea(gameCurrentStatus.actualArea().name())
        objectPool.reset() // Resetea todos los objetos del pool

        // Reiniciar estado del juego
        solidSnake.position(game.at(13, 1))
        solidSnake.heal(100)
        gameCurrentStatus.modifyArea(area01)
        hud.initHUD()
        levelsManager.loadIntro()
    }
}
