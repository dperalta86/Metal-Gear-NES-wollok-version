import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard


class StaticGuard inherits Guard {
    method image() = "static_guard.png"
    
    override method comportamiento() {
        // Los guardias estáticos no se mueven
        // TODO: agregar rotación ocasional
    }
    
    override method verificarDeteccion() {
        // TODO: detectar jugador en rango
    }
    
    override method actualizarEstado() {
        // TODO: cambiar estado según detección
    }
}
