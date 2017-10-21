import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var savedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIButton(type: .custom)
        backButton.setTitle("Back", for: .normal)
        //backButton.setImage(UIImage(named: "backButton.png"), for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(saveButton.tintColor, for: .normal)
        saveButton.addTarget(self, action: #selector(self.saveNote(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
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
            savedNote?.content = content
            savedNote?.title = title
        } else {
            let note = Note(title: title, content: content)
            
            NoteKeeper.sharedInstance.addNote(note: note)
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func setUpNote(_ note: Note) {
        savedNote = note
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
