# Metal Gear NES - Documentación Técnica del Proyecto

## 📋 Información General

**Nombre del Proyecto:** Metal Gear NES Clone  
**Plataforma:** Wollok Game  
**Lenguaje:** Wollok  
**Tipo:** Juego de Sigilo 2D  
**Objetivo Académico:** Demostrar conceptos de POO (Polimorfismo, Herencia, Delegación, Patrones de Diseño)  
**Estado:** ✅ Completado y optimizado

---

## 🎯 Requerimientos Funcionales

### RF01 - Movimiento del Personaje Principal
- ✅ Snake se mueve en 4 direcciones (↑ ↓ ← →)
- ✅ Respeta colisiones con obstáculos
- ✅ Sprite actualiza según dirección de movimiento
- ✅ Sprite cambia según item equipado

### RF02 - Sistema de Guardias
- ✅ Dos tipos de guardias implementados:
  - **StaticGuard**: Permanece en posición, rota periódicamente
  - **PatrollGuard**: Movimiento aleatorio con pesos
- ✅ Sistema de actualización cada 500ms
- ✅ Guardias pueden ser eliminados (sistema de vida)
- ✅ Imagen cambia al morir

### RF03 - Inventario y Objetos
- ✅ Snake puede recolectar items (tecla A)
- ✅ Snake puede soltar items (tecla S)
- ✅ Snake puede usar items (tecla D)
- ✅ Items implementados:
  - Llaves (Azul, Roja)
  - Caja de cartón (durabilidad: 2 usos)
  - Arma (3 balas en ráfaga)
  - Health Kit (recuperación completa)

### RF04 - Interacciones del Entorno
- ✅ Sistema de áreas con transiciones fluidas
- ✅ Colisiones con paredes definidas por matriz
- ✅ 5 áreas interconectadas con eventos de cambio
- ✅ Cambio de área detectado por posición + dirección

### RF05 - Sistema de Game Over y Victoria
- ✅ Vida de Snake visible con HUD de corazones
- ✅ Game Over al llegar a 0 de vida
- ✅ Victoria al rescatar rehén (requiere llave roja)
- ✅ Sistema de reinicio funcional (tecla Space)
- ✅ Música de fondo con pausa/reanudación

### RF06 - Sistema de Combate
- ✅ Armas disparan proyectiles
- ✅ Balas causan 50 de daño
- ✅ Colisiones con guardias: 20 de daño
- ✅ Caja reduce daño a la mitad
- ✅ Health Kit restaura vida completa

---

## 🏗️ Arquitectura del Sistema

### Jerarquía Principal de Clases

```
GameObject (abstract)
├── position: Position
├── isActive: Boolean
├── isCollidable: Boolean
├── isPickable: Boolean
├── activate()
├── deactivate()
└── collidedBy(other)

Character extends GameObject
├── lastPosition: Position
├── lastMovement: String
├── direction: String
├── health: Integer (0-100)
├── isAlive: Boolean
├── moveTo(pos)
├── takeDamage(amount)
├── heal(amount)
└── die()

SolidSnake extends Character (WKO - Singleton)
├── equipment: snakeEquipment
├── pickItem()
├── dropItem()
├── useItem()
└── meetsConditionToWin()

Guard extends Character (abstract)
├── image() según estado (vivo/muerto)
└── move() [método polimórfico]
    ├── StaticGuard: rotación periódica cada 20 ticks
    └── PatrollGuard: movimiento aleatorio con pesos

Pickable extends GameObject
├── displayImage()
├── equip(character)
├── drop(character)
├── beUse(character)
├── damageDecreases(character, amount)
└── checkWin()
    ├── Box: esconderse, durabilidad 2
    ├── BlueKey: llave básica
    ├── RedKey: llave para ganar (checkWin = true)
    ├── Weapon: dispara 3 balas
    ├── Health: recuperación automática
    └── EmptyHands: manos vacías por defecto

Bullet extends GameObject
├── gunOwner: Character
├── active: Boolean
├── fire(character)
├── move()
└── stop()

Hostage extends GameObject
└── equip(character) → trigger victoria

Area (clase)
├── name: String
├── background: Visual
├── changeEvents: List<AreaChange>
├── load()
├── unload()
└── checkAreaChange(character)

AreaChange (clase)
├── position: Position
├── nextDirection: String
├── goToArea: Area
├── nextAreaPosition: Position
└── canCharacterChangeArea(character)
```

