import src.characters.guards.patrollGuard.*
import src.characters.guards.staticsGuard.*
import src.characters.snake.*
object colissionHandler {
  method initialize() {
    // Por ahora, el comportamiento ante una colisión es el mismo, sin importar el tipo de guardis
    const allGuards = [static01, patroll01]

    allGuards.forEach{
        guard => game.whenCollideDo(guard, { gameObject => gameObject.collidedForStaticGuard() } )}
    }

}