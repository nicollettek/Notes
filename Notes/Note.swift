import Foundation

struct Note {
    
    var title: String
    var content: String
    var isDone: Bool
    var id: UUID
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.isDone = false
        self.id = UUID()
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func != (lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
    
}
