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

    // Queda "genérico", ver si directamente lo personalizamos a snake...
    override method collidedBy(other) {
        other.takeDamage(50)    
    }

    override method update() {
        if (isAlive && isActive) {
            self.move()
        }
    }
    
    // Comportamiento polimórfico (Interfaz) 
    method move()
    method verifyDetection() // Lógica para detectar al jugador    
    method updateState() // Lógica para actualizar el estado    
}