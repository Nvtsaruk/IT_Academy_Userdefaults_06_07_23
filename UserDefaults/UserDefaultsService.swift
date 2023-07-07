import Foundation

final class UserDefaultsService {
    static let shared = UserDefaults.standard
    
    static func receiveName() -> String? {
        return shared.string(forKey: Keys.name.rawValue)
    }
    
    static func receiveAge() -> String? {
        return shared.string(forKey: Keys.age.rawValue)
    }
    static func saveProfile(_ profile: Profile) {
        shared.setValue(profile.image, forKey: Keys.image.rawValue)
        shared.setValue(profile.name, forKey: Keys.name.rawValue)
        shared.setValue(profile.age, forKey: Keys.age.rawValue)
    }
    static func restoreProfile() -> Profile {
        let image = shared.data(forKey: Keys.image.rawValue) 
        let name = shared.string(forKey: Keys.name.rawValue)
        let age = shared.integer(forKey: Keys.age.rawValue)
        return Profile(image: image, name: name, age: age)
    }
    
    enum Keys: String {
        case image = "image"
        case name = "name"
        case age = "age"
        
        case profile = "profile"
    }
    
    
}
