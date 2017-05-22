import App
import PostgreSQLDriver

let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()

drop.get("version") { request in
    let db = try drop.postgresql()
    let version = try db.raw("SELECT version()")
    return try JSON(node: ["version": version])
}

try drop.run()