---

## 🔄 Aplicación de Polimorfismo

### 1. Sistema de Guardias - move()
```typescript
class Guard inherits Character {
    method move() // Método polimórfico abstracto
}

class PatrollGuard inherits Guard {
    const movements = [
        { movement.moveUp(self) },
        { movement.moveDown(self) },
        { movement.moveLeft(self) },
        { movement.moveLeft(self) },  // Peso extra
        { movement.moveRight(self) },
        { movement.moveRight(self) }  // Peso extra
    ]
    
    override method move() {
        movements.anyOne().apply()
    }
}

class StaticGuard inherits Guard {
    var moveCount = 0
    
    override method move() {
        moveCount += 1
        if (moveCount == 16) {
            self.getMove() // Secuencia predefinida de rotación
        }
    }
}
```

### 2. Sistema de Items - beUse()
```typescript
class Pickable {
    method beUse(character) {} // Por defecto no hace nada
}

class Box inherits Pickable {
    override method beUse(character) {
        // Snake se esconde
        log.debug(self, "Snake se escondió en la caja")
    }
}

class Weapon inherits Pickable {
    const bullets = bulletManager.takeBullets()
    
    override method beUse(character) {
        bulletManager.fire(character, bullets)
    }
}
```

### 3. Sistema de Colisiones - collidedBy()
```typescript
class GameObject {
    method collidedBy(other) {} // Comportamiento por defecto
}

class Character {
    override method collidedBy(other) {
        if (other.isActive() && other.canBeCollided()) {
            position = lastPosition
            if (utils.getClassName(other) != "Bullet") {
                self.takeDamage(20)
            } else {
                self.takeDamage(50)
            }
        }
    }
}

class Guard {
    override method collidedBy(other) {
        if (!other.isPickable()) {
            super(other)
        }
    }
}
```

---

## 🎨 Patrones de Diseño Implementados

### 1. Object Pool Pattern - objectPool

**Problema**: Crear y destruir objetos constantemente causaba lag masivo (~10 segundos por cambio de área).

**Solución**: Pre-instanciar TODOS los objetos del nivel al inicio y solo activar/desactivar según el área.

```typescript
object objectPool {
    const objectsByArea = new Dictionary()
    
    method initializeLevel01() {
        allTileMapsLevel01.forEach { tileMatrix =>
            const areaName = allAreasLevel01.get(i).name()
            const objs = areaFactory.createObjectsFromMatrix(tileMatrix)
            objectsByArea.put(areaName, objs)
        }
    }
    
    method activateArea(areaName) {
        objectsByArea.get(areaName).forEach { obj => 
            obj.activate()
            game.addVisual(obj)
        }
    }
    
    method deactivateArea(areaName) {
        objectsByArea.get(areaName).forEach { obj => 
            obj.deactivate()
            game.removeVisual(obj)
        }
    }
}
```

**Beneficios**:
- ⚡ Performance: 10s → 50-100ms (mejora de 100-200x)
- ✅ Sin memory leaks
- ✅ Transiciones fluidas entre áreas

---

### 2. Factory Pattern - areaFactory

**Problema**: Crear objetos manualmente es tedioso, propenso a errores y difícil de visualizar.

**Solución**: Definir niveles como matrices de caracteres y usar un factory para convertirlas en objetos.

```typescript
object areaFactory {
    const match_tile = new Dictionary()
    
    method initializeMatchTile() {
        match_tile.put("G", { pos => new StaticGuard(position = pos) })
        match_tile.put("P", { pos => new PatrollGuard(position = pos) })
        match_tile.put("R", { pos => new RedKey(position = pos) })
        match_tile.put("B", { pos => new Box(position = pos) })
        match_tile.put("W", { pos => new Weapon(position = pos) })
        match_tile.put("H", { pos => new Health(position = pos) })
        match_tile.put("X", { pos => new Hostage(position = pos) })
        // ...
    }
    
    method createObjectsFromMatrix(tileMatrix) {
        const result = []
        // Iterar matriz y crear objetos según el caracter
        return result
    }
}
```

