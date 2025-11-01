import src.system.objectPool.*
import src.system.gameStatus.*
import src.system.colissions.*
import src.ui.hud.hud
import src.system.system.config
import src.levels.areaManager.*
import src.levels.level01.*
import src.system.system.levelsManager
import src.characters.snake.*
import src.ui.visual.*


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
    // Pausa / Reanudar
    // --------------------
    method togglePause() {
        if (isGameOver) { return }
        
        if (!isPaused) {
            isPaused = true
            console.println("⏸ Game paused")
            game.addVisual(pauseScreen)
        } else {
            isPaused = false
            console.println("▶ Resumed")
            game.removeVisual(pauseScreen)
        }

        return
    }

    // --------------------
    // Game Over
    // --------------------
    method gameOver() {        
        isGameOver = true
        console.println("💀 GAME OVER 💀")
        game.addVisual(gameOverScreen)
    }

    // --------------------
    // Reiniciar
    // --------------------
    method restartGame() {
        console.println("🔄 Restarting game...")
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
