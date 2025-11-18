import src.characters.snake.snake.solidSnake
import src.system.colissions.*
import wollok.game.*
import src.gameObject.GameObject
import src.inputManager.movements.*



class Bullet inherits GameObject{
    var gunOwner = null // TODO: o por defecto snake, o crear objeto emptyGun
    var active = false
    var lastMovement = ""

    method lastMovement(movement) {
        lastMovement = movement
    }
    method image() = lastMovement + "_bullet.png"

    method fire(character){
        if (!active){
            gunOwner = character
            position = gunOwner.position()
            lastMovement = gunOwner.lastMovement()
            active = true            
            canBeCollided = true
            colissionHandler.register(self)
            game.addVisual(self)            
            game.schedule(300, { self.move() })
            game.schedule(600, { self.move() })
            game.schedule(900, { self.move() })
            game.schedule(1200, { self.stop() })            
        }
    }

    method stop() {
        canBeCollided = false
        game.removeVisual(self)
        colissionHandler.unregister(self)
        active = false
    }

    method move(){
        if(lastMovement == "left") { movement.moveLeft(self) }
        if(lastMovement == "right") { movement.moveRight(self) }
        if(lastMovement == "up") { movement.moveUp(self) }
        if(lastMovement == "down") { movement.moveDown(self) }
    }

    method moveTo(newPos) {
        position = newPos
    }
    override method collidedBy(character){
        character.takeDamage(50)
    }
}

object bulletManager{
/*     const matchDirection = new Dictionary()
    method init() {
        matchDirection.put("right", { pos => game.at(pos.x()+1, pos.y()) })
        matchDirection.put("left", { pos => game.at(pos.x()-1, pos.y()) })
        matchDirection.put("up", { pos => game.at(pos.x(), pos.y()+1) })
        matchDirection.put("down", { pos => game.at(pos.x(), pos.y()-1) })      
    } */

    method takeBullets() = [
        new Bullet(position = game.origin()),
        new Bullet(position = game.origin()),
        new Bullet(position = game.origin())
    ]

    method fire(character, bullets) {
        bullets.first().fire(character) //La primer bala es inmediata
        bullets.drop(1).forEach({ bullet =>      
            game.schedule(300, { bullet.fire(character) })            
        })        
    }
}