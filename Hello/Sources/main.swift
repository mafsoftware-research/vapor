import Vapor

let drop = Droplet()

drop.get("/hello") { _ in
    return "Hello Vapor"
}

drop.get("foo", "bar", "baz") { request in
    return "You requested /foo/bar/baz"
}

drop.get("json") { request in
    return try JSON(node: [
        "number": 123,
        "text": "unicorns",
        "bool": false
        ])
}

drop.get("students") { request in
    return try JSON(node: [
        ["firstName": "Miguel", "lastName": "Fermin", "dateOfBirth": "1984-10-26", "age": 32],
        ["firstName": "Erika", "lastName": "Simon", "dateOfBirth": "2004-11-18", "age": 12],
        ["firstName": "Antonio", "lastName": "Simon", "dateOfBirth": "2007-01-20", "age": 10],
        ["firstName": "Hailey", "lastName": "Diaz", "dateOfBirth": "2009-05-28", "age": 8],
        ["firstName": "Noah", "lastName": "Fermin", "dateOfBirth": "2016-02-15", "age": 1]
        ]
    )
}

drop.get("404") { request in
    throw Abort.notFound
}

drop.get("error") { request in
    throw Abort.custom(status: .badRequest, message: "Sorry 😱")
}

drop.get("anything", "*") { request in
    return "Matches anything after /anything"
}

drop.run()