**TileMap de ejemplo**:
```typescript
const tileMapArea01 = [
    [".",".",".",".",".",".",".",".",".",".",".",".","D",".",".","."],
    [".",".",".",".",".",".",".","P",".",".",".",".",".",".",".",".",],
    // ...
]
```

**Beneficios**:
- ✅ Diseño visual del nivel en código
- ✅ Fácil modificación y testing
- ✅ Extensible: nuevo objeto = nueva entrada en Dictionary

---

### 3. Singleton Pattern - solidSnake

**Problema**: Snake como clase generaba complejidad innecesaria en juego single-player.

**Solución**: Convertir a Well-Known Object (WKO).

```typescript
object solidSnake inherits Character {
    method initialize() {
        position = game.origin()
        health = 100
        // Reset de estado
    }
    
    const equipment = snakeEquipment
    
    override method image() = 
        "snake_" + 
        equipment.itemInUse().displayImage() + 
        "_" + 
        self.lastMovement() + ".png"
}
```

**Beneficios**:
- ✅ Una única instancia global
- ✅ Referencias simples desde cualquier parte
- ✅ Facilita debugging

---

### 4. State Pattern (implícito) - gameManager

**Problema**: Gestionar diferentes estados del juego (jugando, pausado, game over, victoria).

**Solución**: `gameManager` coordina transiciones entre estados.

```typescript
object gameManager {
    var isGameOver = false
    var isPaused = false
    
    method gameOver() {
        isGameOver = true
        game.addVisual(gameOverScreen)
        soundManager.pauseBGSound()
    }
    
    method restartGame() {
        isGameOver = false
        solidSnake.initialize()
        levelsManager.loadLevel1()
        soundManager.resumeBGSound()
    }
    
    method togglePause() {
        isPaused = !isPaused
        if (isPaused) {
            guardsBehavior.stop()
            soundManager.pauseBGSound()
        } else {
            guardsBehavior.start()
            soundManager.resumeBGSound()
        }
    }
}
```

---

### 5. Observer Pattern (implícito) - HUD

**Problema**: Actualizar UI cuando cambia el estado del juego.

**Solución**: HUD reacciona a eventos de daño/curación.

```typescript
object solidSnake {
    override method takeDamage(amount) {
        super(damage)
        hud.lostHeart() // Notificación implícita
    }
}

object hud {
    const hearts = []
    
    method lostHeart() {
        const lastHeart = hearts.last()
        game.removeVisual(lastHeart)
        hearts.remove(lastHeart)
    }
}
```

---

## 🔧 Delegación de Responsabilidades

### gameManager
- Coordinación general del juego
- Manejo de estados globales (Playing, Paused, GameOver, Victory)
- Reinicio del juego

### levelsManager
- Carga de pantalla inicial
- Carga de nivel 1
- Limpieza de visuales

### objectPool
- Pre-instanciación de objetos
- Activación/desactivación por área
- Consulta de objetos activos

### colissionHandler
- Registro de objetos colisionables
- Procesamiento de pickups y drops
- Gestión de colisiones activas

### areaManager
- Cambios entre áreas
- Actualización de comportamiento de guardias
- Coordinación de carga/descarga

### gameCurrentStatus
- Estado actual del juego (área, nivel, matriz)
- Verificación de colisiones por matriz
- Single Source of Truth

### soundManager
- Reproducción de música de fondo
- Pausado/reanudación de audio
- Gestión de loop

### bulletManager
- Pool de balas reutilizables
- Disparo de ráfaga de 3 balas
- Gestión del ciclo de vida de proyectiles

### movement
- Validación de movimientos
- Lógica de desplazamiento en 4 direcciones
- Verificación de límites del tablero

