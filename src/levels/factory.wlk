import wollok.game.*
import src.levels.tilemap.*

object areaFactory {
    const match_tile = new Dictionary()
    var property newObjectPosition = game.origin()

    method initializeMatchTile() {
        match_tile.put(tileTypes.empty(), null)
        match_tile.put(tileTypes.staticGuard(), { self.createStaticGuard() })
        match_tile.put(tileTypes.patrolGuard(), {self.createPatrolGuard()})
        match_tile.put(tileTypes.door(), {self.createDoor()})
        match_tile.put(tileTypes.box(), {self.createBox()})
        match_tile.put(tileTypes.redKey(), {self.createRedKey()})
        match_tile.put(tileTypes.blueKey(), {self.createBlueKey()})
        match_tile.put(tileTypes.weapon(), {self.createWeapon()})
        match_tile.put(tileTypes.health(), {self.createHealth()})
        match_tile.put(tileTypes.collision(), {self.createInvisibleCollision()})
    }

    method createFromMatrix(tileMatrix){
        // Inicializo valores posición
        const posX = 0
        const posY = tileMatrix.size() - 1
        tileMatrix.forEach { fila => fila.forEach({ tile =>
            newObjectPosition = game.at(posX, posY)
            const newObject = self.createNewObjectFromMatrix(tile)
            posX++
            posY--

            if (!newObject)
            {
                game.addVisual(newObject)
            }
        })}
    }

    // Recibo como parámetro "que" y "en que posición"
    method createNewObjectFromMatrix(tile){
        const newTile = match_tile.basicGet(tile)
        newTile.apply()
    }

    // Métodos particulares para instaniar los objetos
    method createStaticGuard(){
        console.println("create StaticGuard!\n")
    } 

    method createPatrolGuard(){
        console.println("create PatrolGuard!\n")
    }

    method createDoor(){
        console.println("create Door!\n")
    }

    method createBox(){
        console.println("create Box!\n")
    }

    method createRedKey(){
        console.println("create Red Key!\n")
    }

    method createBlueKey(){
        console.println("create Blue Key!\n")
    }

    method createWeapon(){
        console.println("create Weapon!\n")
    }

    method createHealth(){
        console.println("create Healt!\n")
    }

    method createInvisibleCollision(){
        console.println("create Invisible Collision!\n")
    } 
        
}