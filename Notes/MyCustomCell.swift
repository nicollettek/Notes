import UIKit

protocol MyCustomCellDelegate: class {
    func changeUISwitchStatus(_ myCustomCell: MyCustomCell, cellId: Int, isOn: Bool)
}

class MyCustomCell: UITableViewCell {

    // Variables
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var switchButtonIsDonе: UISwitch!
    var cellId: Int = -1
    weak var delegate: MyCustomCellDelegate?
    
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
