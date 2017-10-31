import UIKit

protocol AddNoteViewControllerDelegate: class {
    func addNoteViewControllerUpdateTitleAndContent(_ addNoteViewController: AddNoteViewController)
    func addNoteViewControllerDismiss(_ addNoteViewController: AddNoteViewController)
}

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    var noteId: Int? = nil
    var noteTitle: String?
    var noteContent: String?
    weak var delegate: AddNoteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let backButton = UIButton(type: .custom)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(saveButton.tintColor, for: .normal)
        saveButton.addTarget(self, action: #selector(self.saveNote(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        // add noteTextView a blinking cursor
        noteTextView.becomeFirstResponder()
        
        titleTextField?.text = noteTitle
        noteTextView?.text = noteContent
        
    }
    
    @IBAction func limitLabelLength(_ sender: UITextField) {
        guard let titleText = sender.text else {return}
        let titleLength = titleText.characters.count
        if titleLength > 15 {
            // User cannot type more than 15 characters
            sender.text = String(titleText.prefix(15))
        }
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        guard var title = titleTextField?.text else {return}
        guard let content = noteTextView?.text else {return}
        if title.isEmpty {
            title = "Note"
        }
        
        noteTitle = title
        noteContent = content
        delegate?.addNoteViewControllerUpdateTitleAndContent(self)
        
        delegate?.addNoteViewControllerDismiss(self)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        delegate?.addNoteViewControllerDismiss(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
