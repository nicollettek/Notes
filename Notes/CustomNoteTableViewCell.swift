import UIKit

class CustomNoteTableViewCell: UITableViewCell {
    
    var noteKeeper: NoteKeeper?

    // Variables
    private var _noteId: Int = -1
    
    // Constructor
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // Constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Destructor
    deinit {
        actionButton.removeTarget(self, action: #selector(changeNoteStatus), for: .touchUpInside)
    }
    
    func setNoteKeeper(noteKeeper: NoteKeeper) {
        self.noteKeeper = noteKeeper
    }
    
    // Label getter
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // UI switch getter
    let actionButton: UISwitch = {
        let button = UISwitch()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    // Set and Get note id when note status is changed
    var noteId: Int {
        set { _noteId =  newValue }
        get { return _noteId }
    }
    
    // UISwitch delegate if switch is on or off
    @objc func changeNoteStatus() {
        print("note id: \(noteId)")
        guard let noteKeeper = noteKeeper else {return}
        noteKeeper.notes[noteId].isDone = actionButton.isOn
    }
    
    // Called in constructor to init all neccessary data
    func setupViews() {
        
        addSubview(nameLabel)
        self.accessoryView = actionButton
        
        // add delegate for action button is pressed
        actionButton.addTarget(self, action: #selector(changeNoteStatus), for: .touchUpInside)
        
    }
}
