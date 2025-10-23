import src.system.gameStatus.gameCurrentStatus
import src.levels.level01.*


object areaManager {
    method update(character) {
        const change = gameCurrentStatus.actualArea().checkAreaChange(character)
        if (change != null) {
            self.changeArea(character, change)
        }
    }

    method changeArea(character, change) {
        gameCurrentStatus.actualArea().removeArea()
        gameCurrentStatus.modifyArea(change.goToArea())
        gameCurrentStatus.actualArea().load()
        character.position(change.nextAreaPosition())
        //console.println(character.position()) // para debug
    }
    
    method launchGuardsBehavior(){
        game.onTick(500, "guardsBehavior", { self.updateGuardsBehavior() })
    }

    method updateGuardsBehavior() {
        allRegisteredAreas.forEach { area =>
            area.guards().forEach { guard =>
                guard.update()
            }
        }
    }
}

/*
 * Manejador de areas y transiciones entre ellas
 */
class AreaChange {
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
 * instanciando la clase AreaChange.
 * Se encuentra mapa completo con numeración de areas en assets/images/1280x768
 */

 //VER: Estos cambios no deberian de estar definidos dentro del level01.wlk?

 // Ver si es necesario hacer mas descriptivo el nombre del objeto (ej: changeToArea02FromArea01Up)
 // Eventos de cambio de area 01
 const goToArea02 = new AreaChange(
    position = game.at(12, 11),
    nextDirection = "up",
    goToArea = area02,
    nextAreaPosition = game.at(12, 1)
)

const goToArea03A = new AreaChange(
    position = game.at(0, 5),
    nextDirection = "left",
    goToArea = area03,
    nextAreaPosition = game.at(19, 5)
)

const goToArea03B = new AreaChange(
    position = game.at(0, 9),
    nextDirection = "left",
    goToArea = area03,
    nextAreaPosition = game.at(19, 9)
)

// Eventos de cambio de area 02
 const goToArea01 = new AreaChange(
    position = game.at(12, 1),
    nextDirection = "down",
    goToArea = area01,
    nextAreaPosition = game.at(12, 11)
)

// Eventos de cambio de area 03
const goToArea01A = new AreaChange(
    position = game.at(19, 5),
    nextDirection = "right",
    goToArea = area01,
    nextAreaPosition = game.at(1, 5)
)

const goToArea01B = new AreaChange(
    position = game.at(19, 9),
    nextDirection = "right",
    goToArea = area01,
    nextAreaPosition = game.at(1, 9)
)