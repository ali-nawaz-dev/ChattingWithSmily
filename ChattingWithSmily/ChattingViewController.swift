//
//  ChattingViewController.swift
//  testtt
//
//  Created by Sheikh Ali on 12/08/2021.
//

import UIKit

class ChattingViewController: UIViewController {

    @IBOutlet weak internal var tblChatting: UITableView!
    @IBOutlet weak internal var plusButton: UIButton!
    
    var senderId = 1
    var tryTime: Int = 1
    var messages = [ChatMessage]()
    var smilyView : SmilyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?
            .navigationBar
            .setGradientBackground(colors: [#colorLiteral(red: 0.09803921569, green: 0.5333333333, blue: 0.8470588235, alpha: 1),
                                                                           #colorLiteral(red: 0.5098039216, green: 0.7803921569, blue: 0.7490196078, alpha: 1),
                                                                           #colorLiteral(red: 0.4392156863, green: 0.737254902, blue: 0.768627451, alpha: 1),
                                                                           #colorLiteral(red: 0.4392156863, green: 0.737254902, blue: 0.768627451, alpha: 1),
                                                                           #colorLiteral(red: 0.5098039216, green: 0.7803921569, blue: 0.7490196078, alpha: 1),
                                                                           #colorLiteral(red: 0.5176470588, green: 0.7843137255, blue: 0.7490196078, alpha: 1)],
                                                                  startPoint: .topLeft,
                                                                  endPoint: .topRight)
        plusButton.applyGradient(colours: [#colorLiteral(red: 0.8862745098, green: 0.3843137255, blue: 0.6509803922, alpha: 1),
                                           #colorLiteral(red: 0.0862745098, green: 0.5254901961, blue: 0.8509803922, alpha: 1)])
        setupNavigationBarTitleView()
        addBarButtons()
        messages = prepareDateSource()
        tblChatting.reloadData()
    }
    
    private func setupNavigationBarTitleView() {
        if let titleView = Bundle
            .main
            .loadNibNamed("TitleView",
                          owner: self,
                          options: nil)?.first as? TitleView{
            titleView.translatesAutoresizingMaskIntoConstraints = false
            navigationItem.titleView = titleView
            titleView.backgroundColor = .clear
            if let navigationBar = navigationController?.navigationBar {
                NSLayoutConstraint.activate([
                    titleView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 0),
                    titleView.heightAnchor.constraint(equalToConstant:80)
                ])
            }
        }
    }
    
    func addBarButtons(){
        let leftBarButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "backIcon").imageFlippedForRightToLeftLayoutDirection(),
            style: .plain,
            target: self,
            action: #selector(backTapped(sender:))
        )
        let rightBarButton2 = UIBarButtonItem(
            image: #imageLiteral(resourceName: "phone"),
            style: .plain,
            target: self,
            action: #selector(backTapped(sender:))
        )
        
        let rightBarButton1 = UIBarButtonItem(
            image: #imageLiteral(resourceName: "Camera"),
            style: .plain,
            target: self,
            action: #selector(backTapped(sender:))
        )
        
        leftBarButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rightBarButton1.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rightBarButton2.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2]
    }
    
    @objc func backTapped(sender: UIBarButtonItem){
    }
    
    func scrollToBottom(){
        var row = messages.count - 1
        if row < 1 { row = 0}
        tblChatting
            .scrollToRow(at: IndexPath(row: row,
                                                  section: 0),
                                    at: .bottom,
                                    animated: false)
    }
    
    func loadOldData() {
        let moreMessages = prepareDateSource()
        messages.insert(contentsOf: moreMessages,
                        at: 0)
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        var messageCell = tableView.dequeueReusableCell(withIdentifier:getCellId(message: message))
        if messageCell == nil {
            messageCell = getCellWithSenderId(message: message)
        }
        setData(cell: messageCell,
                message: message)
        return messageCell!
    }
}

extension ChattingViewController{
    func configLeftChattingCell() -> UITableViewCell{
        let leftCell = LeftChattingTableViewCell.init(style: .default,
                                                      reuseIdentifier: "LeftChattingTableViewCell")
        return leftCell
    }
    
    func configRightChattingCell() -> UITableViewCell{
        let rightCell = RightChattingTableViewCell.init(style: .default,
                                                        reuseIdentifier: "RightChattingTableViewCell")
        return rightCell
    }
    
    func getCellId(message: ChatMessage) -> String{
        return message.senderId == senderId ? "RightChattingTableViewCell" : "LeftChattingTableViewCell"
    }
    
    func getCellWithSenderId(message: ChatMessage) -> UITableViewCell{
        return message.senderId == senderId ? configRightChattingCell() : configLeftChattingCell()
    }
    
    func setData(cell: UITableViewCell?, message: ChatMessage){
        if let leftCell = cell as? LeftChattingTableViewCell{
            leftCell.setCellData(message)
            leftCell.smilyActionCompletion = { [weak self] in
                self?.showSmilyView(cell: leftCell)
            }
        }
        if let rightCell = cell as? RightChattingTableViewCell{
            rightCell.setCellData(message)
        }
    }
    
    func showSmilyView(cell: LeftChattingTableViewCell){
        if let indexPath = tblChatting.indexPath(for: cell){
            removeSmilyView()
            let rectOfCell = tblChatting.rectForRow(at: indexPath)
            let rectOfCellInSuperview = tblChatting.convert(rectOfCell,
                                                            to: tblChatting.superview)
            if let smilyView = Bundle
                .main
                .loadNibNamed(SmilyView.nibName,
                              owner: self,
                              options: nil)?.first as? SmilyView{
                smilyView.frame = CGRect(x: 40, y: rectOfCellInSuperview.origin.y - 30, width: tblChatting.frame.width - 80, height: 50)
                smilyView.alpha = 0.0
                smilyView.layer.cornerRadius = 25.0
                smilyView.clipsToBounds = true
                self.view.addSubview(smilyView)
                self.view.bringSubviewToFront(smilyView)
                self.smilyView = smilyView
                UIView.animate(withDuration: 0.5, animations: {
                    smilyView.alpha = 1.0
                })
            }
        }
    }
    
    func removeSmilyView(){
        if smilyView != nil {
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.smilyView?.alpha = 0.0
                self?.smilyView?.removeFromSuperview()
                self?.smilyView = nil
            }
        }
    }
}

extension ChattingViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        removeSmilyView()
        if tblChatting.contentOffset.y < 0 {
            loadOldData()
            let oldContentSizeHeight = tblChatting.contentSize.height
            tblChatting.reloadData()
            let newContentSizeHeight = tblChatting.contentSize.height
            tblChatting.contentOffset = CGPoint(x:tblChatting.contentOffset.x,y:newContentSizeHeight - oldContentSizeHeight)
        }
    }
}

private extension ChattingViewController{
    func prepareDateSource() -> [ChatMessage]{
        if let messages = loadJson(filename: "messagesJson"){
            return messages
        }
        return []
    }
    
    func loadJson(filename fileName: String) -> [ChatMessage]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode([ChatMessage].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}


