import wollok.game.* // Es necesario importar wollok.game.* cuando defino una clase?

import src.characters.guards.guards.Guard


class StaticGuard inherits Guard {
    override method image() = "static_guard.png"
    // Comportamiento polimórfico (Interfaz)
    override method move() { } 
    override method verifyDetection() { } 
    override method updateState() { }
}