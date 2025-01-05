typealias ArgumentDictionary = [String: String]

func makeArgumentDictionary(from argumentArray: [String]) -> ArgumentDictionary {
    var arguments: ArgumentDictionary = Dictionary()

    for index in stride(from: 1, to: argumentArray.count, by: 2) {
        if let key = argumentArray[safe: index],
            let value = argumentArray[safe: index + 1] {
            arguments[key] = value
        }
    }

    return arguments
}
