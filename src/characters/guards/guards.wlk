import src.utils.utils.utils
import src.characters.character.Character
import src.system.colissions.colissionHandler
import src.inputManager.movements.movement

/*
 * Clase abstracta Guard, de ella heredan las clases de los distintos tipos de guardias
 */
class Guard inherits Character {
    override method image() {
        if(isAlive){
            return utils.getClassName(self) + ".png"
        }
        return "dead_guard.png"
    }

    override method collidedBy(other) {
        if(!other.isPickable()){
            super(other)
        } 
    }

    override method update() {
        if (isAlive && isActive) {
            self.move()
        }
    }
    
    // Comportamiento polimórfico (Interfaz) 
    method move()
}