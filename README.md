# Flix
### Assessment Repository
##### Created by Mark Di Dio
<br>

### Dark Mode (iOS 13)

On devices running iOS 13 or later, apps can take advantage of Apple's system wide Dark Mode.

Light Mode|Dark Mode
:-:|:-:
![](images/lastshiplightmode.png)  |  ![](images/lastshipdarkmode.png)

This can be applied using the stock standard background colours or linking to the 'traitCollection.userInterfaceStyle' listener.

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

### API Calls

Closures are used in functions to access data in the background.

```swift
func loadShows(from urlString: String, completion: @escaping ([Show])->()) {

    // Safely unwrap the URL string as a valid URL
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data),
                let jsonArray = json as? [[String: AnyObject]] else { return }
                
            let shows = jsonArray.map { (jsonShow) -> Show in
                if let innerJsonShow = jsonShow["show"] as? [String: AnyObject] {
                    return Show(json: innerJsonShow)
                } else {
                    return Show(json: jsonShow)
                }
            }
                
            // Returns data within a completion to be used later in a closures 
            completion(shows)
                
        }.resume()
    }
}
```
<sup>Flix - Created by Mark Di Dio<sup>

#### Threading

The `@escaping` parameter paired with a dispatch queue forces data back onto the main thread before modifying the user-interactive layer.

```swift
APICalls.get.loadAllShows { (shows) in
    DispatchQueue.main.async {
        self.shows = shows
    }
}
```
<sup>Flix - Created by Mark Di Dio<sup>
