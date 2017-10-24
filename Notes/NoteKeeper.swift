import Foundation

class NoteKeeper {
    
    init() { }
            
    var notes : [Note] = []
    
    func addNote(note: Note) -> Bool {
        notes.append(note)
        return true
    }
    
    func deleteNote(note: Note) -> Bool {
        let countNotesBeforeDelete = notes.count
        notes = notes.filter({ $0 !== note })
        let countNotesAfterDelete = notes.count
        
        if countNotesAfterDelete != countNotesBeforeDelete {
            return true
        }
        
        return false
    }
    
}
