//
//  ViewController.swift
//  messengerApp
//
//  Created by Burak Altunoluk on 01/08/2022.
//

import UIKit

final class MainVC: UIViewController {
    
    //MARK: Properties
    private var user1 = ChatCloud(name: "john")
    private var user2 = ChatCloud(name: "sean")
    @IBOutlet private var textStackView: UIStackView!
    @IBOutlet private var seanButtonOutlet: UIButton!
    @IBOutlet private var johnButtonOutlet: UIButton!
    @IBOutlet private var messageTableView: UITableView!
    @IBOutlet private var seanTextField: UITextField!
    @IBOutlet private var johnTextField: UITextField!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        seanButtonOutlet.setTitle("", for: .normal)
        johnButtonOutlet.setTitle("", for: .normal)
        setupKeyboardHiding()
        messageTableView.rowHeight = 131
    }
    
    @IBAction private func johnSendButton(_ sender: UIButton) {
        view.endEditing(true)
        if johnTextField.text != "" {
            user1.chat.append(johnTextField.text!)
            user2.chat.append("")
            johnTextField.text = ""
            messageTableView.reloadData()
            scrollToBottom()
        }
    }
    
    @IBAction private func seanSendButton(_ sender: UIButton) {
        view.endEditing(true)
        if seanTextField.text != "" {
            user2.chat.append(seanTextField.text!)
            user1.chat.append("")
            seanTextField.text = ""
            messageTableView.reloadData()
            scrollToBottom()
        }
    }
}

//MARK: TableView Extentions
extension MainVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user2.chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! TableViewCell
        cell.rightChatBox.text = user1.chat[indexPath.row]
        cell.leftChatBox.text = user2.chat[indexPath.row]

        return cell
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.user1.chat.count-1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

//MARK: KeyboardControl
extension MainVC {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y = 0
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
