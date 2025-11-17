import src.utils.log.log
import src.system.colissions.colissionHandler
import src.items.pickables.*
object snakeEquipment {
    const allEquipment = []
    var itemInUse = emptyHands

    method allEquipment() = allEquipment
    method itemInUse() = itemInUse 

    /*
    * Recoge un ítem en la posición actual (si hay alguno)
    */
    method pickItem() {
        colissionHandler.processPickItem(self)
    }


    /*
    * Suelta el ítem actual (si tiene alguno)
    */
    method dropItem() {
        colissionHandler.processDropItem(self)
    }

     method pickUpItem(item) {
        allEquipment.add(item)
        itemInUse = item
    }

    method giveUpItem() {
        if (itemInUse != null) {
            itemInUse.drop(self)
        }
        self.removeItemFromEquipment(itemInUse)
    }

    method useItem() {
        if (itemInUse != emptyHands) {
            log.info(self, "Snake usa: " + itemInUse.displayImage())
            itemInUse.beUse(self)
        } else {
            log.info(self, "No tiene ningún objeto para usar.")
        }
    }

    method removeItemFromEquipment(item){
        // las verificaciones las hace el caller
        itemInUse = emptyHands
        if (allEquipment != [] && allEquipment.contains(item)){
            allEquipment.remove(item)
        }
    }
}