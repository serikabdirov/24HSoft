import Foundation

public extension Encodable {
    func toDictionary(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601) -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = dateEncodingStrategy
            let encodedData = try encoder.encode(self)
            let json_ = try? JSONSerialization.jsonObject(with: encodedData, options: [])
            guard let json = json_ as? [String: Any] else {
                return [:]
            }
            return json
        } catch {
            return [:]
        }
    }
}

public extension Array where Element: Encodable {
    func toDictionary(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy) -> [Any] {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = dateEncodingStrategy
            let encodedData = try encoder.encode(self)
            let json_ = try? JSONSerialization.jsonObject(with: encodedData, options: [])
            guard let json = json_ as? [Any] else {
                return []
            }
            return json
        } catch {
            return []
        }
    }
}
