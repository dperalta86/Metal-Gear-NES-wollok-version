import src.characters.*
import src.levels.level01.*

/*
 * Manejador de colisiones mejorado
 * Trabaja con objetos pre-instanciados del pool
 * Se instancian todas las colisiones al inicio del juego para minimizar lag
 */
object colissionHandler {
    const collidableObjects = []

    method register(obj) {
        if (obj == null || !obj.canBeCollided()) { return }

        collidableObjects.add(obj)

        game.whenCollideDo(obj, { other =>
            obj.collidedBy(other)
            other.collidedBy(obj)
        })

        console.println("Registrado para colisión: " + obj.className())
        return
    }
}
