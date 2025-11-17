import src.characters.equipment.snakeEquipment
import src.system.objectPool.*
import src.items.pickables.*
import src.utils.log.log
import src.utils.utils.utils
import src.ui.hud.hud
import src.gameManager.gameManager
import src.characters.character.Character
import src.inputManager.movements.*
import src.system.colissions.*
import src.levels.level01.*
import src.levels.areaManager.areaManager

/*
 * Solid Snake - Personaje principal controlado por el jugador
 * Hereda de Character pero tiene comportamiento único
 */
class Snake inherits Character {
    const equipment = snakeEquipment // -> Si llegamos, agregamos que pueda cambiar entre items
    const currentItem = snakeEquipment.itemInUse()

    method equipment() = equipment
    override method image() = "snake_" + currentItem.displayImage() + "_" + self.lastMovement() + ".png"

    override method onPositionChanged() {
        // Verificar si Snake debe cambiar de área
        areaManager.update(self)        
    }
    
    /*
     * Colisión con otros objetos
     */
    // Por ahora no justifica override metodo collidedBy(other)

    override method takeDamage(amount) {
        var damage = amount
        if (currentItem != null){
            damage = currentItem.damageDecreases(self, amount)
        }
        super(damage)
        hud.lostHeart()
    }

    override method die() {
        super()
        gameManager.gameOver()
    }
    
    override method collidedBy(other){
        if (utils.getClassName(other) != null && utils.getClassName(other) == "Health"){
            self.heal(100)
            hud.recoverHearts()
            objectPool.deactivateObject(other)
        }
        if (utils.getClassName(other) != null && utils.getClassName(other) == "Winner"){
            other.equip(self)
        }else{
            super(other)
        }
    }
    // TODO: Métodos adicionales específicos de Snake (usar objetos, agacharse, etc.)
    method pickUpItem(){
        equipment.pickUpItem()
    }

    method meetsConditionToWin() = equipment.any({ item =>
        item.checkWin()
    })
}

const solidSnake = new Snake(
    position = game.origin(),
    lastPosition = game.origin(),
    movementSpeed = 1
)