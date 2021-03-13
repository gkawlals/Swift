//
//  DetailViewController.swift
//  HamMemo
//
//  Created by 함지민 on 2021/02/06.
//

import UIKit

class DetailViewController: UIViewController {
    
    var memo : Memo?
    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long // 데이터 타입 설정해 날짜를 알려줌
        f.timeStyle = .short // 데이터 타입을 설정해 시간을 알려줌
        f.locale = Locale(identifier: "Ko_kr") // 날짜와 시간을 한국어로 바꾸어줌 "Ko_kr"가 유니코드? 와 비슷한거 같음
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell",for : indexPath)
            
            cell.textLabel?.text = memo?.content
            
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell",for : indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            
            return cell
            
        default : fatalError()
        }
    }
    
    
}
