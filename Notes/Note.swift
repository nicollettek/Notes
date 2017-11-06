import Foundation

struct Note {
    
    var title: String
    var content: String
    var isDone: Bool
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.isDone = false
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.title == rhs.title && lhs.content == rhs.content && lhs.isDone == rhs.isDone 
    }
    
    static func != (lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
    
}
