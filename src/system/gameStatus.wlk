import src.levels.level01.*
import src.levels.tilemap.*

/*
 * GameCurrentStatus - Estado Global del Juego
 * Ahora también maneja la matriz de colisiones actual
 * VENTAJA: Single Source of Truth - una sola referencia al área y su matriz
 */
object gameCurrentStatus {
    const levels = ["level 01", "level 02", "final level"]
    const idxCurrentLevel = 0
    var currentLevel = levels.get(idxCurrentLevel)
    
    // Estado del área
    var currentArea = area01
    var currentTileMap = tileMapArea01  // ← NUEVO: Referencia a matriz actual
    
    /*
     * Getters
     */
    method actualArea() = currentArea 
    method currentLevel() = currentLevel
    method currentTileMap() = currentTileMap
    
    /*
     * Cambia de área y actualiza la matriz correspondiente
     */
    method modifyArea(newArea) {
        currentArea = newArea
        
        // Actualizar referencia a la matriz correspondiente
        currentTileMap = self.getTileMapForArea(newArea.name())
        
        console.println("  [GameStatus] Matriz actualizada para " + newArea.name())
    }
    
    // TODO: Mejorar este método para evitar hardcoding, cumple su función por ahora
    method getTileMapForArea(areaName) {
        if (areaName == "area02") return tileMapArea02
        if (areaName == "area03") return tileMapArea03
        if (areaName == "area04") return tileMapArea04
        if (areaName == "area05") return tileMapArea05
        return tileMapArea01
    }
    
    /*
     * Verifica si una posición está bloqueada en la matriz actual
     * O(1) - Ultra rápido!
     */
    method isBlocked(pos) {
        const x = pos.x()
        const y = pos.y()
        
        // Verificar límites
        if (y < 0 || y >= currentTileMap.size()) return true
        
        const row = currentTileMap.get(y)
        if (x < 0 || x >= row.size()) return true
        
        // Obtener el tile y verificar si es colisión
        const tile = row.get(x)
        return tile == tileTypes.collision()  // ← Comparación directa con "C"
    }
    
    /*
     * Obtiene el tipo de tile en una posición
     * Útil para efectos especiales (trampas, etc.)
     */
    method getTileAt(pos) {
        const x = pos.x()
        const y = pos.y()
        
        if (y < 0 || y >= currentTileMap.size()) return tileTypes.empty()
        
        const row = currentTileMap.get(y)
        if (x < 0 || x >= row.size()) return tileTypes.empty()
        
        return row.get(x)
    }
    
    /*
     * Verifica si hay un tile específico en una posición
     */
    method hasTileTypeAt(pos, tileType) {
        return self.getTileAt(pos) == tileType
    }
    
    /*
     * Level up
     */
    method levelUp() {
        if (idxCurrentLevel >= 0 && idxCurrentLevel < levels.size() - 1) {
            currentLevel = levels.get(idxCurrentLevel + 1)
        }
    }
}