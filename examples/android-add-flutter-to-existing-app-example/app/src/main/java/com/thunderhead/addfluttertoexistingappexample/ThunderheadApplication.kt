package com.thunderhead.addfluttertoexistingappexample

import android.app.Application
import com.thunderhead.OneModes
import com.thunderhead.android.api.oneConfigure
import java.net.URI

class ThunderheadApplication : Application() {
    companion object {
        const val SITE_KEY = "ONE-XXXXXXXXXX-1022"
        const val API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx"
        const val SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx"
        const val USER_ID = "yourUsername@yourCompanyName" // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
        const val HOST = "https://xx.thunderhead.com" 
        const val TOUCHPOINT = "myAppsNameURI"
    }

    override fun onCreate() {
        super.onCreate()

        oneConfigure {
            siteKey = SITE_KEY
            apiKey = API_KEY
            sharedSecret = SHARED_SECRET
            userId = USER_ID
            host = URI(HOST)
            touchpoint = URI(TOUCHPOINT)
            mode = OneModes.USER_MODE
        }
    }
}