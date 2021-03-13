//  ComposeViewController.swift
//  HamMemo
//
//  Created by 함지민 on 2021/02/05.
//

import UIKit

class ComposeViewController: UIViewController {

    
    @IBAction func Close(_ sender: Any) {
        
        dismiss(animated: true, completion:nil)
        
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        
        guard  let  memo = memoTextView.text,
                    memo.count > 0 else {
                    alert(message: "메모를 입력하세요")
        return
    }
        let newMemo = Memo(content: memo)
            Memo.dummyMeomList.append(newMemo)
        dismiss(animated: true, completion:nil)
        
        
        //Notification 의 특징
        // 1. 객체에게 바로 전달되지 않음 = 유니 케스트
        // 2. 그런대 브로드 케스트이다. ( 한번 찾아보기 )
        NotificationCenter.default.post(name :ComposeViewController.newMemoDidInsert,object : nil)
        // 위의 코드는 라디오가 주파수를 이용 브로드 케스트 하는 작업을 해주는 문구이다.
        
}
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


extension ComposeViewController {
    
    // 여기서 사용되는 notification은 라디오와 비교해보자
    // 라디오 = 주파수를 이용해 정보를 전달
    // notification = 이름을 이용해 정보를 전달함
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
}
