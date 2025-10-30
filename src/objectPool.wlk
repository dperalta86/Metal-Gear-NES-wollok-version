import src.levels.factory.areaFactory
import src.system.colissions.colissionHandler
import src.characters.guards.patrollGuard.PatrollGuard
import src.characters.guards.staticsGuard.StaticGuard
import wollok.game.*
import src.gameObject.GameObject
import src.levels.tilemap.*

/*
 * ObjectPool - Pool de objetos pre-instanciados
 * Usa el Factory para crear objetos, pero los mantiene en memoria
 * y solo activa/desactiva según el área actual
 */
object objectPool {
    // Pools separados por tipo para búsqueda eficiente
    const guards = []
    const obstacles = []
    const collectibles = []
    
    // Mapeo de objetos por área: "area01" -> [obj1, obj2, ...]
    const objectsByArea = new Dictionary()
    
    /*
     * Inicializa el pool completo del nivel
     * Usa el Factory para instanciar TODOS los objetos de todas las áreas
     */
    method initializeLevel01() {
        console.println("=== Inicializando Object Pool ===")
        const startTime = new Date()
        
        // Inicializar el Factory primero
        areaFactory.initializeMatchTile()
        
        // Pre-crear todos los objetos de cada área usando el Factory
        self.preCreateArea("area01", tileMapArea01)
        self.preCreateArea("area02", tileMapArea02)
        self.preCreateArea("area03", tileMapArea03)
        self.preCreateArea("area04", tileMapArea04)
        self.preCreateArea("area05", tileMapArea05)
        
        const endTime = new Date()
        console.println("Pool inicializado en " + (endTime - startTime) + "ms")
        console.println("Total guardias: " + guards.size())
        console.println("Total obstáculos: " + obstacles.size())
        console.println("Total coleccionables: " + collectibles.size())
        console.println("===================================")
    }
    
    /*
     * Pre-crea todos los objetos de una matriz de tiles
     * Delega la creación al Factory
     */
method preCreateArea(areaName, tileMatrix) {
    // 1. Pedir al Factory que cree los objetos
    const createdObjects = areaFactory.createObjectsFromMatrix(tileMatrix)
    
    // 2. Clasificar cada objeto
    createdObjects.forEach { obj =>
        self.classifyObject(obj)
    }
    
    // 3. ✓ Guardar en objectsByArea con el nombre del área
    objectsByArea.put(areaName, createdObjects)
}
    
    /*
     * Clasifica un objeto en su pool correspondiente
     * Usa duck typing para determinar el tipo
     */
    method classifyObject(obj) {
        const className = obj.className()
        
        if (className.contains("Guard")) {
            guards.add(obj)
        } else if (className.contains("Invisible") || className.contains("Door")) {
            obstacles.add(obj)
        } else if (className.contains("Key") || className.contains("Weapon") || 
                   className.contains("Health") || className.contains("Box")) {
            collectibles.add(obj)
        }
    }

    /*
     * Activa todos los objetos de un área
     * RÁPIDO - Solo llama a activate() en objetos pre-creados
     */
method activateArea(areaName) {
    const areaObjects = objectsByArea.get(areaName)
    
    areaObjects.forEach { obj =>
        obj.activate()
    }
    
    colissionHandler.enableArea(areaObjects)  // Solo habilita colisión interna
    console.println("✓ Área " + areaName + " activada: " + areaObjects.size() + " objetos")
}

method deactivateArea(areaName) {
    const areaObjects = objectsByArea.get(areaName)
    
    colissionHandler.disableArea(areaObjects)
    areaObjects.forEach { obj => obj.deactivate() }
    
    console.println("✓ Área " + areaName + " desactivada")
}

    
    /*
     * Obtiene todos los objetos de un área (activos o no)
     */
    method getObjectsForArea(areaName) {
        return objectsByArea.get(areaName)
    }

    /*
    * Devuelve todos los objetos pre-creados del pool
    */
    method getAllObjects() {
        var all = []
        all.addAll(guards)
        all.addAll(obstacles)
        all.addAll(collectibles)
        return all
    }

    
    /*
     * Obtiene solo los guardias activos de un área
     */
    method getActiveGuardsForArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        return areaObjects.filter { obj => 
            obj.className().contains("Guard") && obj.isActive()
        }
    }
    
    /*
     * Obtiene todos los guardias de un área (para testing)
     */
    method getAllGuardsForArea(areaName) {
        const areaObjects = objectsByArea.get(areaName)
        return areaObjects.filter { obj => 
            obj.className().contains("Guard")
        }
    }
    
    /*
     * Limpia todo el pool (para reiniciar nivel)
     */
    method clearAll() {
        guards.forEach { g => g.deactivate() }
        obstacles.forEach { o => o.deactivate() }
        collectibles.forEach { c => c.deactivate() }
        
        guards.clear()
        obstacles.clear()
        collectibles.clear()
        objectsByArea.clear()
        
        console.println("Pool limpiado completamente")
    }
    
    /*
     * Métodos de utilidad para debugging
     */
    method getTotalObjects() {
        return guards.size() + obstacles.size() + collectibles.size()
    }
    
    method printStats() {
        console.println("=== Object Pool Stats ===")
        console.println("Guardias: " + guards.size())
        console.println("Obstáculos: " + obstacles.size())
        console.println("Coleccionables: " + collectibles.size())
        console.println("Total: " + self.getTotalObjects())
        console.println("Áreas cargadas: " + objectsByArea.keys().size())
        console.println("========================")
    }
}