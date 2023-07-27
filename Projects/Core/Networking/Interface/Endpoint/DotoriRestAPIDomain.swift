import Foundation

/**
 * rawValue에 'dotori-role' 가 포함될 시 해당 문자열을 현재 로그인한 유저의 권한 문자열로 변환시킵니다.
 * ex) 'dotori-role/user' -> 'ROLE_STUDENT/user'
 */
public enum DotoriRestAPIDomain: String {
    case auth
    case selfStudy = "dotori-role/self-study"
    case massage = "dotori-role/massage"
    case notice = "dotori-role/board"
    case violation = "dotori-role/rule"
    case music = "dotori-role/music"
}
