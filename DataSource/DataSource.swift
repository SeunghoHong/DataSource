
import UIKit

enum Result<T> {
    case value(T)
    case error(NSError)
}

enum DataSourceError: Error {
    case ioError
}

public enum SourceType {
    case file, memory, http
}

public protocol DataSource {

    //var uri: String { get }
    var size: UInt64 { get }
    func read(_ offset: inout UInt64, size: UInt32) throws -> Data!
}

public extension DataSource {

    static func create(with source: Any, type: SourceType) -> DataSource? {
        switch type {
        case .file:
            guard let path = source as? String else { return nil }
            return FileSource(with: path)
        case .http:
            guard let url = source as? URL else { return nil }
            return HTTPSource(with: url)
        case .memory:
            guard let data = source as? Data else { return nil }
            return MemorySource(with: data)
        }
    }
}

