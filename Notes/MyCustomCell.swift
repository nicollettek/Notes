import UIKit

protocol CustomCellDelegate {
    func changeUISwitchStatus(cellId: Int, isOn: Bool)
}

class MyCustomCell: UITableViewCell {

    // Variables

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var switchButtonIsDonе: UISwitch!
    var cellId: Int = -1
    var delegate: CustomCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func changeNoteStatus(_ sender: UISwitch) {

        delegate?.changeUISwitchStatus(cellId: cellId, isOn: sender.isOn)
        
    }
}
