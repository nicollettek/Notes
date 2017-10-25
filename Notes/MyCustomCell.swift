import UIKit

class MyCustomCell: UITableViewCell {

    // Variables

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var switchButtonIsDonе: UISwitch!
    
    private var _noteId: Int = -1
    var noteKeeper: NoteKeeper!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Set and Get note id when note status is changed
    var noteId: Int {
        set { _noteId =  newValue }
        get { return _noteId }
    }

    
    @IBAction func changeNoteStatus(_ sender: UISwitch) {
        if  noteId != -1 {
            noteKeeper.notes[noteId].isDone = switchButtonIsDonе.isOn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
