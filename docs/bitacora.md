# 🧾 Bitácora de Desarrollo - Metal Gear NES (Wollok)

> **Trabajo Práctico - Paradigmas de Programación**  
> Esta bitácora documenta las decisiones de diseño, refactorizaciones y aplicación de conceptos de Programación Orientada a Objetos durante el desarrollo del proyecto.

---

### [2025-10-16] Refactor: Movimiento de guardias patrullando

#### Contexto
El movimiento de los guardias resultaba errático y poco natural, sin respetar colisiones ni coherencia espacial con el entorno del juego.

#### Solución Implementada
- Refactorización completa del movimiento aleatorio en `PatrollGuard`
- Cada guardia ahora ajusta su dirección evitando objetos sólidos e interactivos antes de moverse
- Optimización de la frecuencia de actualización a cada 500ms para suavizar desplazamientos
- Validación de colisiones antes de confirmar el movimiento

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Cada guardia gestiona internamente su lógica de patrulla sin exponer detalles de implementación
- **Responsabilidad Única**: La lógica de patrullaje está contenida dentro del objeto `PatrollGuard`, separada del control global del juego
- **Bajo Acoplamiento**: El sistema de patrullaje no depende del motor principal, facilitando cambios independientes

#### Impacto
✅ Los patrullajes son más predecibles y coherentes con el entorno visual  
📌 **Pendiente**: Evaluar frecuencias dinámicas según el área o dificultad

---

### [2025-10-16] Revisión: Responsabilidades del movimiento en Snake

#### Contexto
Se identificó la necesidad de consolidar el control de movimiento del personaje principal y simplificar las pruebas unitarias.

#### Solución Implementada
- Corrección de tests de movimientos inválidos
- Ajuste del método `moveTo()` para respetar restricciones del área actual
- Definición completa de `area01` con sus objetos y colisiones visuales (paredes, tanques, obstáculos)

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Snake gestiona únicamente su propio desplazamiento
- **Delegación**: La validación del entorno recae en los objetos del área, no en Snake
- **Cohesión Alta**: Cada clase tiene responsabilidades bien definidas sin duplicación de lógica

#### Impacto
✅ Mayor consistencia en los tests unitarios  
✅ Separación clara de responsabilidades entre personaje y entorno

---

### [2025-10-15] Refactor: Sistema de colisiones

#### Contexto
El sistema de colisiones presentaba dependencias circulares y responsabilidades confusas entre los objetos del juego, dificultando el mantenimiento.

#### Solución Implementada
- Creación del objeto `CollisionHandler` para centralizar la detección de colisiones
- Los `Guards` ahora pueden ser colisionados solo tras la carga completa del área
- Integración de control de colisiones con objetos invisibles (paredes ocultas, sensores, triggers)

#### Conceptos OOP Aplicados
- **Responsabilidad Única**: `CollisionHandler` se encarga exclusivamente de detectar y resolver colisiones
- **Bajo Acoplamiento**: Las entidades del juego no necesitan conocer los detalles de detección de colisiones
- **Extensibilidad**: Permite agregar nuevos tipos de colisiones sin modificar las entidades existentes

#### Impacto
✅ Código más desacoplado y mantenible  
✅ Sistema extensible para nuevos tipos de interacciones  
📌 **Pendiente**: Validar rendimiento con alta cantidad de objetos invisibles

---

### [2025-10-13] Feature: Guardias con colisiones por área

#### Contexto
Las colisiones entre el jugador y los guardias debían ser específicas de cada área del juego para mejorar la modularidad.

#### Solución Implementada
- Implementación de sistema de colisiones entre Snake y Guards específico del nivel 01
- Uso de listas de guardias por área para instanciación automática
- Métodos para agregar y gestionar guardias según el área cargada

#### Conceptos OOP Aplicados
- **Abstracción**: Cada área encapsula su propia lógica de guardias y colisiones
- **Encapsulamiento**: Los guardias se mantienen como parte del estado interno de cada área
- **Modularidad**: Permite gestionar diferentes conjuntos de enemigos por zona

#### Impacto
✅ Control granular de enemigos por zona  
✅ Simplificación de la carga dinámica de niveles

---

### [2025-10-11] Feature: Sistema de cambio de áreas

#### Contexto
Se necesitaba implementar transiciones entre zonas del mapa sin que el personaje tuviera conocimiento de los detalles del proceso.

#### Solución Implementada
- Creación de la clase `ChangeArea` para manejar eventos de transición
- Implementación de cambios entre `area01`, `area02` y `area03`
- Snake delega completamente la responsabilidad del cambio de área a objetos `ChangeArea`

