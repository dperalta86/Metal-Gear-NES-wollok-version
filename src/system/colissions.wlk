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

        method processInteraction(character) {
        const item = game.getObjectsIn(character.position())
                                .find({ obj => obj.isPickable() })
        if (item != null) {
            console.println("encontre el item")
            item.use(character)
        }
    }
}

