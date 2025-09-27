import src.characters.snake.*
object areaManager {
    var actualArea = northArea

    method changeArea(newArea, initialPosition) {
        actualArea.removeArea(actualArea)
        actualArea = newArea
        actualArea.load()
        solidSnake.position (initialPosition)
    }

    method verifyTransition() {
        const pos = solidSnake.position()
        
        // Verificar límites y cambiar área correspondiente
        if (pos.y() >= game.height() - 1) {
            // Ir al NORTE
            const destino = actualArea.northConnection()()
            if (destino != null) {
                self.changeArea(destino, game.at(pos.x(), 0))
            }
        }
        else if (pos.y() <= 0) {
            // Ir al SUR  
            const destino = actualArea.southConnection()
            if (destino != null) {
                self.changeArea(destino, game.at(pos.x(), game.height() - 1))
            }
        }
        else if (pos.x() >= game.width() - 1) {
            // Ir al ESTE
            const destino = actualArea.eastConnection()
            if (destino != null) {
                self.changeArea(destino, game.at(0, pos.y()))
            }
        }
        else if (pos.x() <= 0) {
            // Ir al OESTE
            const destino = actualArea.westConnection()
            if (destino != null) {
                self.changeArea(destino, game.at(game.width() - 1, pos.y()))
            }
        }
    }
}

/*
 * Definición de áreas y sus conexiones
 * Cada área tiene sus propios objetos y enemigos
 * Además de las conexiones a otras áreas.
 * Para este ejemplo, se definen 4 áreas conectadas en cruz.
 */
object northArea {
    const objects = []

    method name() = "North Area"

    method load() {
        game.boardGround("northArea.png")
        // TODO: Cargar objetos y enemigos
        console.println("Cargada: " + self.name()) // Debug
    }

    method removeArea() {
        objects.forEach({ obj => game.removeVisual(obj) })
        objects.clear()
        // TODO: limpiarEventosEspecificos()
        console.println("Descargada: " + self.name()) // Debug
    }

    method northConnection() = null        // Sin salida norte
    method southConnection() = null         // Sin salida sur
    method eastConnection() = eastArea     // Conecta con Este  
    method westConnection() = westArea   // Conecta con Oeste
}

object eastArea {
    const objects = []

    method name() = "East Area"

    method load() {
        game.boardGround("eastArea.png")
        // TODO: Cargar objetos y enemigos
        console.println("Cargada: " + self.name()) // Debug
    }
    method removeArea() {
        objects.forEach({ obj => game.removeVisual(obj) })
        objects.clear()
        // Limpiar eventos específicos
        console.println("Descargada: " + self.name()) // Debug
    }

    method northConnection() = northArea  // Conecta con Norte
    method southConnection() = southArea  // Conecta con Sur
    method eastConnection() = null      // Sin salida este
    method westConnection() = westArea   // Conecta con Oeste
}

object westArea {
    const objects = []

    method name() = "West Area"

    method load() {
        game.boardGround("westArea.png")
        // TODO: Cargar objetos y enemigos
        console.println("Cargada: " + self.name()) // Debug
    }
    method removeArea() {
        objects.forEach({ obj => game.removeVisual(obj) })
        objects.clear()
        // Limpiar eventos específicos
        console.println("Descargada: " + self.name()) // Debug
    }

    method northConnection() = northArea  // Conecta con Norte
    method southConnection() = southArea  // Conecta con Sur
    method eastConnection() = eastArea     // Conecta con Este
    method westConnection() = null
}

object southArea {
    const objects = []

    method name() = "South Area"

    method load() {
        game.boardGround("southArea.png")
        // TODO: Cargar objetos y enemigos
        console.println("Cargada: " + self.name()) // Debug
    }
    method removeArea() {
        objects.forEach({ obj => game.removeVisual(obj) })
        objects.clear()
        // Limpiar eventos específicos
        console.println("Descargada: " + self.name()) // Debug
    }

    method northConnection() = northArea  // Conecta con Norte
    method southConnection() = null         // Sin salida sur
    method eastConnection() = eastArea     // Conecta con Este
    method westConnection() = westArea   // Conecta con Oeste
}