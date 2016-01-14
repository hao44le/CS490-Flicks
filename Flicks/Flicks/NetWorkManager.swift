//
//  NetWorkManager.swift
//  ziliuxue
//
//  Created by WangShuo on 15/11/2.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class NetWorkManager: AFHTTPRequestOperationManager {

    init() {
        super.init(baseURL: nil)

        self.securityPolicy.allowInvalidCertificates = true
        self.securityPolicy.validatesDomainName = false
        self.requestSerializer = AFJSONRequestSerializer()
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer.setValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")


        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as? String

        if nil != token {
            self.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
