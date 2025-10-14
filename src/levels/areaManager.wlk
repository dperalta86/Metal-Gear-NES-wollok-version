import src.levels.level01.*


object areaManager {
    var actualArea = area01

    method update(character) {
        const event = actualArea.checkAreaChange(character)
        if (event != null) {
            self.changeArea(character, event)
        }
    }

    method changeArea(character, event) {
        actualArea.removeArea()
        actualArea = event.goToArea()
        actualArea.load()
        character.position(event.nextAreaPosition())
        //console.println(character.position()) // para debug
    }
}

/*
 * Manejador de areas y transiciones entre ellas
 */
class ChangeAreaEvent {
    const property currentArea // Area actual 
    const property position // posición de cambio entre areas
    const property nextDirection // "up", "down", "left", "right"
    const property goToArea // Area a la que se quiere ir
    const property nextAreaPosition // posición donde inicia en la nueva area

    // Por mas que solo tengamos a Snake como personaje, utilizo "character" para futuras expansiones o 
    // posibles cambios de areas de los enemigos. (Evito acoplamiento)
    method canCharacterChangeArea(character) {
        return character.position().equals(position) &&
               character.lastMovement().equals(nextDirection)
    }
}

/*
 * Se cargan todos los eventos de cambio entre areas, en las posiciones correspondientes
 * instanciando la clase ChangeAreaEvent.
 * Se encuentra mapa completo con numeración de areas en assets/images/1280x768
 */

 //VER: Estos cambios no deberian de estar definidos dentro del level01.wlk?

 // Ver si es necesario hacer mas descriptivo el nombre del objeto (ej: changeToArea02FromArea01Up)
 // Eventos de cambio de area 01
 const goToArea02 = new ChangeAreaEvent(
    currentArea = area01,
    position = game.at(12, 11),
    nextDirection = "up",
    goToArea = area02,
    nextAreaPosition = game.at(12, 1)
)

const goToArea03A = new ChangeAreaEvent(
    currentArea = area01,
    position = game.at(0, 5),
    nextDirection = "left",
    goToArea = area03,
    nextAreaPosition = game.at(19, 5)
)

const goToArea03B = new ChangeAreaEvent(
    currentArea = area01,
    position = game.at(0, 9),
    nextDirection = "left",
    goToArea = area03,
    nextAreaPosition = game.at(19, 9)
)

// Eventos de cambio de area 02
 const goToArea01 = new ChangeAreaEvent(
    currentArea = area02,
    position = game.at(12, 1),
    nextDirection = "down",
    goToArea = area01,
    nextAreaPosition = game.at(12, 11)
)

// Eventos de cambio de area 03
const goToArea01A = new ChangeAreaEvent(
    currentArea = area03,
    position = game.at(19, 5),
    nextDirection = "right",
    goToArea = area01,
    nextAreaPosition = game.at(1, 5)
)

const goToArea01B = new ChangeAreaEvent(
    currentArea = area03,
    position = game.at(19, 9),
    nextDirection = "right",
    goToArea = area01,
    nextAreaPosition = game.at(1, 9)
)