import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard

class PatrollGuard inherits Guard {
    override method image() = "patroll_guard.png"
    
    override method comportamiento() {
        // TODO: lógica de patrullaje
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
const patroll01 = new PatrollGuard (position = game.at(5,9))

// Area02
const patroll02 = new PatrollGuard (position = game.at(2,8))

// Area 03
const patroll03 = new PatrollGuard (position = game.at(4,5))

// Area04
const patroll04A = new PatrollGuard (position = game.at(6,10))
const patroll04B = new PatrollGuard (position = game.at(14,3))
