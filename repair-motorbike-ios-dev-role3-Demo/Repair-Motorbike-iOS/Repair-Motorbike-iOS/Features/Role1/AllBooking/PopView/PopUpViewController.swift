//
//  PopUpViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 04/06/2022.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet private weak var listServiceTableView: UITableView!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var topView: UIView!
    var data: [AllBookingViewEntity.ListServiceAPI] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
    }

    @IBAction func back(_ sender: Any) {
    let transition: CATransition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.reveal
    transition.subtype = CATransitionSubtype.fromBottom
    dismiss(animated: true)
//    self.navigationController?.view.layer.add(transition, forKey: kCATransition)
//    self.navigationController?.popViewController(animated: false)
    }
}
// MARK: - Setup UI
extension PopUpViewController {
    private func setupUI() {
        setTableView()
    }
    private func setTableView() {
      //  containView.layer.cornerRadius = 15
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        listServiceTableView.dataSource = self
        listServiceTableView.delegate = self
        listServiceTableView.registerCellNib(type: ServiceListTableViewCell.self)
        containView.dropShadowWithCornerRaduis(corlor: UIColor.white)
        containView.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
}
extension PopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: ServiceListTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        cell.config(data: data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//       35
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       50
    }
}
