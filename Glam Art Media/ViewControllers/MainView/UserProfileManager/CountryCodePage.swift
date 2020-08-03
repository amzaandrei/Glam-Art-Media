//
//  CountryCodePage.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/3/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation


protocol PrefixProtocol{
    func prefix(prefixStr: String)
}

class CountryCodePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellId = "cellId"
    
    var prefixDelegate: PrefixProtocol?
    var indexSelected: Int = 0 {
        didSet {
            self.dismiss(animated: true) {
                self.prefixDelegate?.prefix(prefixStr: String(self.countryCodes[self.indexSelected].dialCode))
            }
        }
    }
    
    lazy var tableVieww: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(tableVieww)
        tableVieww.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(countryCodes[indexPath.row].name) (\(countryCodes[indexPath.row].dialCode))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
    }
    
    var countryCodes: [CountryCode] = [
        CountryCode(name: "Afghanistan", dialCode: "+93", code: "AF"),
        CountryCode(name: "Åland Islands", dialCode: "+358", code: "AX"),
        CountryCode(name: "Albania", dialCode: "+355", code: "AL"),
        CountryCode(name: "Algeria", dialCode: "+213", code: "DZ"),
        CountryCode(name: "American Samoa", dialCode: "+1684", code: "AS"),
        CountryCode(name: "Andorra", dialCode: "+376", code: "AD"),
        CountryCode(name: "Angola", dialCode: "+244", code: "AO"),
        CountryCode(name: "Anguilla", dialCode: "+1264", code: "AI"),
        CountryCode(name: "Antarctica", dialCode: "+672", code: "AQ"),
        CountryCode(name: "Antigua and Barbuda", dialCode: "+1268", code: "AG"),
        CountryCode(name: "Argentina", dialCode: "+54", code: "AR"),
        CountryCode(name: "Armenia", dialCode: "+374", code: "AM"),
        CountryCode(name: "Aruba", dialCode: "+297", code: "AW"),
        CountryCode(name: "Australia", dialCode: "+61", code: "AU"),
        CountryCode(name: "Austria", dialCode: "+43", code: "AT"),
        CountryCode(name: "Azerbaijan", dialCode: "+994", code: "AZ"),
        CountryCode(name: "Bahamas", dialCode: "+1242", code: "BS"),
        CountryCode(name: "Bahrain", dialCode: "+973", code: "BH"),
        CountryCode(name: "Bangladesh", dialCode: "+880", code: "BD"),
        CountryCode(name: "Barbados", dialCode: "+1246", code: "BB"),
        CountryCode(name: "Belarus", dialCode: "+375", code: "BY"),
        CountryCode(name: "Belgium", dialCode: "+32", code: "BE"),
        CountryCode(name: "Belize", dialCode: "+501", code: "BZ"),
        CountryCode(name: "Benin", dialCode: "+229", code: "BJ"),
        CountryCode(name: "Bermuda", dialCode: "+1441", code: "BM"),
        CountryCode(name: "Bhutan", dialCode: "+975", code: "BT"),
        CountryCode(name: "Bolivia, Plurinational State of bolivia", dialCode: "+591", code: "BO"),
        CountryCode(name: "Bosnia and Herzegovina", dialCode: "+387", code: "BA"),
        CountryCode(name: "Botswana", dialCode: "+267", code: "BW"),
        CountryCode(name: "Bouvet Island", dialCode: "+47", code: "BV"),
        CountryCode(name: "Brazil", dialCode: "+55", code: "BR"),
        CountryCode(name: "British Indian Ocean Territory", dialCode: "+246", code: "IO"),
        CountryCode(name: "Brunei Darussalam", dialCode: "+673", code: "BN"),
        CountryCode(name: "Bulgaria", dialCode: "+359", code: "BG"),
        CountryCode(name: "Burkina Faso", dialCode: "+226", code: "BF"),
        CountryCode(name: "Burundi", dialCode: "+257", code: "BI"),
        CountryCode(name: "Cambodia", dialCode: "+855", code: "KH"),
        CountryCode(name: "Cameroon", dialCode: "+237", code: "CM"),
        CountryCode(name: "Canada", dialCode: "+1", code: "CA"),
        CountryCode(name: "Cape Verde", dialCode: "+238", code: "CV"),
        CountryCode(name: "Cayman Islands", dialCode: "+ 345", code: "KY"),
        CountryCode(name: "Central African Republic", dialCode: "+236", code: "CF"),
        CountryCode(name: "Chad", dialCode: "+235", code: "TD"),
        CountryCode(name: "Chile", dialCode: "+56", code: "CL"),
        CountryCode(name: "China", dialCode: "+86", code: "CN"),
        CountryCode(name: "Christmas Island", dialCode: "+61", code: "CX"),
        CountryCode(name: "Cocos (Keeling) Islands", dialCode: "+61", code: "CC"),
        CountryCode(name: "Colombia", dialCode: "+57", code: "CO"),
        CountryCode(name: "Comoros", dialCode: "+269", code: "KM"),
        CountryCode(name: "Congo", dialCode: "+242", code: "CG"),
        CountryCode(name: "Congo, The Democratic Republic of the Congo", dialCode: "+243", code: "CD"),
        CountryCode(name: "Cook Islands", dialCode: "+682", code: "CK"),
        CountryCode(name: "Costa Rica", dialCode: "+506", code: "CR"),
        CountryCode(name: "Cote d'Ivoire", dialCode: "+225", code: "CI"),
        CountryCode(name: "Croatia", dialCode: "+385", code: "HR"),
        CountryCode(name: "Cuba", dialCode: "+53", code: "CU"),
        CountryCode(name: "Cyprus", dialCode: "+357", code: "CY"),
        CountryCode(name: "Czech Republic", dialCode: "+420", code: "CZ"),
        CountryCode(name: "Denmark", dialCode: "+45", code: "DK"),
        CountryCode(name: "Djibouti", dialCode: "+253", code: "DJ"),
        CountryCode(name: "Dominica", dialCode: "+1767", code: "DM"),
        CountryCode(name: "Dominican Republic", dialCode: "+1849", code: "DO"),
        CountryCode(name: "Ecuador", dialCode: "+593", code: "EC"),
        CountryCode(name: "Egypt", dialCode: "+20", code: "EG"),
        CountryCode(name: "El Salvador", dialCode: "+503", code: "SV"),
        CountryCode(name: "Equatorial Guinea", dialCode: "+240", code: "GQ"),
        CountryCode(name: "Eritrea", dialCode: "+291", code: "ER"),
        CountryCode(name: "Estonia", dialCode: "+372", code: "EE"),
        CountryCode(name: "Ethiopia", dialCode: "+251", code: "ET"),
        CountryCode(name: "Falkland Islands (Malvinas)", dialCode: "+500", code: "FK"),
        CountryCode(name: "Faroe Islands", dialCode: "+298", code: "FO"),
        CountryCode(name: "Fiji", dialCode: "+679", code: "FJ"),
        CountryCode(name: "Finland", dialCode: "+358", code: "FI"),
        CountryCode(name: "France", dialCode: "+33", code: "FR"),
        CountryCode(name: "French Guiana", dialCode: "+594", code: "GF"),
        CountryCode(name: "French Polynesia", dialCode: "+689", code: "PF"),
        CountryCode(name: "French Southern Territories", dialCode: "+262", code: "TF"),
        CountryCode(name: "Gabon", dialCode: "+241", code: "GA"),
        CountryCode(name: "Gambia", dialCode: "+220", code: "GM"),
        CountryCode(name: "Georgia", dialCode: "+995", code: "GE"),
        CountryCode(name: "Germany", dialCode: "+49", code: "DE"),
        CountryCode(name: "Ghana", dialCode: "+233", code: "GH"),
        CountryCode(name: "Gibraltar", dialCode: "+350", code: "GI"),
        CountryCode(name: "Greece", dialCode: "+30", code: "GR"),
        CountryCode(name: "Greenland", dialCode: "+299", code: "GL"),
        CountryCode(name: "Grenada", dialCode: "+1473", code: "GD"),
        CountryCode(name: "Guadeloupe", dialCode: "+590", code: "GP"),
        CountryCode(name: "Guam", dialCode: "+1671", code: "GU"),
        CountryCode(name: "Guatemala", dialCode: "+502", code: "GT"),
        CountryCode(name: "Guernsey", dialCode: "+44", code: "GG"),
        CountryCode(name: "Guinea", dialCode: "+224", code: "GN"),
        CountryCode(name: "Guinea-Bissau", dialCode: "+245", code: "GW"),
        CountryCode(name: "Guyana", dialCode: "+592", code: "GY"),
        CountryCode(name: "Haiti", dialCode: "+509", code: "HT"),
        CountryCode(name: "Heard Island and Mcdonald Islands", dialCode: "+0", code: "HM"),
        CountryCode(name: "Holy See (Vatican City State)", dialCode: "+379", code: "VA"),
        CountryCode(name: "Honduras", dialCode: "+504", code: "HN"),
        CountryCode(name: "Hong Kong", dialCode: "+852", code: "HK"),
        CountryCode(name: "Hungary", dialCode: "+36", code: "HU"),
        CountryCode(name: "Iceland", dialCode: "+354", code: "IS"),
        CountryCode(name: "India", dialCode: "+91", code: "IN"),
        CountryCode(name: "Indonesia", dialCode: "+62", code: "ID"),
        CountryCode(name: "Iran, Islamic Republic of Persian Gulf", dialCode: "+98", code: "IR"),
        CountryCode(name: "Iraq", dialCode: "+964", code: "IQ"),
        CountryCode(name: "Ireland", dialCode: "+353", code: "IE"),
        CountryCode(name: "Isle of Man", dialCode: "+44", code: "IM"),
        CountryCode(name: "Israel", dialCode: "+972", code: "IL"),
        CountryCode(name: "Italy", dialCode: "+39", code: "IT"),
        CountryCode(name: "Jamaica", dialCode: "+1876", code: "JM"),
        CountryCode(name: "Japan", dialCode: "+81", code: "JP"),
        CountryCode(name: "Jersey", dialCode: "+44", code: "JE"),
        CountryCode(name: "Jordan", dialCode: "+962", code: "JO"),
        CountryCode(name: "Kazakhstan", dialCode: "+7", code: "KZ"),
        CountryCode(name: "Kenya", dialCode: "+254", code: "KE"),
        CountryCode(name: "Kiribati", dialCode: "+686", code: "KI"),
        CountryCode(name: "Korea, Democratic People's Republic of Korea", dialCode: "+850", code: "KP"),
        CountryCode(name: "Korea, Republic of South Korea", dialCode: "+82", code: "KR"),
        CountryCode(name: "Kosovo", dialCode: "+383", code: "XK"),
        CountryCode(name: "Kuwait", dialCode: "+965", code: "KW"),
        CountryCode(name: "Kyrgyzstan", dialCode: "+996", code: "KG"),
        CountryCode(name: "Laos", dialCode: "+856", code: "LA"),
        CountryCode(name: "Latvia", dialCode: "+371", code: "LV"),
        CountryCode(name: "Lebanon", dialCode: "+961", code: "LB"),
        CountryCode(name: "Lesotho", dialCode: "+266", code: "LS"),
        CountryCode(name: "Liberia", dialCode: "+231", code: "LR"),
        CountryCode(name: "Libyan Arab Jamahiriya", dialCode: "+218", code: "LY"),
        CountryCode(name: "Liechtenstein", dialCode: "+423", code: "LI"),
        CountryCode(name: "Lithuania", dialCode: "+370", code: "LT"),
        CountryCode(name: "Luxembourg", dialCode: "+352", code: "LU"),
        CountryCode(name: "Macao", dialCode: "+853", code: "MO"),
        CountryCode(name: "Macedonia", dialCode: "+389", code: "MK"),
        CountryCode(name: "Madagascar", dialCode: "+261", code: "MG"),
        CountryCode(name: "Malawi", dialCode: "+265", code: "MW"),
        CountryCode(name: "Malaysia", dialCode: "+60", code: "MY"),
        CountryCode(name: "Maldives", dialCode: "+960", code: "MV"),
        CountryCode(name: "Mali", dialCode: "+223", code: "ML"),
        CountryCode(name: "Malta", dialCode: "+356", code: "MT"),
        CountryCode(name: "Marshall Islands", dialCode: "+692", code: "MH"),
        CountryCode(name: "Martinique", dialCode: "+596", code: "MQ"),
        CountryCode(name: "Mauritania", dialCode: "+222", code: "MR"),
        CountryCode(name: "Mauritius", dialCode: "+230", code: "MU"),
        CountryCode(name: "Mayotte", dialCode: "+262", code: "YT"),
        CountryCode(name: "Mexico", dialCode: "+52", code: "MX"),
        CountryCode(name: "Micronesia, Federated States of Micronesia", dialCode: "+691", code: "FM"),
        CountryCode(name: "Moldova", dialCode: "+373", code: "MD"),
        CountryCode(name: "Monaco", dialCode: "+377", code: "MC"),
        CountryCode(name: "Mongolia", dialCode: "+976", code: "MN"),
        CountryCode(name: "Montenegro", dialCode: "+382", code: "ME"),
        CountryCode(name: "Montserrat", dialCode: "+1664", code: "MS"),
        CountryCode(name: "Morocco", dialCode: "+212", code: "MA"),
        CountryCode(name: "Mozambique", dialCode: "+258", code: "MZ"),
        CountryCode(name: "Myanmar", dialCode: "+95", code: "MM"),
        CountryCode(name: "Namibia", dialCode: "+264", code: "NA"),
        CountryCode(name: "Nauru", dialCode: "+674", code: "NR"),
        CountryCode(name: "Nepal", dialCode: "+977", code: "NP"),
        CountryCode(name: "Netherlands", dialCode: "+31", code: "NL"),
        CountryCode(name: "Netherlands Antilles", dialCode: "+599", code: "AN"),
        CountryCode(name: "New Caledonia", dialCode: "+687", code: "NC"),
        CountryCode(name: "New Zealand", dialCode: "+64", code: "NZ"),
        CountryCode(name: "Nicaragua", dialCode: "+505", code: "NI"),
        CountryCode(name: "Niger", dialCode: "+227", code: "NE"),
        CountryCode(name: "Nigeria", dialCode: "+234", code: "NG"),
        CountryCode(name: "Niue", dialCode: "+683", code: "NU"),
        CountryCode(name: "Norfolk Island", dialCode: "+672", code: "NF"),
        CountryCode(name: "Northern Mariana Islands", dialCode: "+1670", code: "MP"),
        CountryCode(name: "Norway", dialCode: "+47", code: "NO"),
        CountryCode(name: "Oman", dialCode: "+968", code: "OM"),
        CountryCode(name: "Pakistan", dialCode: "+92", code: "PK"),
        CountryCode(name: "Palau", dialCode: "+680", code: "PW"),
        CountryCode(name: "Palestinian Territory, Occupied", dialCode: "+970", code: "PS"),
        CountryCode(name: "Panama", dialCode: "+507", code: "PA"),
        CountryCode(name: "Papua New Guinea", dialCode: "+675", code: "PG"),
        CountryCode(name: "Paraguay", dialCode: "+595", code: "PY"),
        CountryCode(name: "Peru", dialCode: "+51", code: "PE"),
        CountryCode(name: "Philippines", dialCode: "+63", code: "PH"),
        CountryCode(name: "Pitcairn", dialCode: "+64", code: "PN"),
        CountryCode(name: "Poland", dialCode: "+48", code: "PL"),
        CountryCode(name: "Portugal", dialCode: "+351", code: "PT"),
        CountryCode(name: "Puerto Rico", dialCode: "+1939", code: "PR"),
        CountryCode(name: "Qatar", dialCode: "+974", code: "QA"),
        CountryCode(name: "Romania", dialCode: "+40", code: "RO"),
        CountryCode(name: "Russia", dialCode: "+7", code: "RU"),
        CountryCode(name: "Rwanda", dialCode: "+250", code: "RW"),
        CountryCode(name: "Reunion", dialCode: "+262", code: "RE"),
        CountryCode(name: "Saint Barthelemy", dialCode: "+590", code: "BL"),
        CountryCode(name: "Saint Helena, Ascension and Tristan Da Cunha", dialCode: "+290", code: "SH"),
        CountryCode(name: "Saint Kitts and Nevis", dialCode: "+1869", code: "KN"),
        CountryCode(name: "Saint Lucia", dialCode: "+1758", code: "LC"),
        CountryCode(name: "Saint Martin", dialCode: "+590", code: "MF"),
        CountryCode(name: "Saint Pierre and Miquelon", dialCode: "+508", code: "PM"),
        CountryCode(name: "Saint Vincent and the Grenadines", dialCode: "+1784", code: "VC"),
        CountryCode(name: "Samoa", dialCode: "+685", code: "WS"),
        CountryCode(name: "San Marino", dialCode: "+378", code: "SM"),
        CountryCode(name: "Sao Tome and Principe", dialCode: "+239", code: "ST"),
        CountryCode(name: "Saudi Arabia", dialCode: "+966", code: "SA"),
        CountryCode(name: "Senegal", dialCode: "+221", code: "SN"),
        CountryCode(name: "Serbia", dialCode: "+381", code: "RS"),
        CountryCode(name: "Seychelles", dialCode: "+248", code: "SC"),
        CountryCode(name: "Sierra Leone", dialCode: "+232", code: "SL"),
        CountryCode(name: "Singapore", dialCode: "+65", code: "SG"),
        CountryCode(name: "Slovakia", dialCode: "+421", code: "SK"),
        CountryCode(name: "Slovenia", dialCode: "+386", code: "SI"),
        CountryCode(name: "Solomon Islands", dialCode: "+677", code: "SB"),
        CountryCode(name: "Somalia", dialCode: "+252", code: "SO"),
        CountryCode(name: "South Africa", dialCode: "+27", code: "ZA"),
        CountryCode(name: "South Sudan", dialCode: "+211", code: "SS"),
        CountryCode(name: "South Georgia and the South Sandwich Islands", dialCode: "+500", code: "GS"),
        CountryCode(name: "Spain", dialCode: "+34", code: "ES"),
        CountryCode(name: "Sri Lanka", dialCode: "+94", code: "LK"),
        CountryCode(name: "Sudan", dialCode: "+249", code: "SD"),
        CountryCode(name: "Suriname", dialCode: "+597", code: "SR"),
        CountryCode(name: "Svalbard and Jan Mayen", dialCode: "+47", code: "SJ"),
        CountryCode(name: "Swaziland", dialCode: "+268", code: "SZ"),
        CountryCode(name: "Sweden", dialCode: "+46", code: "SE"),
        CountryCode(name: "Switzerland", dialCode: "+41", code: "CH"),
        CountryCode(name: "Syrian Arab Republic", dialCode: "+963", code: "SY"),
        CountryCode(name: "Taiwan", dialCode: "+886", code: "TW"),
        CountryCode(name: "Tajikistan", dialCode: "+992", code: "TJ"),
        CountryCode(name: "Tanzania, United Republic of Tanzania", dialCode: "+255", code: "TZ"),
        CountryCode(name: "Thailand", dialCode: "+66", code: "TH"),
        CountryCode(name: "Timor-Leste", dialCode: "+670", code: "TL"),
        CountryCode(name: "Togo", dialCode: "+228", code: "TG"),
        CountryCode(name: "Tokelau", dialCode: "+690", code: "TK"),
        CountryCode(name: "Tonga", dialCode: "+676", code: "TO"),
        CountryCode(name: "Trinidad and Tobago", dialCode: "+1868", code: "TT"),
        CountryCode(name: "Tunisia", dialCode: "+216", code: "TN"),
        CountryCode(name: "Turkey", dialCode: "+90", code: "TR"),
        CountryCode(name: "Turkmenistan", dialCode: "+993", code: "TM"),
        CountryCode(name: "Turks and Caicos Islands", dialCode: "+1649", code: "TC"),
        CountryCode(name: "Tuvalu", dialCode: "+688", code: "TV"),
        CountryCode(name: "Uganda", dialCode: "+256", code: "UG"),
        CountryCode(name: "Ukraine", dialCode: "+380", code: "UA"),
        CountryCode(name: "United Arab Emirates", dialCode: "+971", code: "AE"),
        CountryCode(name: "United Kingdom", dialCode: "+44", code: "GB"),
        CountryCode(name: "United States", dialCode: "+1", code: "US"),
        CountryCode(name: "Uruguay", dialCode: "+598", code: "UY"),
        CountryCode(name: "Uzbekistan", dialCode: "+998", code: "UZ"),
        CountryCode(name: "Vanuatu", dialCode: "+678", code: "VU"),
        CountryCode(name: "Venezuela, Bolivarian Republic of Venezuela", dialCode: "+58", code: "VE"),
        CountryCode(name: "Vietnam", dialCode: "+84", code: "VN"),
        CountryCode(name: "Virgin Islands, British", dialCode: "+1284", code: "VG"),
        CountryCode(name: "Virgin Islands, U.S.", dialCode: "+1340", code: "VI"),
        CountryCode(name: "Wallis and Futuna", dialCode: "+681", code: "WF"),
        CountryCode(name: "Yemen", dialCode: "+967", code: "YE"),
        CountryCode(name: "Zambia", dialCode: "+260", code: "ZM"),
        CountryCode(name: "Zimbabwe", dialCode: "+263", code: "ZW"),
    ]

}
