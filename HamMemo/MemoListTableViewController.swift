//
//  MemoListTableViewController.swift
//  HamMemo
//
//  Created by 함지민 on 2021/02/05.
//

import UIKit

class MemoListTableViewController: UITableViewController { // 자바의 implements 와 비슷한거 같다.( 내 생각 )
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long // 데이터 타입 설정해 날짜를 알려줌
        f.timeStyle = .short // 데이터 타입을 설정해 시간을 알려줌
        f.locale = Locale(identifier: "Ko_kr") // 날짜와 시간을 한국어로 바꾸어줌 "Ko_kr"가 유니코드? 와 비슷한거 같음 
        return f
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tableView.reloadData()
//        print(#function)
    }
    
    // 아래 코드는 메모리에서 옵저버를 지우는 코드이다. 
    var token : NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){

            if let vc = segue.destination as? DetailViewController{
                
                vc.memo = Memo.dummyMeomList[indexPath.row]
                
            }
            
        }
    }
    
    override func viewDidLoad() { // 컨트롤러가 생성된 후 자동으로 실행된다. 주로 한번만 실행되는 코드를 여기서 작성
        super.viewDidLoad()
        // 아래의 addObserver를 사용하게 되면 항상 옵저버를 메모리에서 지워주어야한다.
        NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main ) { [ weak self] (noti) in
            
            self?.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.dummyMeomList.count // 여기서는 테이블(List)의 갯수를 count하여 나타내어 줌
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. dequeueReusableCell이 "cell"을 호출
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell... 이 메소드가 중요
        
        // 2. target = 표시할 데이터를 가르침 row를 통해 배열에서 가져옴
        let target = Memo.dummyMeomList[indexPath.row]
        // 우리가 지정한 cell의 Subtitle은 밑의 2가지 속성으로 접근이 가능하다.
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)

        return cell
    } // 여기는 디자인을 불러오는 메소드이다.
    // indexPath = 목록내의 특정 셀 위치를 나타내줌
    // 위의 2가지의 메소드는 필수이다. 테이블을 구현할때엔 무조건 구현해야함
    // 델리게이트는 이벤트가 없다면 구현하지 않아도 된다. 필수는 아니라는 소리이다.
    // 즉, 데이터소스 = 위의 메소드 2가지, 델리게이트 소스 = 주관적으로 움직이면 됨
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
