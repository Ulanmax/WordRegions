

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "http://apiv3.iucnredlist.org/api/v3"
    }
    
    public func makeRegionsNetwork() -> RegionsNetwork {
        let network = Network<RegionModel>(apiEndpoint)
        return RegionsNetwork(network: network)
    }
}
