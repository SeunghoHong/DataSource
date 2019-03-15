
import UIKit

final class FileSource: DataSource {
    let path: String
    let size: UInt64

    lazy fileprivate var fileHandle: FileHandle! = {
        return FileHandle(forReadingAtPath: self.path)
    }()

    init?(with path: String) {
        self.path = path
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: self.path) as NSDictionary
            self.size = attributes.fileSize();
        } catch let e {
            print("E: \(e)")
            return nil
        }
    }

    deinit {
        print(#function)
        if let fileHandle = self.fileHandle {
            fileHandle.closeFile()
        }
    }

    func read(_ offset: inout UInt64, size: UInt32) throws -> Data! {
        if let fileHandle = self.fileHandle {
            fileHandle.seek(toFileOffset: offset)
            offset += UInt64(size)
            return fileHandle.readData(ofLength: Int(size))
        } else {
            throw DataSourceError.ioError
        }
    }
}
