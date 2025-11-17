import src.utils.log.*
import wollok.game.*

object soundManager {
    method playBGSound() {
        /*
        * Chiptune One.wav by CarlosCarty -- https://freesound.org/s/427513/ -- License: Attribution 4.0
        */
        const mainSound = game.sound("427513__carloscarty__chiptune-one.wav")
        mainSound.shouldLoop(true)
        mainSound.play()
        log.debug(self, "Inicia musica de fondo en loop.")
    }
}
