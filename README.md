# Flix
### Assessment Repository
#### Mark Di Dio

### Dark Mode (iOS 13)


### API Calls

Closures are used in functions to access data in the background.

```swift
func loadAllShows(completion: @escaping ([Show])->()) {
    let fullURL = AppConstants.baseURL + AppConstants.allShowsURL
    loadShows(from: fullURL, completion: completion)
}
```

### Threading

The `@escaping` parameter paired with a dispatch queue forces data back onto the main thread before modifying the user-interactive layer.

```swift
APICalls.get.loadAllShows { (shows) in
    DispatchQueue.main.async {
        self.shows = shows
    }
}
```