---

## 📊 Diagrama de Secuencia - Cambio de Área

```
solidSnake → movement.moveUp()
    → solidSnake.moveTo(newPos)
        → solidSnake.onPositionChanged()
            → areaManager.update(solidSnake)
                → gameCurrentStatus.actualArea().checkAreaChange(solidSnake)
                    → AreaChange.canCharacterChangeArea(solidSnake) ✓
                        → areaManager.changeArea(solidSnake, change)
                            1. currentArea.unload()
                                → objectPool.deactivateArea("area01")
                                → game.removeVisual(allVisuals)
                            2. gameCurrentStatus.modifyArea(area02)
                            3. area02.load()
                                → game.addVisual(background)
                                → objectPool.activateArea("area02")
                                → game.addVisual(solidSnake)
                                → hud.drawHearts()
                            4. solidSnake.position(nextAreaPosition)
```

---

## 📊 Diagrama de Secuencia - Disparo de Arma

```
Usuario → keyboard.d()
    → solidSnake.useItem()
        → equipment.useItem(solidSnake)
            → Weapon.beUse(solidSnake)
                → bulletManager.fire(solidSnake, [bullet1, bullet2, bullet3])
                    → bullet1.fire(solidSnake) [inmediato]
                        → bullet1.position = solidSnake.position()
                        → bullet1.active = true
                        → colissionHandler.register(bullet1)
                        → game.addVisual(bullet1)
                        → game.schedule(300ms) → bullet1.move()
                        → game.schedule(600ms) → bullet1.move()
                        → game.schedule(900ms) → bullet1.move()
                        → game.schedule(1200ms) → bullet1.stop()
                    → game.schedule(300ms) → bullet2.fire(solidSnake)
                    → game.schedule(300ms) → bullet3.fire(solidSnake)
```

---

## 🗂️ Estructura del Proyecto

```
metal-gear-nes-wollok/
├── src/
│   ├── characters/
│   │   ├── character.wlk          # Clase base Character
│   │   ├── snake/
│   │   │   ├── snake.wlk          # solidSnake (WKO)
│   │   │   └── equipment.wlk      # snakeEquipment
│   │   └── guards/
│   │       ├── guards.wlk         # Clase Guard abstracta
│   │       ├── staticsGuard.wlk   # StaticGuard
│   │       └── patrollGuard.wlk   # PatrollGuard
│   ├── gameObject/
│   │   └── GameObject.wlk         # Clase base para todos los objetos
│   ├── items/
│   │   ├── pickables.wlk          # Pickable, Box, Keys, Weapon, Health
│   │   ├── bullet.wlk             # Bullet, bulletManager
│   │   └── hostage.wlk            # Hostage (objetivo)
│   ├── levels/
│   │   ├── level01.wlk            # Area, 5 áreas del nivel 1
│   │   ├── tilemap.wlk            # Matrices de tiles
│   │   ├── factory.wlk            # areaFactory
│   │   └── areaManager.wlk        # areaManager, AreaChange
│   ├── system/
│   │   ├── objectPool.wlk         # objectPool, guardsBehavior
│   │   ├── colissions.wlk         # colissionHandler
│   │   ├── gameStatus.wlk         # gameCurrentStatus
│   │   ├── levelsManager.wlk      # levelsManager
│   │   ├── soundManager.wlk       # soundManager
│   │   └── initialConfig.wlk      # config
│   ├── inputManager/
│   │   ├── inputManager.wlk       # keyboardManager
│   │   └── movements/
│   │       └── movement.wlk       # movement
│   ├── ui/
│   │   ├── hud.wlk               # Sistema de corazones
│   │   └── visual.wlk            # Pantallas, mensajes
│   ├── utils/
│   │   ├── utils.wlk             # Funciones auxiliares
│   │   └── log.wlk               # Sistema de logging
│   ├── gameManager.wlk           # gameManager
│   └── game.wpgm                 # Punto de entrada
├── assets/
│   ├── images/                   # Sprites y fondos
│   │   ├── 1280x768/            # Fondos por área
│   │   └── ...
│   └── sounds/                   # Audio
│       └── 427513__carloscarty__chiptune-one.wav
├── docs/
│   ├── project.md               # Este archivo
│   ├── bitacora.md              # Bitácora de desarrollo
│   └── uml/
│       └── actual.png           # Diagrama UML
├── README.md
└── .gitignore
```

