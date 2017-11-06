import UIKit

protocol NoteTableViewCellDelegate: class {
    func noteTableViewCellChangeUISwitchStatus(_ noteTableViewCell: NoteTableViewCell, didChangeSwitchStatus isOn: Bool)
}

class NoteTableViewCell: UITableViewCell {

    // Variables
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var switchButtonIsDonе: UISwitch!
    var cellId: Int? = nil
    weak var delegate: NoteTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func changeNoteStatus(_ sender: UISwitch) {

        delegate?.noteTableViewCellChangeUISwitchStatus(self, didChangeSwitchStatus: sender.isOn)
        
    }
}
