import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var savedNote: Note?
    var noteKeeper: NoteKeeper!
    
    var row: Int?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, row: Int) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.row = row
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        
        guard let note = savedNote else {return}
        titleTextField?.text = note.title
        noteTextView?.text = note.content
        
    }
    
    
    @IBAction func saveNote(_ sender: UIButton) {
        guard let content = noteTextView?.text else {return}
        guard var title = titleTextField?.text else {return}
        if title.isEmpty {
            title = "Note"
        }
        
        if savedNote != nil {
            guard let row = row else {return}
            noteKeeper.notes[row].title = title
            noteKeeper.notes[row].content = content
            
        } else {
            let note = Note(title: title, content: content)
            
            if !noteKeeper.addNote(note: note) {
                print("Note cannot be added with title: \(note.title)")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
