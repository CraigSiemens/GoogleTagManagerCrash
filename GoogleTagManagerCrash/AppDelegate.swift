import FirebaseCore
import GoogleMaps
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
           let dictionary = NSDictionary(contentsOfFile: path),
            let key = dictionary["GOOGLE_MAPS_API_KEY"] as? String {
            GMSServices.provideAPIKey(key)
        } else {
            fatalError("Missing Google Maps API Key. See the README.")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
