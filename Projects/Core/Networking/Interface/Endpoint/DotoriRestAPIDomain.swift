import Foundation

/**
 * rawValue에 '<role>' 가 포함될 시 해당 문자열을 현재 로그인한 유저의 권한 문자열로 변환시킵니다.
 * ex) '<role>/user' -> 'ROLE_STUDENT/user'
 */
public enum DotoriRestAPIDomain: String {
    case auth
    case selfStudy = "<role>/self-study"
    case massage = "<role>/massage"
}
