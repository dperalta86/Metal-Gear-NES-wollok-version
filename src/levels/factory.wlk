import src.items.winner.Winner
import src.utils.log.log
import src.characters.guards.staticsGuard.*
import src.characters.guards.patrollGuard.*
import src.items.pickables.*
import src.levels.tilemap.*

object areaFactory {
    const match_tile = new Dictionary()

    method initializeMatchTile() {
        match_tile.put(tileTypes.empty(), { pos => null })
        match_tile.put(tileTypes.staticGuard(), { pos => new StaticGuard(position = pos, isCollidable = true) })
        match_tile.put(tileTypes.patrolGuard(), { pos => new PatrollGuard(position = pos, isCollidable = true) })
        match_tile.put(tileTypes.door(), { pos => null }) // Las puertas se manejan aparte
        match_tile.put(tileTypes.box(), { pos => new Box(position = pos) })
        match_tile.put(tileTypes.redKey(), { pos => new RedKey(position = pos) })
        match_tile.put(tileTypes.blueKey(), { pos => new BlueKey(position = pos) })
        match_tile.put(tileTypes.weapon(), { pos => new Weapon(position = pos) })
        match_tile.put(tileTypes.health(), { pos => new Health(position = pos, isCollidable = true) })
        match_tile.put(tileTypes.collision(), { pos => null })
        match_tile.put(tileTypes.winner(), { pos => new Winner(position = pos, isCollidable = true) })
        log.debug(self, "MatchTile cargado")
    }

    method createObjectsFromMatrix(tileMatrix) {
        const totalRows = tileMatrix.size()
        const result = []
        var rowIndex = 0

        tileMatrix.forEach { fila =>
            var x = 0
            const y = (totalRows - 1) - rowIndex

            fila.forEach { tile =>
                const pos = game.at(x, y)
                const builder = match_tile.basicGet(tile)
                if (builder != null) {
                    const newObj = builder.apply(pos)                    
                    if (newObj != null) { result.add(newObj) }
                }
                x = x + 1
            }

            rowIndex = rowIndex + 1
        }

        return result
    }
}