
import Foundation

class MemorySource: NSObject, DataSource {
    let data: Data
    var size: UInt64 = 0

    init?(with data: Data) {
        self.data = data
        self.size = UInt64(data.count)
        super.init()
    }
    func read(_ offset: inout UInt64, size: UInt32) throws -> Data! {
        return nil
    }
}
