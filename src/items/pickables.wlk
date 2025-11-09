import src.utils.log.log
import src.utils.utils.utils
import src.items.bullet.bulletManager
import src.gameObject.GameObject

class Pickable inherits GameObject {
    override method isPickable() = true
    method displayImage()
    override method image() = self.displayImage() + ".png"
     
    /*
     * Se llama cuando el personaje levanta el ítem
     */
    method equip(character) {
        character.pickUpItem(self)
        game.removeVisual(self)
        isActive = false
    }

    /*
     * Se llama cuando el personaje suelta el ítem
     */
    method drop(character) {
        position = character.position()
        game.addVisual(self)
        isActive = true
    }

    /*
     * Se llama cuando el ítem se usa (override en subclases)
     */
    method beUse(character) {}

    /*
     * Se llama cuando el ítem "recibe" daño (override en subclases)
     */
    method damageDecreases(character, amount) {}
}

class Box inherits Pickable {
    var durability = 2
    override method displayImage() = "cardboardBox"

    override method beUse(character) {
        log.debug(self, utils.getClassName(character + " se escondió en la caja"))
    }

    override method damageDecreases(character, amount){
        self.reduceDurability()
        if (durability <= 0) {
            character.removeItemFromEquipment(self)
        }
        return amount/2
    }

    method reduceDurability() {
        durability = durability - 1
        if (durability <= 0) {
            game.removeVisual(self)
            isActive = false
            log.info(self, "La caja se destruyó.")
        }           
    }
}

class BlueKey inherits Pickable {
    override method image() = "blue_key.png"
    override method displayImage() = "empty"
}

class RedKey inherits BlueKey {
    method checkWin() = true
    override method image() = "red_key.png"
}

class Weapon inherits Pickable {
    const bullets = bulletManager.takeBullets()
    override method displayImage() = "weapon"

    override method beUse(character) {
        console.println("Snake dispara su arma. ¡Bang! ¡Bang!... estás liquidado")
        bulletManager.fire(
            character.position(), 
            character.lastMovement(),
            bullets
        )
    }
}


class Health inherits Pickable {
    override method isPickable() = false
    override method isCollidable() = true
    override method displayImage() = "empty"
    override method image() = "health.png"

    override method collidedBy(other) { }
}

class EmptyHands inherits Pickable{
    override method displayImage() = "empty"
}

const emptyHands = new EmptyHands(position = game.origin())