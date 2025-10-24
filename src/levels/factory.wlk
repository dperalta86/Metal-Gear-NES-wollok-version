import wollok.game.*
import src.levels.tilemap.*

object areaFactory {
    const match_tile = new Dictionary()

    method initializeMatchTile() {
        match_tile.put(tileTypes.empty(), { pos => console.println("Empty space at " + pos) })
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

    method createFromMatrix(tileMatrix) {
        const totalRows = tileMatrix.size()
        var y = 0

        tileMatrix.forEach { fila =>
            var x = 0
            var y = (totalRows - 1) - y

            fila.forEach { tile =>
                const pos = game.at(x, y)
                self.createNewObjectFromMatrix(tile, pos)
                x = x + 1
            }

            y = y + 1
        }
    }

    // Recibo como parámetro "que" y "en que posición"
    method createNewObjectFromMatrix(tile, pos){
        const newTile = match_tile.basicGet(tile)
        if (newTile == null) {
            console.println("Tile desconocido: " + tile + " en posición " + pos)
            return
        }
        newTile.apply(pos)
        return
    }

    // Métodos particulares para instaniar los objetos
    method createStaticGuard(pos){
        console.println("create StaticGuard!\nPosition: " + pos)
    } 

    method createPatrolGuard(pos){
        console.println("create PatrolGuard!\nPosition: " + pos)
    }

    method createDoor(pos){
        console.println("create Door!\nPosition: " + pos)
    }

    method createBox(pos){
        console.println("create Box!\nPosition: " + pos)
    }

    method createRedKey(pos){
        console.println("create Red Key!\nPosition: " + pos)
    }

    method createBlueKey(pos){
        console.println("create Blue Key!\nPosition: " + pos)
    }

    method createWeapon(pos){
        console.println("create Weapon!\nPosition: " + pos)
    }

    method createHealth(pos){
        console.println("create Healt!\nPosition: " + pos)
    }

    method createInvisibleCollision(pos){
        console.println("create Invisible Collision!\nPosition: " + pos)
    } 
}