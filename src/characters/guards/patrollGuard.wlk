import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard

class PatrolGuard inherits Guard {
    method image() = "patroll_guard.png"
    
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
