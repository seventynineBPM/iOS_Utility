//
//  StringUtils.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/13.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import Foundation
import UIKit

class StringUtils {
    static func isEmpty(_ str: String?) -> Bool {
        if str == nil || str == "" {
            return true
        }
        
        return false
    }
    
    static func dicToUrlGETParam(_ params: [String:Any]) -> String {
        var GETParam = "?"
        
        params.forEach { (key, value) in
            GETParam = "\(GETParam)\(key)=\(value)&"
        }
        
        GETParam = GETParam.trimmingCharacters(in: ["&"])
        
        return GETParam
    }
    
    static func httpGetUrlFromDic(_ params: [String:Any], url: String) -> String {
        let urlString = url.trimmingCharacters(in: ["/"])
        
        return urlString + dicToUrlGETParam(params)
    }
    
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                
            }
        }
        return nil
    }
    
    /*
     * email validation checking
     */
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /*
     * companyRegNo : 사업자등록번호 10 자리
     * return : 000-00-00000, 사업자등록번호가 아닌 경우 return companyRegNo
     */
    static func getCompanyRegistrationNoTextType(_ companyRegNo: String) -> String {
        guard let _ = Int(companyRegNo) else {
            return companyRegNo
        }
        
        if companyRegNo.count != 10 {
            return companyRegNo
        }
        
        var result = ""
        for (i,char) in companyRegNo.enumerated() {
            if i == 2  || i == 4 {
                result = "\(result)\(char)-"
            } else {
                result = "\(result)\(char)"
            }
        }
        
        return result
    }
    
    /*
     * 참조 - https://gist.github.com/cslim-maxted/45361302e117b4075ab1a0f14bc07c72
     * 1) 사업자등록번호 10자리를 쓰고 각 자리마다 9자리 수를 맞춰서 쓴 다음 각각의 자리수를 곱합니다.
     * 2) 곱해서 나온 결과값이 2자를 넘으면 십의 자리를버리고 일의 자리만 씁니다.(예 : 2×5=10일 경우에는 0을 쓰고 7×5=35일 경우에는 5를 씀)
     * 3) 단 9번째 자리의 수는 곱해서 나온값을 그대로 적습니다. (45일 경우는 4와 5)
     * 4) 그런 다음, 곱해서 나온 수 10자를 각각 더합니다.
     * 위의 예의 경우를 계산해 보면  1+0+7+8+9+0+0+3+4+5를 전부 더하면 결과값이 37이 나옵니다.
     * 마지막으로 사업자번호 10자리중 검증번호라는 끝자리를 결과값에 더합니다.
     *
     * 37(결과값) + 3(검증번호) = 40
     *
     * 이처럼 결과값에 검증번호를 더해서 나온 값이 10의 배수(10,20,30,40,....)가 나오면 이 사업자등록번호는 구성원칙에 맞는 번호입니다.
     */
    static func isCompanyRegNum(number: String) -> Bool {
        // number 숫자 변환 체크
        guard let _ = Int(number) else { return false }
        
        //=======================================================
        // 사업자번호를 입력받아서 유효한 사업자 번호인지 체크하는 기능
        //=======================================================
        let bizNum: String = number           // 입력 사업자번호
        let veriNum: String = "137137135"           // 검증 대응숫자
        var checkSum: Int = 0                       // 검증번호
        //=======================================================
        
        var bizNumArr: [Int] = []
        for char in bizNum {
            bizNumArr.append(Int(String(char)) ?? 0)
        }
        
        var veriNumArr: [Int] = []
        for char in veriNum {
            veriNumArr.append(Int(String(char)) ?? 0)
        }
        
        // 1. 검증 대응숫자 기준으로 두 값을 곱하여 1의 자리 숫자를 추출
        var addValueArr: [Int] = []
        var sum: Int = 0;
        for i in 0...veriNumArr.count-1 {
            var tmp = bizNumArr[i] * veriNumArr[i]
            
            // 1~8 자리의 곱이 10 이상일 경우는 1자리의 숫자만 사용한다.
            if i < veriNumArr.count-1 {
                if tmp > 10 {
                    tmp = tmp%10
                }
                sum += tmp
            }
            addValueArr.append(tmp)
            //print(tmp)
        }
        //print(sum)
        //print(addValueArr[addValueArr.count-1])
        
        // 2. 마지막 9번번째 자리의 경우 10 이상일 경우 십의 자리와 일의 자리를 따로 숫자로 떼어서 합한다.
        if addValueArr[addValueArr.count-1] >= 10 {
            let lastNumStr = String(addValueArr[addValueArr.count-1])
            var lastNumArr: [Int] = []
            for char in lastNumStr {
                lastNumArr.append(Int(String(char)) ?? 0)
            }
            sum += lastNumArr[0]
            sum += lastNumArr[1]
        }
        else {
            sum += addValueArr[addValueArr.count-1]
        }
        
        // 3. 검증 숫자 검출
        checkSum = 10 - sum%10
        if checkSum==10 {checkSum=0}
        
        // 4. 검증
        if checkSum == bizNumArr[bizNumArr.count-1] {
//            print("검증 성공!")
            return true
        }
        
//        print("검증 실패!")
        return false
    }
    
    /*
     * 참고 - https://gist.github.com/cslim-maxted/1dedbe41b2f7a05d0ca2036a4bea86cd
     * 1. 등기관서별 분류번호, 법인종류별 분류번호 및 일련번호를 차례로 연결한 12자리의 숫자를 만든다.
     * 2. 각 숫자에 차례로 1과 2를 곱한 값을 모두 더하여 합을 구한다.
     * 3. 합을 10으로 나누어 몫과 나머지를 구한다.
     * 4. 10에서 나머지를 뺀 값을 오류검색번호로 한다. 다만, 10에서 나머지를 뺀 값이 10인 때에는 0을 오류검색번호로 한다.
     */
    static func isCorporateRegNum(number: String) -> Bool {
        //=======================================================
        // 사업자번호를 입력받아서 유효한 사업자 번호인지 체크하는 기능
        //=======================================================
        let corpNum: String = number           // 입력 법인번호
        let veriNum: String = "121212121212"            // 검증 대응숫자
        var checkSum: Int = 0                           // 검증번호
        //=======================================================
        
        var corpNumArr: [Int] = []
        for char in corpNum {
            corpNumArr.append(Int(String(char)) ?? 0)
        }
        
        var veriNumArr: [Int] = []
        for char in veriNum {
            veriNumArr.append(Int(String(char)) ?? 0)
        }
        
        // 1. 검증 대응숫자 기준으로 두 값을 곱하여 1의 자리 숫자를 추출
        var addValueArr: [Int] = []
        var sum: Int = 0;
        for i in 0...veriNumArr.count-1 {
            let tmp = corpNumArr[i] * veriNumArr[i]
            sum += tmp
            addValueArr.append(tmp)
        }
        
        // 3. 검증 숫자 검출
        checkSum = 10 - sum%10
        
        // 4. 검증
        if checkSum == corpNumArr[corpNumArr.count-1] {
//            print("검증 성공!")
            return true
        }
        
//        print("검증 실패!")
        return false
    }
    
    /**
     * return "1,000,000"
     */
    static func getNumberTypeString(_ number: Int) -> String {
//        var numString = String(number)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: number)!
    }
    
    ///
    /// 전화번호 포멧 문자열로 변환 ex) 010-xxxx-xxxxx, 02-xxxx-xxxx
    ///
    /// - parameter phoneNumber: 전화번호 숫자 문자열 ex) 12311112222
    /// - return 변환된 문자열 혹은 phoneNumber
    ///
    static func getTelephoneFormatString(_ phoneNumber: String) -> String {
        let regex = "(^02.{0}|^01.{1}|[0-9]{3})([0-9]{4}|[0-9]{3})([0-9]{4})"

        // metch checking
        let matched = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)

        if !matched {
            return phoneNumber
        }
        
        var replacedString = ""
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])

            replacedString = regex.stringByReplacingMatches(in: phoneNumber, options: .reportProgress,
                                                            range: NSRange(location: 0, length: phoneNumber.count),
                                                            withTemplate: "$1-$2-$3")
        } catch _ {
            return phoneNumber
        }

        return replacedString as String
    }
    
    /* 주민등록번호 유효성검사 */
    class func checkValidJumin(_ front: String, _ back: String) -> String {
        if front.count + back.count != 13 {
            if front.count + back.count == 0 {
                return ""
            }
            return "13자리를 입력해주세요."
        }
        let fixArr: [Int] = [2,3,4,5,6,7,8,9,2,3,4,5]
        var regArr = [Int]()
        var valiNum: Int = 0
        front.forEach{(item) in
            if let itemNum = Int(String(item)) {
                regArr.append(itemNum)
            }
        }
        back.forEach{(item) in
            if let itemNum = Int(String(item)) {
                regArr.append(itemNum)
            }
        }
        
        // 월,일 validation check
        let month = Int("\(regArr[2])\(regArr[3])") ?? 0
        let day = Int("\(regArr[4])\(regArr[5])") ?? 0
        if month <= 0 || month > 12 { return "올바른 주민등록번호가 아닙니다." }
        if day <= 0 || day > 31 { return "올바른 주민등록번호가 아닙니다." }
        
        // 뒷자리의 첫번째는 1,2,3,4만 가능 - 나중에 경우의 수가 늘어나면 추가해야함
        let backFirstCharArr: [Int] = [1, 2, 3, 4]
        var backValid: Bool = false
        backFirstCharArr.forEach { (num) in
            if regArr[6] == num {
                backValid = true
            }
        }
        guard backValid else { return "올바른 주민등록번호가 아닙니다." }
        
        for i in 0..<fixArr.count {
            valiNum = valiNum + fixArr[i] * regArr[i]
        }
        valiNum = valiNum % 11
        valiNum = 11 - valiNum
        if valiNum % 10 == regArr.last {
            return ""
        }
        return "올바른 주민등록번호가 아닙니다."
    }
    
    /* 주민등록번호 유효성검사 */
    class func isValidJumin(_ front: String, _ back: String) -> Bool {
        if front.count + back.count != 13 {
            return false
        }
        let fixArr: [Int] = [2,3,4,5,6,7,8,9,2,3,4,5]
        var regArr = [Int]()
        var valiNum: Int = 0
        front.forEach{(item) in
            if let itemNum = Int(String(item)) {
                regArr.append(itemNum)
            }
        }
        back.forEach{(item) in
            if let itemNum = Int(String(item)) {
                regArr.append(itemNum)
            }
        }
        
        // 월,일 validation check
        let month = Int("\(regArr[2])\(regArr[3])") ?? 0
        let day = Int("\(regArr[4])\(regArr[5])") ?? 0
        if month <= 0 || month > 12 { return false }
        if day <= 0 || month > 31 { return false }
        
        // 뒷자리의 첫번째는 1,2,3,4만 가능 - 나중에 경우의 수가 늘어나면 추가해야함
        let backFirstCharArr: [Int] = [1, 2, 3, 4]
        var backValid: Bool = false
        backFirstCharArr.forEach { (num) in
            if regArr[6] == num {
                backValid = true
            }
        }
        guard backValid else { return false }
        
        for i in 0..<fixArr.count {
            valiNum = valiNum + fixArr[i] * regArr[i]
        }
        valiNum = valiNum % 11
        valiNum = 11 - valiNum
        if valiNum % 10 == regArr.last {
            return true
        }
        return false
    }
    
    /* 문자열에 영문, 숫자만 있는지 체크 */
    class func haveOnlyEnglishOrNum(_ text: String) -> Bool {
        let hasEngNum = "[A-Za-z0-9]+"
        let predicate:NSPredicate = NSPredicate(format:"SELF MATCHES %@", hasEngNum)
        if predicate.evaluate(with: text) {
            return true
        } else {
            return false
        }
    }
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
