//
//  MainViewModel.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import Foundation

class MainViewModel {
    
    typealias GetSongsUpdatedCallback = (_ message: String?, _ error: Error?) -> Void
    
    var updatedOnGetSongs: GetSongsUpdatedCallback?
    
    private var dataProvider = MainDataProvider()
    private(set) var isLoading = false
    
    var songs : [SongDetails]?
    
    func getSongs(searchKeyword: String) {
        
        isLoading = true
        let params:[String:Any]  = ["term": searchKeyword, "media":"music", "entity":"song"]
        dataProvider.getSongsList(strUrl: Search_URL, params: params)
            .done({ response in
                self.isLoading = false
                if let data = response as? SongsResponse {
                    self.songs = data.songs
                    self.updatedOnGetSongs!("Song list fetch successfully!", nil)
                } else {
                    self.updatedOnGetSongs!("Something went wrong!", nil)
                }
            })
            .catch { error in
                self.isLoading = false
                self.updatedOnGetSongs!(nil, error)
            }
    }
}
