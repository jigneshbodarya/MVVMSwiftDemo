//
//  ViewController.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    fileprivate var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        searchTextField.setLeftPaddingPoints(10)
        searchTextField.delegate = self
        searchTextField.cornerRadius()
        
        for reuseIdentifier in [SongDetailsTableViewCell.reuseIdentifier] {
            tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
    }
    
    func setupViewModel() {
        viewModel.updatedOnGetSongs = {message, error in
            self.updateUI()
            if error == nil {
                self.tableView.reloadData()
            } else {
                self.showAlert("Something went wrong", buttons: ["Ok"], completion: nil)
            }
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       

        //Get updated text
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        var updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        updatedText = updatedText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if updatedText.count >= 3 {
            searchSongsApiCall(strSearch: updatedText)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
        if textField.text!.isEmpty {
            self.viewModel.songs = []
            tableView.reloadData()
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.viewModel.songs = []
        tableView.reloadData()
        return true
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count: Int = viewModel.songs?.count {
            if count == 0 {
                self.tableView.setEmptyMessage("No data found!")
            } else {
                self.tableView.restore()
            }
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongDetailsTableViewCell.reuseIdentifier) as! SongDetailsTableViewCell
        if let songsDetail = self.viewModel.songs?[indexPath.row] {
            cell.configureData(songDetail: songsDetail)
        }
        return cell
    }
}

extension MainViewController {
    func searchSongsApiCall(strSearch: String) {
        if isNetworkReachable {
            viewModel.getSongs(searchKeyword: strSearch)
            self.updateUI()
        } else {
            self.showAlert("Please check your internet connection!", buttons: ["Ok"], completion: nil)
        }
    }
    
    private func updateUI() {
        switch viewModel.isLoading {
        case true:
            startLoader()
        case false:
            stopLoader()
        }
    }
}

