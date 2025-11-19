# 🗒️ Bitácora de Desarrollo - Metal Gear NES (Wollok)

> **Trabajo Práctico - Paradigmas de Programación**  
> Esta bitácora documenta las decisiones de diseño, refactorizaciones y aplicación de conceptos de Programación Orientada a Objetos durante el desarrollo del proyecto.

---

## 📊 Resumen Ejecutivo

**Período de desarrollo**: Sep 24 - Nov 19, 2025  
**Commits totales**: ~150+  
**Patrones implementados**: Object Pool, Factory, Singleton, Observer (implícito)  
**Mejora de performance clave**: De ~10 segundos a 50-100ms en cambios de área

---

## 🔥 Hitos Principales del Proyecto

### [2025-11-18] Sistema de Balas Completo

#### Contexto
Se necesitaba un sistema de proyectiles eficiente que no creara objetos constantemente ni degradara el rendimiento.

#### Solución Implementada
- Creación de clase `Bullet` con ciclo de vida completo (fire → move → stop)
- `bulletManager` como pool de 3 balas reutilizables por arma
- Sistema de ráfaga: disparo de 3 balas secuenciales con delays
- Auto-desactivación después de 1200ms de vuelo
- Registro/desregistro dinámico en `colissionHandler`

#### Conceptos OOP Aplicados
- **Object Pool Pattern**: Reutilización de balas en lugar de crear/destruir
- **Encapsulamiento**: Cada bala maneja su propio estado (activa/inactiva, posición, dirección)
- **Responsabilidad Única**: `Bullet` solo maneja proyectiles, `bulletManager` solo gestiona el pool
- **Composición**: `Weapon` tiene una lista de `Bullet` que utiliza

#### Código Relevante
```typescript
class Bullet inherits GameObject {
    var gunOwner = null
    var active = false
    
    method fire(character) {
        if (!active) {
            position = character.position()
            lastMovement = character.lastMovement()
            active = true
            // Movimiento programado en 4 pasos
        }
    }
    
    method stop() {
        active = false
        colissionHandler.unregister(self)
    }
}
```

#### Impacto
✅ Sistema de combate funcional sin memory leaks  
✅ Performance estable con múltiples disparos  
✅ Código extensible para agregar más tipos de proyectiles

---

### [2025-11-17] Refactor Mayor: Snake como Singleton

#### Contexto
Snake se instanciaba como clase, pero al ser un juego "one player" con un único personaje controlable, generaba complejidad innecesaria en la gestión de referencias.

#### Solución Implementada
- Conversión de `class Snake` → `object solidSnake`
- Eliminación de instanciación manual en cada área
- Simplificación de referencias en todo el sistema
- Método `initialize()` para resetear estado al reiniciar

#### Conceptos OOP Aplicados
- **Singleton Pattern**: Un único objeto Snake en todo el sistema
- **Identidad de Objeto**: `solidSnake` es siempre el mismo objeto
- **Encapsulamiento**: Estado interno manejado por el objeto singleton
- **Bajo Acoplamiento**: Otros objetos solo necesitan referenciar `solidSnake`

#### Impacto
✅ Código más simple y mantenible  
✅ Eliminación de bugs de referencia perdida  
✅ Facilita debugging al tener un único objeto rastreable  
⚠️ Trade-off: Menos flexible si se quisiera multijugador (no es el objetivo)

---

### [2025-11-17] Sistema de Pausado del Juego

#### Contexto
Se necesitaba pausar el juego sin detener el motor completo de Wollok Game, incluyendo el comportamiento de los guardias.

#### Solución Implementada
- `gameManager.togglePause()` alterna entre pausado/activo
- Los guardias verifican estado antes de moverse
- `guardsBehavior` (tick de 500ms) puede iniciarse/detenerse
- Música de fondo se pausa/reanuda

#### Conceptos OOP Aplicados
- **Delegación**: Los guardias delegan la verificación de pausa a `gameCurrentStatus`
- **Estado del Sistema**: Centralizado en `gameManager`
- **Responsabilidad Única**: Cada componente verifica el estado pero no lo modifica

#### Impacto
✅ Pausado funcional sin bugs de sincronización  
✅ Guardias no se "teletransportan" al despausar  
✅ Música sincronizada con estado del juego

---

### [2025-11-04] Sistema de Vida y HUD Visual

#### Contexto
El sistema de vida era abstracto (número 0-100) sin representación visual clara para el jugador.

#### Solución Implementada
- HUD con 5 corazones representando vida
- `hud.lostHeart()` y `hud.recoverHearts()` para actualizar visual
- Integración con sistema de daño en `Character`
- Health Kit recupera vida completa y actualiza HUD

