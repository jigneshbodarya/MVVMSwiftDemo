# MVVMSwiftDemo
Create a sample project that searches for a list of tracks from a given API and shows the results in a view controller. The UI design is up to you, but it should contain a search UITextField and a UITableView

# Mobile Practical Exercise
!!!The goal of this test is to see how you work. Please complete the criteria in a proper fashion, with a correct and complete architecture approach!!!

# Goal:
Create a sample project that searches for a list of tracks from a given API and shows the results in a view controller. The UI design is up to you, but it should contain a search UITextField and a UITableView
API: https://itunes.apple.com/search?term={search_term}&media=music&entity=song

Acceptance criteria:
1. Uses an MVVM architecture. Can have elements of clean architecture to make the code more modular
2. Uses Alamofire to communicate with the API and ObjectMapper to deserialize the JSON
3. Uses PromiseKit
4. Must use at least one CocoaPod and one Swift Package (example Alamofire via CocoaPods and PromiseKit via SPM, or vice-versa. It's up to you)
5. Must retrieve only songs, no other entities
6.The search UIViewController contains a search field and a table view. The table view will show any data retrieved. Each table view cell must show the information found under trackName, artistName, and artworkUrl100
7. Validates the searched text to be at least 3 characters in length before sending any request to the server
8. Uses a production ready architecture
9. base GET method that uses generics


