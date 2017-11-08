import Foundation

struct Note {
    
    var title: String
    var content: String
    var isDone: Bool
    var noteId: UUID
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.isDone = false
        self.noteId = UUID.init()
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteId == rhs.noteId
    }
    
    static func != (lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
    
}
