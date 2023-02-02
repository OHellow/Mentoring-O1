import Foundation

protocol LoginViewModelProtocol {
    var error: Observable<RequestError?> { get set }
    var startLoading: Observable<Bool> { get set }
}
