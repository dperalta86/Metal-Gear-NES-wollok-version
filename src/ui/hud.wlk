import src.utils.log.*
import src.ui.visual.heart
import wollok.game.*

object hud {
    const fullHearts = []
    var currentHearts = []

    method initHUD() {
        fullHearts.add(heart.create(game.at(2, 0)))
        fullHearts.add(heart.create(game.at(3, 0)))
        fullHearts.add(heart.create(game.at(4, 0)))
        fullHearts.add(heart.create(game.at(5, 0)))
        fullHearts.add(heart.create(game.at(6, 0)))
        currentHearts = fullHearts.take(5)
        log.debug(self, "Inicializado correctamente")
    }

    method drawHearts(){
        currentHearts.forEach { h =>
            game.addVisual(h)}
    }

    method lostHeart(){
        const actualHearts = currentHearts.size()
        currentHearts.forEach({h => game.removeVisual(h)})
        currentHearts.clear()
        currentHearts = fullHearts.take(actualHearts - 1)
        self.drawHearts()
    }

    method recoverHearts() {
        currentHearts.forEach({h => game.removeVisual(h)})
        currentHearts.clear()
        currentHearts = fullHearts.take(5)
        self.drawHearts()
    }
}

