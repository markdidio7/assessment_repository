# Flix
### Assessment Repository
##### Created by Mark Di Dio
<br>

### API Calls
`URLSession.shared.dataTask()` returns data from a specified URL address. Closures are used in functions to access data in the background.

```swift
func loadShows(from urlString: String, completion: @escaping ([Show])->()) {

    // Safely unwrap the URL string as a valid URL.
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            // Access returned data and safely unwrap it.
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data),
                let jsonArray = json as? [[String: AnyObject]] else { return }
                
            // Convert json data into an array of Show objects.
            let shows = jsonArray.map { (jsonShow) -> Show in
                if let innerJsonShow = jsonShow["show"] as? [String: AnyObject] {
                    return Show(json: innerJsonShow)
                } else {
                    return Show(json: jsonShow)
                }
            }
                
            // Returns data within a completion to be used later within the closure. 
            completion(shows)
                
        }.resume()
    }
}
```
<sup>Flix - Created by Mark Di Dio<sup>

##### Threading

The `@escaping` parameter paired with a dispatch queue forces data back onto the main thread before modifying the user-interactive layer.

```swift
APICalls.get.loadAllShows { (shows) in
    DispatchQueue.main.async {
        self.shows = shows
    }
}
```
<sup>Flix - Created by Mark Di Dio<sup>
<br>
    
### Dark Mode (iOS 13)

On devices running iOS 13 or later, apps can take advantage of Apple's system wide Dark Mode.

Light Mode|Dark Mode
:-:|:-:
![](images/lastshiplightmode.png)  |  ![](images/lastshipdarkmode.png)

This can be applied using the stock standard background colours or by linking to the `traitCollection.userInterfaceStyle` listener.

```swift
let responsiveColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case .dark:
        return .black
    default:
        return .white
    }
}
```
<sup>Flix - Created by Mark Di Dio<sup>
<br>
    
### Adaptive Layout (Landscape)
Adaptive layout is achieved by varying traits within the storyboard to ensure the perfect fit on all screen sizes.
![](images/theamazingracelandscape.png)

### Cell Initialisation

Within a table or collection view's `cellForRowAt indexPath: IndexPath` delegated function, cells are initialised within themselves. This clears up any unnecessary data that the hosting view controller shouldn't know about.

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowCell
cell.initCell(show: shows[indexPath.row])
```
<sup>Flix - Created by Mark Di Dio<sup>
<br>
    
### Unit Tests
Test Driven Development (TDD) is favorable as it allows you to create a testable software that asserts your code is functioning correctly. It is especially useful when major code changes occur and you need to test that old code is functioning the same as before.

##### Testing Setup 
```swift
weekends = show.getReadableSchedule(showSchedule: [
    "time": "23:35" as AnyObject,
    "days": [ "Saturday", "Sunday"] as AnyObject
])
```

##### Testing Showtime Whitespaces
```swift
func testWhiteSpaces() {
    XCTAssertFalse(weekdays.first == " ")
    XCTAssertFalse(weekdays.last == " ")
}
```

##### Testing Showtime Contents
```swift
func testContents() {
    XCTAssertTrue(weekdays == "Weekday Nights")
    XCTAssertTrue(weekends == "Weekend Nights")
}
```









