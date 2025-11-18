import src.utils.log.*
import src.ui.visual.*
import wollok.game.*

object hud {
    const fullHearts = []
    var currentHearts = []

    method initHUD() {
        [2,3,4,5,6].forEach { i =>
            fullHearts.add(heart.create(game.at(i, 0)))
        }
        currentHearts = fullHearts.take(5)
        log.debug(self, "Inicializado correctamente")
    }

    method drawHearts(){
        currentHearts.forEach { h =>
            game.addVisual(h)}
        if(!game.hasVisual(text_hud)){
            game.addVisual(text_hud)
        }
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