#### Conceptos OOP Aplicados
- **Delegación**: Snake delega la lógica de transición a objetos especializados
- **Encapsulamiento**: El personaje no conoce los detalles de cómo funcionan las transiciones
- **Bajo Acoplamiento**: Snake solo interactúa con la interfaz de `ChangeArea`, no con su implementación
- **Polimorfismo**: Diferentes tipos de transiciones pueden implementarse sin modificar Snake

#### Impacto
✅ Diseño modular y escalable  
✅ Facilita agregar nuevas áreas o condiciones de transición  
📌 **Pendiente**: Agregar diagrama de secuencia del flujo de cambio de áreas

---

### [2025-10-08 → 2025-10-12] Consolidación: Sistema de áreas y tests

#### Contexto
Era necesario estructurar el mapa en áreas independientes y validar su funcionamiento mediante pruebas automatizadas.

#### Solución Implementada
- Inicialización de áreas del nivel 01 con sus eventos de cambio
- Agregado de fondos e imágenes específicas por área
- Creación de suite de tests iniciales para validar estructura
- Fix para permitir cambio de área independientemente del último movimiento de Snake

#### Conceptos OOP Aplicados
- **Modularidad**: Cada área se comporta como un objeto autónomo con su propio ciclo de vida
- **Encapsulamiento**: Cada área gestiona su propia carga y descarga de recursos
- **Testabilidad**: Diseño que permite probar áreas de forma aislada

#### Impacto
✅ Sistema de áreas estable y completamente testeable  
✅ Áreas pueden desarrollarse independientemente  
📌 **Pendiente**: Agregar casos de prueba visuales o capturas para documentación

---

### [2025-10-04 → 2025-10-05] Feature: Gestión de input y movimiento

#### Contexto
Era necesario desacoplar el control de entrada (teclado) del movimiento lógico de los personajes.

#### Solución Implementada
- Creación de `InputManager` para manejar el input del jugador
- Implementación de `Movements` como objeto central de gestión de desplazamientos
- Pruebas de eventos de cambio de área y detección de transiciones

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Separación entre la captura de input y la lógica de movimiento
- **Inversión de Dependencias**: Los objetos de juego dependen de abstracciones de movimiento, no de implementaciones concretas
- **Extensibilidad**: Facilita agregar IA o control de NPCs sin modificar el sistema base

#### Impacto
✅ Sistema escalable y flexible  
✅ Permite agregar diferentes tipos de control (IA, red, scripts) fácilmente

---

### [2025-09-27 → 2025-09-28] Feature: Transiciones entre áreas

#### Contexto
Conectar múltiples zonas del mapa en una estructura coherente y navegable.

#### Solución Implementada
- Verificaciones en `SolidSnake` para detectar cambios de área
- Definición de relaciones bidireccionales entre 4 áreas conectadas
- Corrección de transiciones en mapas con estructura tipo cruz (+)

#### Conceptos OOP Aplicados
- **Encapsulamiento**: Cada área define sus propias relaciones de transición
- **Cohesión Alta**: Las reglas de navegación están contenidas en cada área
- **Autonomía**: Las áreas no dependen del motor global para gestionar sus transiciones

#### Impacto
✅ Transiciones funcionales y coherentes con la topología del mapa  
✅ Facilita agregar nuevas zonas sin afectar las existentes

---

### [2025-09-24 → 2025-09-30] Funcionalidad base jugable

#### Contexto
Establecer la base jugable del proyecto con las mecánicas fundamentales implementadas.

#### Solución Implementada
- Configuración inicial del objeto `Game` y documentación en README
- Creación de `Snake` con movimiento básico en 4 direcciones
- Definición de las primeras 4 áreas del juego
- Implementación de música en loop
- Desarrollo inicial de `Guards` y su incorporación al área principal

#### Conceptos OOP Aplicados
- **Composición**: El sistema se construye mediante objetos independientes que colaboran
- **Modularidad**: Cada componente (personaje, área, enemigos) es un objeto independiente
- **Abstracción**: Se definen las interfaces básicas de los elementos del juego

#### Impacto
✅ Versión jugable básica del nivel 1  
✅ Movimiento, áreas y transiciones funcionales  
✅ Base sólida para iteraciones posteriores

---

### [2025-09-24] Inicio del proyecto

#### Contexto
Configuración inicial del entorno y estructura base del proyecto.

#### Solución Implementada
- Commit inicial desde GitHub Classroom
- Creación de README con descripción del proyecto
- Configuración de `Game` como objeto principal
- Registro de sprites e imágenes base del entorno

#### Conceptos OOP Aplicados
- **Abstracción**: Definición de la estructura de objetos principal desde el inicio
- **Inicialización Modular**: Configuración que facilita la evolución del proyecto

#### Impacto
✅ Proyecto listo para iteraciones ágiles  
✅ Estructura base para desarrollo colaborativo

---

**Última actualización**: Octubre 2025