#### Conceptos OOP Aplicados
- **Separación de Concerns**: La lógica de vida está en `Character`, la visual en `hud`
- **Observer (implícito)**: HUD reacciona a cambios de vida
- **Encapsulamiento**: HUD maneja su propia representación visual

#### Impacto
✅ Feedback visual inmediato al jugador  
✅ Sistema de vida comprensible e intuitivo  
✅ Facilita balance de juego

---

### [2025-10-31 → 2025-11-01] Sistema de Game Over y Reinicio

#### Contexto
Cuando Snake moría, el juego quedaba en estado inconsistente sin forma de reiniciar excepto cerrando la aplicación.

#### Solución Implementada
- `gameManager` como controlador de estados globales
- Pantalla de Game Over con opción de reinicio (Space)
- Reset completo del estado: Snake, áreas, objetos
- Recarga de área 01 y reposicionamiento de Snake

#### Conceptos OOP Aplicados
- **State Pattern (implícito)**: Estados Playing, GameOver, Winner
- **Responsabilidad Única**: `gameManager` solo gestiona estados globales
- **Coordinación**: `gameManager` coordina reset de múltiples subsistemas

#### Código Relevante
```typescript
object gameManager {
    method gameOver() {
        // Mostrar pantalla
        // Limpiar estado
        // Habilitar reinicio
    }
    
    method restartGame() {
        // Reset Snake
        // Reload área 01
        // Restart música
    }
}
```

#### Impacto
✅ Loop de juego completo: jugar → morir → reintentar  
✅ Estado limpio en cada reinicio sin bugs residuales  
✅ Mejor experiencia de usuario

---

### [2025-10-29 → 2025-10-30] 🚀 Object Pool Pattern - CAMBIO CRÍTICO DE PERFORMANCE

#### Contexto
**PROBLEMA GRAVE**: Cada cambio de área tomaba ~10 segundos porque se destruían y recreaban TODOS los objetos (guardias, items, paredes) desde cero. Esto generaba:
- Lag masivo al cambiar de área
- Experiencia de juego horrible
- Posibles memory leaks

#### Solución Implementada
- Creación de `objectPool` para gestionar objetos pre-instanciados
- Todos los objetos del nivel se crean UNA SOLA VEZ al inicio
- Cambio de área = activar/desactivar objetos, NO crear/destruir
- Dictionary organizando objetos por área: `{"area01": [objetos...], "area02": [...]}`

#### Conceptos OOP Aplicados
- **Object Pool Pattern**: Reutilización de objetos costosos
- **Lazy Loading vs Eager Loading**: Cambio a eager (cargar todo al inicio)
- **Estado del Objeto**: `isActive` para activar/desactivar sin destruir
- **Gestión de Memoria**: Reducción drástica de garbage collection

#### Código Relevante
```typescript
object objectPool {
    const objectsByArea = new Dictionary()
    
    method initializeLevel01() {
        // Crear TODOS los objetos una vez
        allTileMapsLevel01.forEach { tileMatrix =>
            const objs = areaFactory.createObjectsFromMatrix(tileMatrix)
            objectsByArea.put(areaName, objs)
        }
    }
    
    method activateArea(areaName) {
        objectsByArea.get(areaName).forEach { obj => obj.activate() }
    }
}
```

#### Impacto
🚀 **Performance**: De ~10 segundos → 50-100ms (mejora de 100-200x)  
✅ Experiencia de juego fluida  
✅ Base sólida para múltiples niveles  
⚠️ Trade-off: Mayor uso de memoria inicial (aceptable para este proyecto)

---

### [2025-10-24 → 2025-10-29] Factory Pattern con TileMap

#### Contexto
Crear objetos manualmente para cada área era tedioso, propenso a errores y difícil de mantener.

#### Solución Implementada
- Diseño de niveles mediante matrices de caracteres (TileMap)
- `areaFactory` con Dictionary mapeando caracteres → constructores
- Conversión automática matriz → objetos del juego
- Coordenadas Y invertidas correctamente (matriz vs tablero)

#### Conceptos OOP Aplicados
- **Factory Pattern**: Centralización de creación de objetos
- **Configuración Declarativa**: Nivel definido como datos, no código
- **Extensibilidad**: Agregar nuevo tipo = agregar entrada al Dictionary
- **Separación de Concerns**: Diseño de nivel vs implementación de objetos

#### Código Relevante
```typescript
object areaFactory {
    const match_tile = new Dictionary()
    
    method initializeMatchTile() {
        match_tile.put("G", { pos => new StaticGuard(position = pos) })
        match_tile.put("P", { pos => new PatrollGuard(position = pos) })
        match_tile.put("R", { pos => new RedKey(position = pos) })
        // ...
    }
}
```

