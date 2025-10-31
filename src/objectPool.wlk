import src.system.gameStatus.*
import src.levels.factory.areaFactory
import src.system.colissions.colissionHandler
import src.characters.guards.patrollGuard.PatrollGuard
import src.characters.guards.staticsGuard.StaticGuard
import wollok.game.*
import src.gameObject.GameObject
import src.levels.tilemap.*
import src.levels.level01.*


/*
 * ObjectPool - Pool de objetos pre-instanciados
 * Usa el Factory para crear objetos, pero los mantiene en memoria
 * y solo activa/desactiva según el área actual
 */
object objectPool {
    const objectsByArea = new Dictionary()

    method initializeLevel01() {
        console.println("=== Inicializando Object Pool ===")
        areaFactory.initializeMatchTile()

        var i = 0
        allTileMapsLevel01.forEach { tileMatrix =>
            const areaName = allAreasLevel01.get(i).name()
            console.println("Cargando objetos de " + areaName + "...")
            const objs = areaFactory.createObjectsFromMatrix(tileMatrix)
            objs.forEach { obj => obj.canBeCollided(false) } // Para garantizar que no se inicien colosionables
            objectsByArea.put(areaName, objs)
            i = i + 1
        }

        console.println("✓ Pool inicializado. Total áreas: " + objectsByArea.keys().size())
    }

    method activateArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        areaObjects.forEach { obj =>
            obj.activate() // Delego la responsabilidad de activar al objeto
        }
        console.println("Área " + areaName + " activada (" + areaObjects.size() + " objetos)")
    }

    method deactivateArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        areaObjects.forEach { obj =>
            obj.deactivate()
        }
        console.println("Área " + areaName + " desactivada")
    }

    method getObjectsForArea(areaName) = objectsByArea.get(areaName)
    
    method getActiveGuardsInCurrentArea() {
    const areaObjects = self.getObjectsForArea(gameCurrentStatus.actualArea().name())
    if (areaObjects == null) return []

    return areaObjects.filter({ obj =>
        obj.isActive() && (obj.className().contains("PatrollGuard") || obj.className().contains("StaticGuard"))
    })
}

}
