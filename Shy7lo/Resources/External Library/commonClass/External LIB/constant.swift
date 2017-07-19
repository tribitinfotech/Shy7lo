//
//  constant.swift
//  Masakin
//
//  Created by DK on 14/11/16.
//
//

import Foundation

enum Language {
    case Default
    case English
    case Arabic
}

var isEnglish:Bool  = true
var SelectedLang = "1"
var DeviceToken = ""
var userData:UserData! 
var isGoesToMainDash:Bool = false
var isGoesToAccount:Bool = false
var isGoesToAccountInnerViews:Bool = false
var isPressChangeLangInAccount:Bool = false
var isLoggedinAgent:Bool = false
var isGoPushWhenAgentMsg:Bool = false



let timeZone:String = TimeZone.current.identifier

//let BASE_URL  = "http://192.168.0.27/masakin/api/"
//let BASE_URL  = "http://52.66.6.178/masakin/api/"
//let BASE_URL = "http://139.162.155.223/masakin/api/"


let BASE_URL = "https://www.masakinapp.com/api/"
let STATUS_BAR_HEIGHT = 20



let API_Login = BASE_URL + "user/user_login"

let API_Registration = BASE_URL + "user/user_register"


let API_CheckUserRegistration = BASE_URL + "user/check_user_activation_code"

let API_Country_Code = BASE_URL + "user/country_code_list"


let API_CityList = BASE_URL + "user/city_list"

let API_Main_CityList = BASE_URL + "user/main_city_list"

let API_AreaList = BASE_URL + "user/area_list"

let API_AmenitiesList = BASE_URL + "user/amenities_list"

let API_DistrictList = BASE_URL + "user/district_list"

let API_PropertyList = BASE_URL + "property/property_search_list"

let API_Support_Contact = BASE_URL + "favorite/support_contact"

let API_ResendUserActivationCode = BASE_URL + "user/resend_user_activation_code"

let API_Added_Rating = BASE_URL + "favorite/give_ratting"

let API_Added_Review = BASE_URL + "favorite/give_review"

let API_Review_List = BASE_URL + "favorite/review_list"

let API_Favorite_Property = BASE_URL + "favorite/added_favorite"

let API_Favorite_Property_List = BASE_URL + "property/favorite_property_list"

let API_Todaydeal_Property_List = BASE_URL + "property/today_deal_property_list"

let API_Apartment_Group_List = BASE_URL + "property/apartment_group_list"

let API_Apartment_Group_Property_List = BASE_URL + "property/apartment_group_property_list"

let API_Change_Password = BASE_URL + "user/change_password"

let API_Change_Password_When_forgot = BASE_URL + "user/reset_password"

let API_Forgot_Password = BASE_URL + "user/forgot_password"

let API_Logout = BASE_URL + "user/logout"

let API_Map_View_List = BASE_URL + "property/property_map_view_list"

let API_Add_Report = BASE_URL + "favorite/report_add"

let API_Report_Abuse = BASE_URL + "favorite/report_abuse"

let API_About_App = BASE_URL + "favorite/about_us"

let API_Contact_US = BASE_URL + "favorite/contact_us_request"

let API_Chat_List = BASE_URL + "reservation/inquiry_list"

let API_Inquiry_Sent = BASE_URL + "reservation/inquiry_send"

let API_Cancel_Reservation = BASE_URL + "reservation/cancel_reservation"

let API_Chat_Message_List = BASE_URL + "reservation/chat_message_list"

let API_Chat_Send_Msg = BASE_URL + "reservation/send_message"

let API_Delete_Msgs = BASE_URL + "reservation/delete_messages"

let API_Twitter_Login = BASE_URL + "user/user_twitter_login"

let API_Unread_Msg = BASE_URL + "user/unread_count"

let API_Reset_Badge = BASE_URL + "favorite/badge_update"

let API_Ignore_User = BASE_URL + "reservation/ignore_for_chat"

let API_Allow_User = BASE_URL + "reservation/remove_ignore_for_chat"

let API_CheckIgnoreOrAllow_User = BASE_URL + "reservation/ignore_check"


//Agent API
let API_Agent_Registration = BASE_URL + "agent/agent_register"

let API_Agent_Login = BASE_URL + "agent/agent_login"

let API_ResendAgentActivationCode = BASE_URL + "agent/resend_agent_activation_code"

let API_Change_Mobile_OTP = BASE_URL + "agent/verify_number_change"

let API_forgot_Password_Verify = BASE_URL + "user/forgot_password_code_verify"

let API_CheckAgentRegistration = BASE_URL + "agent/check_agent_activation_code"

let API_Add_Property_List = BASE_URL + "property/added_property"

let API_Conditions_List = BASE_URL + "favorite/condition_list"

let API_My_Existing_Ads_List = BASE_URL + "property/my_property_list"

let API_Profile_Update = BASE_URL + "agent/agent_profile_change"

let API_Update_MobileNumber = BASE_URL + "agent/agent_number_change"

let API_Update_Avilibility = BASE_URL + "property/edit_property_unit"




let AuthUserName = "masakin_user"
let AuthPassword = "masakin_user"


//MARK:- Default Keys
let LANG_KEY            = "language"
let Arabic              = "ar"
let English             = "en"
let AppOrangeColor      = "F25D2A"
let ALERT_TITLE         = "Masakin"
let Device_Type         = "1"
let Key_DeviceToken     = "device_token"
