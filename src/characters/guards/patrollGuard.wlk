import src.inputManager.movements.*
import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard

class PatrollGuard inherits Guard {
    override method image() = "patroll_guard.png"
    
    override method comportamiento() {
        game.schedule(500, { movement.moveUp(self) })
        game.schedule(1000, { movement.moveRight(self) })
        game.schedule(1500, { movement.moveRight(self) })
        game.schedule(2000, { movement.moveRight(self) })
        game.schedule(2500, { movement.moveDown(self) })
        game.schedule(3000, { movement.moveDown(self) })
        game.schedule(3500, { movement.moveLeft(self) })
        game.schedule(4000, { movement.moveLeft(self) })
        game.schedule(4500, { movement.moveLeft(self) })
        game.schedule(5000, { movement.moveLeft(self) })
        game.schedule(5500, { movement.moveUp(self) })
        game.schedule(6000, { movement.moveRight(self) })        
    }
    
    override method verificarDeteccion() {
        // TODO: detectar jugador en rango
    }
    
    override method actualizarEstado() {
        // TODO: cambiar estado según detección
    }
}

// Instancio guardias de nivel 01

// Area01
const patroll01 = new PatrollGuard (position = game.at(5,9), lastPosition = game.at(5,9))

// Area02
const patroll02 = new PatrollGuard (position = game.at(2,8), lastPosition = game.at(2,8))

// Area 03
const patroll03 = new PatrollGuard (position = game.at(4,5), lastPosition = game.at(4,5))

// Area04
const patroll04A = new PatrollGuard (position = game.at(6,10), lastPosition = game.at(6,10))
const patroll04B = new PatrollGuard (position = game.at(14,3), lastPosition = game.at(14,3))
