import src.characters.*
import src.levels.level01.*

/*
 * Manejador de colisiones mejorado
 * Trabaja con objetos pre-instanciados del pool
 * Se instancian todas las colisiones al inicio del juego para minimizar lag
 */
object colissionHandler {
    const collidableObjects = [] // Lista de objetos con colisión registrada

    method register(obj) {
        if (obj == null)
        {
            return
        }

        if (obj.esColisionable()) {
            collidableObjects.add(obj)
            game.whenCollideDo(obj, { other =>
                other.collidedForGuard(obj)
            })
            console.println("Registrado para colisión: " + obj.className() + "\n")
        }

        return
    }    
}