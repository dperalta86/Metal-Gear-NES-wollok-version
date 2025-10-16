import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard


class StaticGuard inherits Guard {
    override method image() = "static_guard.png"
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

/**
 * Instancio guardias estáticos del nivel 01
 * por el momento, los guardias no mantienen "estado", igualmente los separo por area.
 * TODO: Handler que maneje el estado de todos los guardias y haga el update cuando carga el area.
 */
// Area01
const static01 = new StaticGuard (position = game.at(1,1), lastPosition = game.at(1,1))

// Area02
const static02 = new StaticGuard (position = game.at(18,10), lastPosition = game.at(18,10))

// Area03
const static03A = new StaticGuard (position = game.at(9,3), lastPosition = game.at(9,3))
const static03B = new StaticGuard (position = game.at(2,10), lastPosition = game.at(2,10))