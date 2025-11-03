import src.utils.log.log
import src.utils.utils.utils
import src.items.bullet.bulletManager
import src.gameObject.GameObject

class Pickable inherits GameObject {
    override method isPickable() = true
     
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
}

class Box inherits Pickable {
    var durability = 2

    method durability() = durability

    override method image() = "cardboardBox.png"

    override method beUse(character) {
        console.println("Snake se esconde en la caja.")
        character.activateBoxMode(self)
        log.info(self, utils.getClassName(character + " se esconde en la caja"))
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

class Key inherits Pickable {
    const type = "red" // Puede ser "red" o "blue", lo define el factory
    override method image() = type + "_key.png"
}


class Weapon inherits Pickable {
    var bullets = bulletManager.takeBullets()
    override method image() = "weapon.png"


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
    override method image() = "health.png"

    override method beUse(character) {
        character.heal(50)
        // Se usa y se destruye...
        character.giveUpItem()
        isActive = false
        log.info(self, utils.getClassName(character) + " usa medicina")
    }
}
