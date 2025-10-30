import src.characters.*
import src.levels.level01.*

/*
 * Manejador de colisiones mejorado
 * Trabaja con objetos pre-instanciados del pool
 * Se instancian todas las colisiones al inicio del juego para minimizar lag
 */
object colissionHandler {
    const collidableObjects = []   // Todos los objetos con colisión pre-registrados
    var initialized = false         // Para asegurarnos de registrar solo una vez

    /*
     * Inicializa todas las colisiones de los objetos pre-creados
     * Llamar UNA sola vez al inicio del juego
     */
    method initializeAll(objects) {
        if (initialized) { return }
        
        objects.forEach { obj =>
            if (obj != null && obj.esColisionable() && !collidableObjects.contains(obj)) {
                collidableObjects.add(obj)
                
                game.whenCollideDo(obj, { other =>
                    other.collidedBy(obj)
                })
            }
        }
        
        initialized = true
        console.println("CollisionHandler: todas las colisiones registradas (" + collidableObjects.size() + " objetos)")
        return
    }

    /*
     * Activar colisión para un objeto activo
     * Ya fue registrado, solo habilitar flag interno
     */
    method enable(obj) {
        if (obj != null && obj.esColisionable()) {
            obj.canBeCollided(true)
        }
    }

    /*
     * Desactivar colisión de un objeto
     */
    method disable(obj) {
        if (obj != null && obj.esColisionable()) {
            obj.canBeCollided(false)
        }
    }

    /*
     * Activar colisión de todos los objetos de un área
     */
    method enableArea(areaObjects) {
        areaObjects.forEach { obj => self.enable(obj) }
    }

    /*
     * Desactivar colisión de todos los objetos de un área
     */
    method disableArea(areaObjects) {
        areaObjects.forEach { obj => self.disable(obj) }
    }

    /*
     * Para testing o queries
     */
    method hasColissionAt(pos) {
        return collidableObjects.any { obj => obj.esColisionable() && obj.position() == pos }
    }

    method getCollidableObjects() = collidableObjects
}
