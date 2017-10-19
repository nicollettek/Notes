import Foundation

class Note {
    
    var title: String
    var content: String
    var isDone: Bool
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.isDone = false
    }
}