#### Impacto
✅ Diseño de niveles más rápido e intuitivo  
✅ Fácil visualización del layout en código  
✅ Reducción drástica de errores de posicionamiento

---

### [2025-10-22 → 2025-10-23] Refactor: Gestión Centralizada de Estado

#### Contexto
El estado del juego (área actual, nivel, matriz de colisiones) estaba disperso en múltiples objetos, generando inconsistencias.

#### Solución Implementada
- Creación de `gameCurrentStatus` como "Single Source of Truth"
- Centralización de: área actual, TileMap actual, nivel actual
- Métodos `isBlocked(pos)` para verificar colisiones por matriz
- Sincronización automática entre área y su matriz correspondiente

#### Conceptos OOP Aplicados
- **Single Source of Truth**: Un solo objeto autoritativo para el estado
- **Encapsulamiento**: Estado accesible solo por getters
- **Consistencia**: Imposible tener área y matriz desincronizadas
- **Bajo Acoplamiento**: Otros objetos solo consultan, no modifican

#### Impacto
✅ Eliminación de bugs de sincronización  
✅ Código más predecible y testeable  
✅ Base sólida para sistema de guardado futuro

---

### [2025-10-16] Refactor: Movimiento de Guardias Patrullando

#### Contexto
El movimiento de los guardias resultaba errático y poco natural, sin respetar colisiones ni coherencia espacial con el entorno del juego.

#### Solución Implementada
- Refactorización completa del movimiento aleatorio en `PatrollGuard`
- Mayor peso de movimientos horizontales para patrullaje más natural
- Validación de colisiones antes de confirmar movimiento
- Optimización de frecuencia a cada 500ms para suavizar desplazamientos

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Cada guardia gestiona internamente su lógica de patrulla
- **Polimorfismo**: `move()` implementado diferente en `PatrollGuard` vs `StaticGuard`
- **Responsabilidad Única**: Lógica de patrullaje contenida en el guardia
- **Bajo Acoplamiento**: Sistema de patrullaje independiente del motor principal

#### Impacto
✅ Patrullajes predecibles y coherentes  
✅ Guardias respetan el entorno visual  
📌 Pendiente: Evaluar frecuencias dinámicas según dificultad

---

### [2025-10-15] Refactor: Sistema de Colisiones Centralizado

#### Contexto
El sistema de colisiones presentaba dependencias circulares y responsabilidades confusas entre objetos, dificultando el mantenimiento.

#### Solución Implementada
- Creación del objeto `colissionHandler` como gestor central
- Registro/desregistro de objetos colisionables
- Métodos específicos: `processPickItem()`, `processDropItem()`
- Integración con objetos invisibles (paredes, triggers)

#### Conceptos OOP Aplicados
- **Responsabilidad Única**: `colissionHandler` solo detecta y resuelve colisiones
- **Bajo Acoplamiento**: Entidades no conocen detalles de detección
- **Extensibilidad**: Nuevos tipos de colisiones sin modificar entidades
- **Registry Pattern**: Registro centralizado de objetos colisionables

#### Impacto
✅ Código más desacoplado y mantenible  
✅ Sistema extensible para nuevas interacciones  
✅ Eliminación de dependencias circulares

---

### [2025-10-11 → 2025-10-13] Sistema de Cambio de Áreas

#### Contexto
Se necesitaba implementar transiciones entre zonas del mapa sin que Snake tuviera conocimiento de los detalles del proceso.

#### Solución Implementada
- Creación de clase `AreaChange` para manejar eventos de transición
- Cada área tiene lista de eventos de cambio asociados
- `areaManager` coordina carga/descarga de áreas
- Snake solo cambia posición, no conoce la mecánica de transición

#### Conceptos OOP Aplicados
- **Delegación**: Snake delega transición a objetos especializados
- **Encapsulamiento**: Personaje no conoce detalles de transiciones
- **Bajo Acoplamiento**: Snake interactúa solo con interfaz de `AreaChange`
- **Polimorfismo**: Diferentes tipos de transiciones sin modificar Snake
- **Tell, Don't Ask**: Snake "dice" que se movió, el sistema "decide" si cambia área

#### Código Relevante
```typescript
class AreaChange {
    method canCharacterChangeArea(character) {
        return character.position().equals(position) &&
               character.lastMovement().equals(nextDirection)
    }
}

object areaManager {
    method changeArea(character, change) {
        // 1. Descargar área actual
        // 2. Actualizar área en gameStatus
        // 3. Cargar nueva área
        // 4. Posicionar personaje
    }
}
```

#### Impacto
✅ Diseño modular y escalable  
✅ Fácil agregar nuevas áreas o condiciones  
✅ Snake mantiene responsabilidades mínimas

---

### [2025-10-04 → 2025-10-05] Gestión de Input y Movimiento

