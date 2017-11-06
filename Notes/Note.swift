import Foundation

struct Note {
    
    var title: String
    var content: String
    var isDone: Bool
    private static var noteId: Int = 0
    var currentNoteId: Int
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.isDone = false
        self.currentNoteId = Note.noteId
        Note.noteId += 1
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.currentNoteId == rhs.currentNoteId
    }
    
    static func != (lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
    
}
