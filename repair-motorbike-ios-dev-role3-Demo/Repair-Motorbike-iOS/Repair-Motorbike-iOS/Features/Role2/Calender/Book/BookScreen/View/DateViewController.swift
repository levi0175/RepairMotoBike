//
//  DateViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 22/05/2022.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak private var pickDate: UIDatePicker!
    @IBOutlet private weak var btnCancel: UIButton!
    @IBOutlet private weak var btnSelect: UIButton!
    
    var datePicked = Date()
    let date = Date()
    var dateFromSelected = Date()
    var dateToSelected = Date()
    public var didSendData: ((Date) -> Void)?
    var checkBtnDateFrom = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCancel.layer.cornerRadius = 13
        btnSelect.layer.cornerRadius = 13
        pickDate.datePickerMode = .dateAndTime
        pickDate.setValue(UIColor.white, forKeyPath: "textColor")
        pickDate.contentHorizontalAlignment = .center
        if #available(iOS 13.0, *) {
            pickDate.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
}

    @IBAction func btnCancel(_ sender: Any) { datePicked = date
        didSendData?(datePicked)
        dismiss(animated: true)
       
    }
    
    @IBAction func btnSelcct(_ sender: Any) {
        print("sss")
        datePicked = pickDate.date
        if checkBtnDateFrom == 0 {
            if datePicked >= dateToSelected {
                didSendData?(datePicked)
                dismiss(animated: true)
                print("yep")
            } else {
                let alert = UIAlertController(title: "Không thể thực hiện yêu cầu", message: "Vui lòng chọn ngày tỉếp theo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            if checkBtnDateFrom == 1 {
                if datePicked < dateToSelected {
                    didSendData?(datePicked)
                    dismiss(animated: true)
                    print("yep")
                } else {
                    let alert = UIAlertController(title: "Không thể thực hiện", message: "Vui lòng chọn ngày trước đó ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                if checkBtnDateFrom == 2 && datePicked >= dateFromSelected && datePicked <= date {
                    didSendData?(datePicked)
                    dismiss(animated: true)
                    print("yep")
                } else {
                    let alert = UIAlertController(title: "Không thể thực hiện", message: "Vui lòng chọn ngày kết thúc phải lớn hơn ngày bắt đầu và nhỏ hơn ngày hiện tại", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
}
