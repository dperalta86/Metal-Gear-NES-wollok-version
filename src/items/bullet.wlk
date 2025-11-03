import src.system.colissions.*
import wollok.game.*
import src.gameObject.GameObject


class Bullet inherits GameObject{
    var gunDirection = "right"
    var active = false
    override method image() = gunDirection + "_bullets.gif"

    method fire(pos, direction, isVisible){
        if (!active){
            position = pos
            gunDirection = direction
            active = true            
            canBeCollided = true
            colissionHandler.register(self)
            game.schedule(750, { self.stop() })
            if(isVisible){
                game.addVisual(self)
            }
        }
    }

    method stop() {
        canBeCollided = false
        game.removeVisual(self)
        colissionHandler.unregister(self)
        active = false
    }

    override method collidedBy(character){
        character.takeDamage(50)
    }
}

object bulletManager{
    const matchDirection = new Dictionary()
    method init() {
        matchDirection.put("right", { pos => game.at(pos.x()+1, pos.y()) })
        matchDirection.put("left", { pos => game.at(pos.x()-1, pos.y()) })
        matchDirection.put("up", { pos => game.at(pos.x(), pos.y()+1) })
        matchDirection.put("down", { pos => game.at(pos.x(), pos.y()-1) })      
    }

    method takeBullets() = [
        new Bullet(position=game.origin()),
        new Bullet(position = game.origin()),
        new Bullet(position = game.origin())
    ]

    method fire(pos, direction, bullets) {
        var isVisible = true
        var position = pos
        if (direction == "left"){
            position = game.at(pos.x()-2, pos.y()) // desplazo porque el visual "viene" de izq a derecha
        }
        bullets.forEach({ bullet =>       
            bullet.fire(position, direction, isVisible)
            position = matchDirection.basicGet(direction).apply(position)
            isVisible = false
        })
        
    }
}