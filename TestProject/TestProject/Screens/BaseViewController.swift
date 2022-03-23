//
//  BaseViewController.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import UIKit
import HPGradientLoading

var appDelegate: AppDelegate {
  return UIApplication.shared.delegate as! AppDelegate
}

public protocol NetworkStatusChangeDelegate {
  func onNetworkStatusChange()
}

class BaseViewController: UIViewController {
  
  var networkDelegate: NetworkStatusChangeDelegate!
  
  var documentInteractionController: UIDocumentInteractionController = UIDocumentInteractionController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  private func setupUI() {
    HPGradientLoading.shared.configation.isEnableDismissWhenTap = false
    HPGradientLoading.shared.configation.isBlurBackground = true
    HPGradientLoading.shared.configation.isBlurLoadingActivity = true
    HPGradientLoading.shared.configation.durationAnimation = 1.5
    HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)
  }
  
  var isNetworkReachable: Bool {
    return ReachabilityManager.shared.isNetworkReachable
  }
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  
  @IBAction func tappedBackButton(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tappedMenuButton(_ sender: UIButton) {
    //appDelegate.sideMenuViewController!.presentLeftMenuViewController()
  }
  
  func startLoader() {
    HPGradientLoading.shared.configation.fromColor = .white
    HPGradientLoading.shared.configation.toColor = UIColor().hexStringToUIColor(hex: "#1B3C7F")
    HPGradientLoading.shared.showLoading()
  }
  
  func stopLoader() {
    HPGradientLoading.shared.dismiss()
  }
}