---

## 🧪 Testing

### Tests Implementados

- ✅ Movimiento de Snake (válido e inválido)
- ✅ Cambio de áreas
- ✅ Sistema de colisiones
- ✅ Actualización de estado (gameCurrentStatus)
- ✅ Imagen de Snake según movimiento

### Áreas de Testing Manual

- ⚠️ Comportamiento de guardias (patrullaje, rotación)
- ⚠️ Sistema de balas (trayectoria, colisión)
- ⚠️ Flujo completo del juego (inicio → game over → reinicio)
- ⚠️ Victoria (rescate de rehén con llave roja)

---

## 📚 Conceptos de POO Demostrados

### Herencia
- `Character` → `Snake`, `Guard`
- `Guard` → `StaticGuard`, `PatrollGuard`
- `GameObject` → `Character`, `Pickable`, `Bullet`, `Hostage`
- `Pickable` → `Box`, `Key`, `Weapon`, `Health`

### Polimorfismo
- `move()` en guardias (estático vs patrulla)
- `beUse()` en items (caja vs arma)
- `collidedBy()` según tipo de objeto
- `image()` según estado y dirección

### Encapsulamiento
- Estado interno privado de cada clase
- Acceso controlado mediante getters/setters
- `isActive`, `isCollidable`, `isPickable` ocultan implementación

### Composición
- Snake TIENE equipment
- Equipment TIENE lista de items
- Weapon TIENE lista de bullets
- Area TIENE lista de changeEvents

### Delegación
- Snake delega cambio de área a areaManager
- Snake delega uso de items a equipment
- Movement delega validación a gameCurrentStatus
- gameManager delega reinicio a levelsManager

### Abstracción
- `GameObject` define interfaz común
- `Character` abstrae comportamiento de entidades con vida
- `Guard` abstrae comportamiento de enemigos
- `Pickable` abstrae comportamiento de items

---

## 🚀 Optimizaciones Implementadas

### Performance
1. **Object Pool**: Pre-instanciación de objetos (mejora de 100-200x)
2. **Matriz de colisiones**: Verificación O(1) vs iteración O(n)
3. **Tick rate optimizado**: 500ms para guardias (balance fluidez/performance)

### Memoria
1. **Reutilización de balas**: Pool de 3 balas por arma
2. **Desactivación vs destrucción**: Objetos permanecen en memoria
3. **Registro selectivo**: Solo objetos activos en colissionHandler

### Código
1. **Centralización de estado**: gameCurrentStatus como SSOT
2. **Separación de concerns**: UI, lógica, input en módulos separados
3. **Logging condicional**: Sistema de debug opcional

---

## 🔮 Extensibilidad Futura

### Fácil de Agregar
- ✅ Nuevos tipos de guardias (heredar de Guard)
- ✅ Nuevos items (heredar de Pickable)
- ✅ Nuevas áreas (instanciar Area con tilemap)
- ✅ Nuevos niveles (reutilizar arquitectura)

### Requiere Refactor Menor
- 🔶 Múltiples armas con stats diferentes
- 🔶 Sistema de score
- 🔶 Diferentes dificultades

### Requiere Cambios Estructurales
- 🔴 Multijugador (Snake es singleton)
- 🔴 Sistema de guardado/carga
- 🔴 Editor de niveles in-game

---

## 📖 Referencias y Recursos

- **Wollok**: https://www.wollok.org/
- **Wollok Game**: https://www.wollok.org/documentacion/conceptos/
- **Metal Gear NES Original**: https://en.wikipedia.org/wiki/Metal_Gear_(video_game)

---

**Última actualización**: Noviembre 19, 2025  
**Versión del proyecto**: 1.0  
**Estado**: ✅ Completado