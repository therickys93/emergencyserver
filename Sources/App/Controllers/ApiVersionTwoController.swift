import Vapor
import HTTP
import Library

final class ApiVersionTwoController {
    
    private var logger: LogProtocol?
    
    private func logMessage(_ message: String){
        if self.logger != nil {
            self.logger?.debug(message)
        }
    }
    
    func addRoutes(drop: Droplet){
        // /api/v2
        self.logger = drop.log
        let v2 = drop.grouped("api/v2")
        // /api/v2/numbers
        let numbers = v2.grouped("numbers")
        numbers.get("all", handler: getAll)
        numbers.get(String.self, handler: getWithCountryCode)
        numbers.get(String.self, String.self, handler: getWithLatitudeAndLongitude)
    }
    
    // MARK: Version Two Numbers
    // GET /api/v2/numbers/all
    func getAll(request: Request) throws -> ResponseRepresentable {
        let response = DataSource().getAll()
        logMessage(response)
        return response
    }
    
    // GET /api/v2/numbers/:country
    func getWithCountryCode(request: Request, country: String) throws -> ResponseRepresentable {
        let response = DataSource().getCountryWithCountryCode(country)
        logMessage(response)
        return response
    }
    
    // GET /api/v2/numbers/:latitude/:longitude
    func getWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let countryCode = response.data["countrycode"]?.string, let city = response.data["city"]?.string {
            let reply = DataSource().getCountryWithCountryCode(countryCode, andClosestCity: city)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
}
