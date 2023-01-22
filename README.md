##  Take Home Project: Weather App

### Trade offs
  - I chose the MVP (Model View Presenter) architecture over the traditional MVC (Model View Controller) thinking mainly about testability and scalability. This way the business logic could be isolated on the `Presenter` instead the `View`.
  - For unit tests, I used the `Quick` library to improve readability, once we write the tests using explicit and understandable sentences. In addition, the `Nimble` library gives us a super power to match our tests expectations.

### Requirements
 - Xcode 14.0+ / iOS 16.0+
 - Swift 5.0+
 
> **No additional setup is required to run this project**

### 3rd party libraries
- [Alamofire:](https://github.com/Alamofire/Alamofire) HTTP networking
- [Kingfisher:](https://github.com/onevcat/Kingfisher) Image download and cache
- [Quick:](https://github.com/Quick/Quick) Behavior-driven development
- [Nimble:](https://github.com/Quick/Nimble) Expression matcher

### Aditional information
- As the UI touch was free to use, I added a new behavior, once you click on the screen the weather to be shown will be the next available.
- Missing service unit tests.
