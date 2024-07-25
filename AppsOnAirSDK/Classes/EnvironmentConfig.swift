
struct EnvironmentConfig{
    
// MARK: - Development Config:
    //static let serverBaseURl = "https://server.dev.appsonair.com/"
   // static let cdnBaseURL = "https://cdn.dev.appsonair.com/"
   
    
    
// MARK: - Production Config:
    static let serverBaseURl = "https://server.appsonair.com/"
    static let cdnBaseURL = "https://cdn.appsonair.com/"
    
    
    
// MARK: - API URL:
    static let serverURL = serverBaseURl + "v1/app-services/"
    static let cdnURL = cdnBaseURL + "app-details/"
}
