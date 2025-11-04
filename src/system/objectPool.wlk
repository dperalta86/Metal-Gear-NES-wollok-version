import src.utils.utils.utils
import src.utils.log.log
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
        areaFactory.initializeMatchTile()

        var i = 0
        allTileMapsLevel01.forEach { tileMatrix =>
            const areaName = allAreasLevel01.get(i).name()
            log.debug(self, "Cargando objetos de " + areaName + "...")
            const objs = areaFactory.createObjectsFromMatrix(tileMatrix)
            objectsByArea.put(areaName, objs)
            i = i + 1
        }
        log.info(self, "✓ Pool inicializado. Total áreas: " + objectsByArea.keys().size())
    }

    method activateArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        areaObjects.forEach ({ obj => 
            obj.activate()
            colissionHandler.register(obj)
            game.addVisual(obj) 
        })    
        
        log.debug(self, "Área " + areaName + " activada (" + areaObjects.size() + " objetos)")
    }

    method deactivateArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        areaObjects.forEach { obj => self.deactivateObject(obj)}

        log.debug(self, "Área " + areaName + " desactivada")
    }

    method deactivateObject(obj) {
        obj.deactivate()
        colissionHandler.unregister(obj)
        game.removeVisual(obj)
    }

    method reset() {
        objectsByArea.values().forEach { areaList =>
        areaList.forEach { obj =>
            if (game.hasVisual(obj))
                game.removeVisual(obj)
        }
    }
}


    method getObjectsForArea(areaName) = objectsByArea.get(areaName)
    
    method getActiveGuardsInCurrentArea() {
    const areaObjects = self.getObjectsForArea(gameCurrentStatus.actualArea().name())
    if (areaObjects == null) return []

    return areaObjects.filter({ obj =>
        obj.isActive() && (utils.getClassName(obj) == "PatrollGuard" || utils.getClassName(obj) == "StaticGuard")
    })
}

}
