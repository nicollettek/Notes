import UIKit

protocol NoteTableViewCellDelegate: class {
    func changeUISwitchStatus(_ noteTableViewCell: NoteTableViewCell, cellId: Int, isOn: Bool)
}

class NoteTableViewCell: UITableViewCell {

    // Variables
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var switchButtonIsDonе: UISwitch!
    var cellId: Int = -1
    weak var delegate: NoteTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func changeNoteStatus(_ sender: UISwitch) {

        delegate?.changeUISwitchStatus(self, cellId: cellId, isOn: sender.isOn)
        
    }
}
