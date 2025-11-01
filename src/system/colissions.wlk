import src.characters.*
import src.levels.level01.*

/*
 * Manejador de colisiones mejorado
 * Trabaja con objetos pre-instanciados del pool
 * Se instancian todas las colisiones al inicio del juego para minimizar lag
 */
object colissionHandler {

    const registered = []

    method register(obj) {
        if (obj != null && obj.isCollidable() && !registered.contains(obj)) {
            registered.add(obj)
            game.whenCollideDo(obj, { gameObject => gameObject.collidedBy(obj) })
        }
    }

    method unregister(obj) {
        if (registered.contains(obj)) registered.remove(obj)
    }

    method clear() {
        registered.clear()
    }

    /*
    * Devuelve el primer objeto pickable en la posición actual del personaje
    */
    method getPickableAt(character) {
        return game.getObjectsIn(character.position())
                .find({ obj => obj.isPickable() })
    }

    /*
    * Intenta que el personaje recoja un objeto en su posición
    */
    method processPickItem(character) {
        const item = self.getPickableAt(character)
        if (item != null) {
            console.println("Snake recoge: " + item.className())
            item.equip(character)
        } else {
            console.println("No hay nada que recoger aquí.")
        }
    }

    /*
    * Intenta que el personaje suelte su objeto actual
    */
    method processDropItem(character) {
        if (character.currentItem() != null) {
            console.println("Snake suelta el objeto.")
            character.giveUpItem()
        } else {
            console.println("No tiene ningún objeto equipado.")
        }
    }
}

