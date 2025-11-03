import src.utils.utils.utils


object log {
    var counter = 0

    method nextId() {
        counter = counter + 1
        return counter
    }

    method info(context, message) {
        self.printLog("INFO", context, message, false)
    }

    method debug(context, message) {
        self.printLog("DEBUG", context, message, false)
    }

    method error(context, message) {
        self.printLog("ERROR", context, message, true)
    }

    method printLog(level, context, message, isError) {
        const className = utils.getClassName(context)
        const logId = self.nextId()
        const formatted = "" + logId + ":: [" + level + "](" + className + ") " + message
        if (isError) {
            console.println("\u001B[31m" + formatted + "\u001B[0m") // primer codigo indica "rojo" el 2do resetea
        } else {
            console.println(formatted)
        }
    }

    method reset() {
        counter = 0
    }
}
