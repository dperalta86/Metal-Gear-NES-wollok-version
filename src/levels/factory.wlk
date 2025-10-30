import src.objectPool.*
import src.system.gameStatus.*
import src.system.system.levelsManager
import src.system.colissions.colissionHandler
import src.obstacles.invisibleObject.Invisible
import src.characters.guards.patrollGuard.*
import src.characters.guards.staticsGuard.*
import wollok.game.*
import src.levels.tilemap.*

object areaFactory {
    const match_tile = new Dictionary()

    /*
     * Inicializa el mapeo de tiles a constructores
     * Se llama UNA vez al inicio del juego
     */
    method initializeMatchTile() {
        match_tile.put(tileTypes.empty(), { pos => self.doNothing(pos)  })
        match_tile.put(tileTypes.staticGuard(), { pos => self.createStaticGuard(pos) })
        match_tile.put(tileTypes.patrolGuard(), { pos => self.createPatrolGuard(pos) })
        match_tile.put(tileTypes.door(), { pos => self.createDoor(pos) })
        match_tile.put(tileTypes.box(), { pos => self.createBox(pos) })
        match_tile.put(tileTypes.redKey(), { pos => self.createRedKey(pos) })
        match_tile.put(tileTypes.blueKey(), { pos => self.createBlueKey(pos) })
        match_tile.put(tileTypes.weapon(), { pos => self.createWeapon(pos) })
        match_tile.put(tileTypes.health(), { pos => self.createHealth(pos) })
        match_tile.put(tileTypes.collision(), { pos => self.createInvisibleCollision(pos) })
    }

    method createObjectsFromMatrix(tileMatrix) {
        const createdObjects = [] 
        const totalRows = tileMatrix.size()
        var rowIndex = 0

        tileMatrix.forEach { fila =>
            var x = 0
            const y = (totalRows - 1) - rowIndex

            fila.forEach { tile =>
                const pos = game.at(x, y)
                const newObject = self.createObjectFromTile(tile, pos)
                if (newObject != null) {
                    createdObjects.add(newObject)
                }
                x = x + 1
            }
            rowIndex = rowIndex + 1
        }
        return createdObjects 
    }


    /*
     * Crea un objeto desde un tile y posición
     * CRÍTICO: Solo instancia, NO agrega a game ni activa
     * Retorna el objeto creado o null si es tile vacío
     */
    method createObjectFromTile(tile, pos){
        const newTile = match_tile.basicGet(tile)

        // Si el tile es vacío, no hago nada
        if (newTile.toString() == "{ pos => self.doNothing(pos)  }") {
            return null
        }
        return newTile.apply(pos)
    }

    //Solo para que no rompa y poder manejar los tiles vacíos
    method doNothing(pos){ }

    // Métodos particulares para instaniar los objetos
    method createStaticGuard(pos){
        return new StaticGuard(position = pos, lastPosition = pos)

    } 

    method createPatrolGuard(pos){
        return new PatrollGuard(position = pos, lastPosition = pos)
    }

    method createInvisibleCollision(pos){
        return new Invisible(position = pos)
    } 

    method createDoor(pos){
        // Por ahora, sigo manejando las puertas como objetos visuales simples
        return null
    }


    // TODO: Implementar estos métodos
    method createBox(pos){
        return null
    }

    method createRedKey(pos){
        return null
    }

    method createBlueKey(pos){
        return null
    }

    method createWeapon(pos){
        return null
    }

    method createHealth(pos){
        return null
    }
}