#### Contexto
Era necesario desacoplar el control de entrada (teclado) del movimiento lógico de los personajes para facilitar testing y AI futura.

#### Solución Implementada
- Creación de `keyboardManager` para manejar input del jugador
- Implementación de `movement` como objeto central de gestiónde desplazamientos
- Validación centralizada de movimientos válidos

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Separación entre captura de input y lógica de movimiento
- **Inversión de Dependencias**: Objetos dependen de abstracción de movimiento
- **Extensibilidad**: Permite agregar IA o control de NPCs fácilmente
- **Single Responsibility**: Input separado de lógica de juego

#### Impacto
✅ Sistema escalable y flexible  
✅ Facilita testing de movimientos sin input real  
✅ Base para agregar diferentes tipos de control

---

### [2025-09-24 → 2025-09-30] Funcionalidad Base Jugable

#### Contexto
Establecer la base jugable del proyecto con las mecánicas fundamentales implementadas.

#### Solución Implementada
- Configuración inicial del objeto `game` y documentación en README
- Creación de Snake con movimiento básico en 4 direcciones
- Definición de las primeras 4 áreas del juego
- Implementación de música en loop
- Desarrollo inicial de `Guards` y su incorporación al área principal

#### Conceptos OOP Aplicados
- **Composición**: Sistema construido mediante objetos independientes que colaboran
- **Modularidad**: Cada componente (personaje, área, enemigos) es independiente
- **Abstracción**: Definición de interfaces básicas de elementos del juego
- **Herencia**: `Character` como base para `Snake` y `Guard`

#### Impacto
✅ Versión jugable básica del nivel 1  
✅ Movimiento, áreas y transiciones funcionales  
✅ Base sólida para iteraciones posteriores

---

### [2025-09-24] Inicio del Proyecto

#### Contexto
Configuración inicial del entorno y estructura base del proyecto.

#### Solución Implementada
- Commit inicial desde GitHub Classroom
- Creación de README con descripción del proyecto
- Configuración de `game` como objeto principal
- Registro de sprites e imágenes base del entorno

#### Conceptos OOP Aplicados
- **Abstracción**: Definición de estructura de objetos principal
- **Inicialización Modular**: Configuración que facilita evolución del proyecto

#### Impacto
✅ Proyecto listo para iteraciones ágiles  
✅ Estructura base para desarrollo colaborativo

---

## 📈 Evolución de Arquitectura

### Fase 1: Prototipo (Sep 24 - Oct 5)
- Movimiento básico de Snake
- Áreas estáticas sin transiciones
- Sin sistema de colisiones

### Fase 2: Mecánicas Core (Oct 6 - Oct 23)
- Sistema de cambio de áreas
- Guardias con comportamiento básico
- Colisiones implementadas

### Fase 3: Optimización Crítica (Oct 24 - Oct 30)
- **Factory Pattern** para carga de niveles
- **Object Pool Pattern** para performance
- Gestión centralizada de estado

### Fase 4: Features Avanzadas (Oct 31 - Nov 18)
- Sistema de combate con balas
- Game Over y reinicio
- HUD visual
- Sistema de pausado
- Items funcionales (caja, armas, health)

---

## 🎓 Conceptos de POO Aplicados - Resumen

### Patrones de Diseño
- ✅ **Object Pool**: Performance crítica en cambios de área
- ✅ **Factory**: Creación de objetos desde matrices
- ✅ **Singleton**: Snake como objeto único
- ✅ **State (implícito)**: Estados del juego (Playing, Paused, GameOver)
- ✅ **Observer (implícito)**: HUD reacciona a cambios de vida

### Principios SOLID
- ✅ **Single Responsibility**: Cada clase con una responsabilidad clara
- ✅ **Open/Closed**: Extensible sin modificar código existente (Factory)
- ✅ **Liskov Substitution**: Guardias intercambiables polimórficamente
- ✅ **Dependency Inversion**: Dependencia de abstracciones (movement)

### Conceptos Core
- ✅ **Herencia**: `Character` → `Snake`, `Guard`
- ✅ **Polimorfismo**: `move()` diferente por tipo de guardia
- ✅ **Encapsulamiento**: Estado privado, acceso controlado
- ✅ **Composición**: Snake tiene equipment, equipment tiene items
- ✅ **Delegación**: Snake delega cambios de área a areaManager

---

## 🔮 Decisiones Pendientes / Futuras

### Mejoras Técnicas
- [ ] Sistema de guardado/carga de partida
- [ ] Niveles adicionales reutilizando arquitectura
- [ ] Diferentes tipos de guardias (persecución activa)
- [ ] Sistema de score

---

**Última actualización**: Noviembre 19, 2025  
**Estado del proyecto**: ✅ Completado y optimizado