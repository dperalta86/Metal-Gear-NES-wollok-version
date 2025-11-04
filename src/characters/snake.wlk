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
    var currentItem = null
    const equipment = [] // -> Si llegamos, agregamos que pueda cambiar entre items
    
    method currentItem() = currentItem
    
    // TODO: directamente puede devolver "sknake_" + currentItem.className() + self.lastMovement() + ".png"
    override   method image() {
        if (currentItem != null) {
            return currentItem.image()
        } else {
            return "snake_" + self.lastMovement() + ".png"
        }
    }
    
    /*
     * Hook: Se ejecuta después de cambiar de posición
     */
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
        if (utils.getClassName(other) == "Health"){
            self.heal(100)
            hud.recoverHearts()
            objectPool.deactivateObject(other)
        }
        if (utils.getClassName(other) != "Health"){
            super(other)
        }
    }
    // TODO: Métodos adicionales específicos de Snake (usar objetos, agacharse, etc.)
    /*
    * Recoge un ítem en la posición actual (si hay alguno)
    */
    method pickItem() {
        colissionHandler.processPickItem(self)
    }


    /*
    * Suelta el ítem actual (si tiene alguno)
    */
    method dropItem() {
        colissionHandler.processDropItem(self)
    }

     method pickUpItem(item) {
        equipment.add(item)
        currentItem = item
    }

    method giveUpItem() {
        if (currentItem != null) {
            currentItem.drop(self)
        }
        currentItem = null
    }

    method useItem() {
        if (currentItem != null) {
            log.info(self, "Snake usa: " + utils.getClassName(currentItem))
            currentItem.beUse(self)
        } else {
            log.info(self, "No tiene ningún objeto para usar.")
        }
    }

    method lostItem(item){
        if(currentItem == item){
            currentItem = null
        }
        if (equipment != [] && equipment.contains(item)){
            equipment.remove(item)
        }
    }
}

const solidSnake = new Snake(
    position = game.origin(),
    lastPosition = game.origin(),
    movementSpeed = 1
)