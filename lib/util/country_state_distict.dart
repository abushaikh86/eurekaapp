class CountryStateDistrict {
  static List<Map<String, dynamic>> getCountries() {
    var country_arr = [
      "Select Country",
      "AUSTRALIA",
      "INDIA",
      "NEW ZEALAND",
      "USA",
      "UAE",
      "MAURITIUS"
    ];
    var countryList = country_arr.asMap().entries.map((entry) {
      return {'id': entry.key, 'name': entry.value};
    }).toList();

    return countryList;
  }

  static List<Map<String, dynamic>> getStates(index) {
    var s_a = [
      "Select State",
      "Select State|QUEENSLAND|VICTORIA",
      "Select State|ANDHRA PRADESH|ARUNACHAL PRADESH|ASSAM|BIHAR|CHHATTISGARH|GOA|GUJARAT|HARYANA|HIMACHAL PRADESH|JHARKHAND|KARNATAKA|KERALA|MADHYA PRADESH|MAHARASHTRA|MANIPUR|MEGHALAYA|MIZORAM|NAGALAND|ODISHA|PUNJAB|RAJASTHAN|SIKKIM|TAMIL NADU|TELANGANA|TRIPURA|UTTARAKHAND|UTTAR PRADESH|WEST BENGAL",
      "Select State|AUCKLAND",
      "Select State|NEWJERSEY|ILLINOIS",
      "Select State|DUBAI",
      "Select State|MAURITIUS"
    ];

    var stateList = s_a
        .asMap()
        .entries
        .where((entry) => entry.key == index || entry.key == 0)
        .map((entry) {
          if (entry.key == index) {
            return entry.value.split('|').sublist(1).map((state) {
              return {'id': state, 'name': state};
            }).toList();
          } else {
            return [
              {'id': entry.value, 'name': entry.value}
            ];
          }
        })
        .expand((e) => e)
        .toList();

    return stateList;
  }

  static List<Map<String, dynamic>> getDistricts(index) {
    var c_a = {
      "QUEENSLAND": "BRISBANE",
      "VICTORIA": "MELBOURNE",
      "ANDHRA PRADESH":
          "ANANTAPUR|CHITTOOR|EAST GODAVARI|GUNTUR|KRISHNA|KURNOOL|NELLORE|PRAKASAM|SRIKAKULAM|VISAKHAPATNAM|VIZIANAGARAM|WEST GODAVARI|YSR KADAPA",
      "ARUNACHAL PRADESH":
          "ANJAW|CHANGLANG|DIBANG VALLEY|EAST KAMENG|EAST SIANG|KAMLE|KRA DAADI|KURUNG KUMEY|LEPAA RADA|LOHIT|LONGDING|LOWER DIBANG VALLEY|LOWER SIANG|LOWER SUBANSIRI|NAMSAI|PAPUM PARE|SHI YOMI|SIANG|TAWANG|TIRAP|UPPER DIBANG VALLEY|UPPER SIANG|UPPER SUBANSIRI|WEST KAMENG|WEST SIANG",
      "ASSAM":
          "BAKSA|BARPETA|BISWANATH|BONGAIGAON|CACHAR|CHARAIDEO|CHIRANG|DARRANG|DHEMAJI|DHUBRI|DIBRUGARH|DIMA HASAO|GOALPARA|GOLAGHAT|HAILAKANDI|HOJAI|JORHAT|KAMRUP|KAMRUP METROPOLITAN|KARBI ANGLONG|KARIMGANJ|KOKRAJHAR|LAKHIMPUR|MAJULI|MORIGAON|NAGAON|NALBARI|SIVASAGAR|SONITPUR|SOUTH SALMARA-MANKACHAR|TINSUKIA|UDALGURI|WEST KARBI ANGLONG",
      "BIHAR":
          "ARARIA|ARWAL|AURANGABAD|BANKA|BEGUSARAI|BHAGALPUR|BHOJPUR|BUXAR|DARBHANGA|EAST CHAMPARAN|GOPALGANJ|JAMUI|JEHANABAD|KAIMUR|KATIHAR|KHAGARIA|KISHANGANJ|LAKHISARAI|MADHEPURA|MADHUBANI|MUNGER|MUZAFFARPUR|NALANDA|NAWADA|PASHCHIM CHAMPARAN|PATNA|PURBI CHAMPARAN|PURNIA|ROHTAS|SAHARSA|SAMASTIPUR|SARAN|SHEIKHPURA|SHEOHAR|SITAMARHI|SIWAN|SUPAUL|VAISHALI",
      "CHHATTISGARH":
          "BALOD|BALODA BAZAR|BALRAMPUR|BAMETARA|BASTAR|BIJAPUR|BILASPUR|DANTEWADA|DHAMTARI|DURG|GARIABAND|GAURELA PENDRA MARWAHI|JANJGIR-CHAMPA|JASHPUR|KABIRDHAM|KANKER|KONDAGAON|KORBA|KOREA|MAHASAMUND|MUNGELI|NARAYANPUR|RAIGARH|RAIPUR|RAJNANDGAON|SUKMA|SURAJPUR",
      "GOA": "NORTH GOA|SOUTH GOA",
      "GUJARAT":
          "AHMEDABAD|AMRELI|ANAND|ARAVALLI|BANASKANTHA|BHARUCH|BHAVNAGAR|BOTAD|CHHOTA UDAIPUR|DAHOD|DANG|DEVSAR|DWARKA|GANDHINAGAR|GIR SOMNATH|JAMNAGAR|JUNAGADH|KHEDA|KUTCH|MAHISAGAR|MEHSANA|MORBI|NARMADA|NAVSARI|PANCHMAHAL|PATAN|PORBANDAR|RAJKOT|SABARKANTHA|SURAT|SURENDRANAGAR|TAPI|VADODARA|VALSAD",
      "HARYANA":
          "AMBALA|BHIWANI|CHARKHI DADRI|FARIDABAD|FATEHABAD|GURUGRAM|HISAR|JHAJJAR|JIND|KAITHAL|KARNAL|KURUKSHETRA|MAHENDRAGARH|NUH|PALWAL|PANCHKULA|PANIPAT|REWARI|ROHTAK|SIRSA|SONIPAT|YAMUNANAGAR",
      "HIMACHAL PRADESH":
          "BILASPUR|CHAMBA|HAMIRPUR|KANGRA|KINNAUR|KULLU|LAHAUL AND SPITI|Mandi|SHIMLA|SIRMAUR|SOLAN|UNA",
      "JHARKHAND":
          "BOKARO|CHATRA|DEOGHAR|DUMKA|EAST SINGHBUM|GARHWA|GIRIDIH|GODDA|GUMLA|HAZARIBAGH|JAMTARA|KHUNTI|KODERMA|LATEHAR|LOHARDAGA|PAKUR|PALAMU|RAMGARH|RANCHI|SAHEBGANJ|SERAIKELA KHARSAWAN|SIMDEGA|WEST SINGHBHUM",
      "KARNATAKA":
          "BAGALKOT|BALLARI|BELAGAVI|BENGALURU RURAL|BENGALURU URBAN|BIDAR|CHAMARAJANAGAR|CHIKKABALLAPURA|CHIKKAMAGALURU|CHITRADURGA|DAKSHINA KANNADA|DAVANGERE|DHARWAD|GADAG|HASSAN|HAVERI|KALABURAGI|KODAGU|KOLAR|KOPPAL|MADHUGIRI|MANDYA|MYSURU|RAICHUR|RAMANAGARA|SHIVAMOGGA|TUMAKURU|UDUPI|UTTARA KANNADA|VIJAYAPURA|YADGIR",
      "KERALA":
          "ALAPPUZHA|ERNAKULAM|IDUKKI|KANNUR|KASARAGOD|KOLLAM|KOTTAYAM|KOZHIKODE|MALAPPURAM|PALAKKAD|PATHANAMTHITTA|THIRUVANANTHAPURAM|THRISSUR|WAYANAD",
      "MADHYA PRADESH":
          "AGAR MALWA|ALIRAJPUR|ANUPPUR|ASHOKNAGAR|BALAGHAT|BARWANI|BETUL|BHIND|BHOPAL|BURHANPUR|CHHATARPUR|CHHINDWARA|DAMOH|DATIA|DEWAS|DHAR|DINDORI|GUNA|GWALIOR|HARDA|HOSHANGABAD|INDORE|JABALPUR|JHABUA|KATNI|KHANDWA|KHARGONE|MADHYA BHARAT|MANDLA|MANDSAUR|MORENA|NARSINGHPUR|NEEMUCH|PANNA|RAISEN|RAJGARH|RATLAM|REWA|SAGAR|SATNA|SEHORE|SEONI|SHAHDOL|SHAJAPUR|SHEOPUR|SHIVPURI|SINGRAULI|TIKAMGARH|UJJAIN|UMARIA|VIDISHA",
      "MAHARASHTRA":
          "AHMEDNAGAR|AKOLA|AMRAVATI|BEED|BHANDARA|BULDHANA|CHANDRAPUR|DHULE|GADCHIROLI|GONDIA|HINGOLI|JALGAON|JALNA|KOLHAPUR|LATUR|NAGPUR|NANDED|NANDURBAR|NASHIK|OSMANABAD|PALGHAR|PARBHANI|PUNE|RAIGAD|RATNAGIRI|SANGLI|SATARA|SINDHUDURG|SOLAPUR|THANE|MUMBAI|WARDHA|WASHIM|YAVATMAL",
      "MANIPUR":
          "BISHNUPUR|CHANDEL|CHURACHANDPUR|IMPHAL EAST|IMPHAL WEST|JIRIBAM|KAKCHING|KAMJONG|KANGPOKPI|NONEY|PHERZAWL|SENAPATI|TAMENGLONG|TENGNOUPAL|THOUBAL|UKHRUL",
      "MEGHALAYA":
          "EAST GARO HILLS|EAST JAINTIA HILLS|EAST KHASI HILLS|NORTH GARO HILLS|RI BHOI|SOUTH GARO HILLS|SOUTH WEST GARO HILLS|SOUTH WEST KHASI HILLS|WEST GARO HILLS|WEST JAINTIA HILLS|WEST KHASI HILLS",
      "MIZORAM":
          "AIZAWL|CHAMPHAI|HNAHTHIAL|KHAWZAWL|KOLASIB|LAWNGTLAI|LUNGLEI|MAMIT|SAIHA|SERCHHIP",
      "NAGALAND":
          "DIMAPUR|KIPHIRE|KOHIMA|LONGLENG|MOKOKCHUNG|MON|PEREN|PHEK|TUENSANG|WOKHA|ZUNHEBOTO",
      "ODISHA":
          "ANGUL|BALANGIR|BALESHWAR|BARGARH|BHADRAK|BOUDH|CUTTACK|DEOGARH|DHENKANAL|GAJAPATI|GANJAM|JAGATSINGHAPUR|JAJPUR|JHARSUGUDA|KALAHANDI|KANDHAMAL|KENDRAPARA|KENDUJHAR|KHORDHA|KORAPUT|MALKANGIRI|MAYURBHANJ|NABARANGPUR|NAYAGARH|NUAPADA|PURI|RAYAGADA|SAMBALPUR|SONEPUR|SUNDARGARH",
      "PUNJAB":
          "AMRITSAR|BARNALA|BATHINDA|FARIDKOT|FATEHGARH SAHIB|FEROZEPUR|GURDASPUR|HOSHIARPUR|JALANDHAR|KAPURTHALA|LUDHIANA|MANSA|MOGA|MUKTSAR|PATHANKOT|PATIALA|RUPNAGAR|S.A.S NAGAR|SANGRUR|SHAHEED BHAGAT SINGH NAGAR|SRI MUKTSAR SAHIB|TARN TARAN",
      "RAJASTHAN":
          "AJMER|ALWAR|BANSWARA|BARAN|BARMER|BHARATPUR|BHILWARA|BIKANER|BUNDI|CHITTORGARH|CHURU|DAUSA|DHOLPUR|DUNGARPUR|GANGANAGAR|HANUMANGARH|JAIPUR|JAISALMER|JALORE|JHALAWAR|JHUNJHUNU|JODHPUR|KARAULI|KOTA|NAGAUR|PALI|PRATAPGARH|RAJSAMAND|SAWAI MADHOPUR|SIKAR|SIROHI|TONK|UDAIPUR",
      "SIKKIM": "EAST SIKKIM|NORTH SIKKIM|SOUTH SIKKIM|WEST SIKKIM",
      "TAMIL NADU":
          "ARIYALUR|CHENGALPATTU|CHENNAI|COIMBATORE|CUDDALORE|DHARMAPURI|DINDIGUL|ERODE|KALLAKURICHI|KANCHIPURAM|KANNIYAKUMARI|KARUR|KRISHNAGIRI|MADURAI|MAYILADUTHURAI|NAGAPATTINAM|NAMAKKAL|PERAMBALUR|PUDUKKOTTAI|RAMANATHAPURAM|RANIPET|SALEM|SIVAGANGA|TENKASI|THANJAVUR|THENI|THIRUVALLUR|THIRUVARUR|TIRUCHIRAPPALLI|TIRUNELVELI|TIRUPATHUR|TIRUPPUR|TIRUVANNAMALAI|TOOTHUKUDI|VELLORE|VILUPPURAM|VIRUDHUNAGAR",
      "TELANGANA":
          "ADILABAD|BHADRADRI KOTHAGUDEM|HYDERABAD|JAGTIAL|JANGOAN|JAYASHANKAR BHUPALPALLY|JOGULAMBA GADWAL|KAMAREDDY|KARIMNAGAR|KHAMMAM|KUMURAM BHEEM|MAHABUBABAD|MAHABUBNAGAR|MALKAJGIRI|MEDAK|MEDCHAL|MULUGU|NAGARKURNOOL|NALGONDA|NARAYANPET|NIRMAL|NIZAMABAD|PEDDAPALLI|RAJANNA SIRCILLA|RANGA REDDY|SANGAREDDY|SIDDIPET|SURYAPET|VIKARABAD|WANAPARTHY|WARANGAL RURAL|WARANGAL URBAN|YADADRI BHUVANAGIRI",
      "TRIPURA":
          "DHALAI|GOMATI|KHOWAI|NORTH TRIPURA|SEPÃ€HIJALA|SOUTH TRIPURA|UNAKOTI",
      "UTTARAKHAND":
          "ALMORA|BAGESHWAR|CHAMOLI|CHAMPAWAT|DEHRADUN|HARIDWAR|NAINITAL|PAURI GARHWAL|PITHORAGARH|RUDRAPRAYAG|TEHRI GARHWAL|UDAM SINGH NAGAR|UTTARKASHI",
      "UTTAR PRADESH":
          "AGRA|ALIGARH|AMBEDKAR NAGAR|AMETHI|AMROHA|AURAIYA|AYODHYA|AZAMGARH|BAGHPAT|BAHRAICH|BALLIA|BALRAMPUR|BANDA|BARABANKI|BAREILLY|BASTI|BHADOHI|BIJNOR|BUDAUN|BULANDSHAHR|CHANDAULI|CHITRAKOOT|DEORIA|ETAH|ETAWAH|FAIZABAD|FARRUKHABAD|FATEHPUR|FIROZABAD|GAUTAM BUDDHA NAGAR|GHAZIABAD|GHAZIPUR|GONDA|GORAKHPUR|HAMIRPUR|HAPUR|HARDOI|HATHRAS|JALAUN|JAUNPUR|JHANSI|KANNAUJ|KANPUR DEHAT|KANPUR NAGAR|KASGANJ|KAUSHAMBI|KHERI|KUSHINAGAR|LALITPUR|LUCKNOW|MAHARAJGANJ|MAHOBA|MAINPURI|MATHURA|MAU|MEERUT|MIRZAPUR|MORADABAD|MUZAFFARNAGAR|PILIBHIT|PRATAPGARH|RAE BARELI|RAMPUR|SAHARANPUR|SAMBHAL|SANT KABEER NAGAR|SANT RAVIDAS NAGAR|SHAHJAHANPUR|SHAMLI|SHRAVASTI|SIDDHARTH NAGAR|SITAPUR|SONBHADRA|SULTANPUR|UNNAO|VARANASI",
      "WEST BENGAL":
          "ALIPURDUAR|BANKURA|BIRBHUM|COOCH BEHAR|DARJEELING|DINAJPUR DAKSHIN|DINAJPUR UTTAR|HOOGHLY|HOWRAH|JALPAIGURI|JHARGRAM|KALIMPONG|KOLKATA|MALDAH|MURSHIDABAD|NADIA|PASCHIM BARDHAMAN|PURBA BARDHAMAN|PURI|PUSHKAR|PURULIA|SOUTH 24 PARGANAS|UTTAR DINAJPUR",
      "AUCKLAND": "AUCKLAND",
      "NEWJERSEY": "EDISON",
      "ILLINOIS": "CHICAGO",
      "MAURITIUS": "MAURITIUS",
      "DUBAI": "DUBAI"
    };

    var districtList = c_a.entries
        .where((entry) => entry.key == index || entry.key == 0)
        .map((entry) {
          if (entry.key == index) {
            return entry.value.split('|').map((district) {
              return {'id': district, 'name': district};
            }).toList();
          } else {
            return [
              {'id': entry.value, 'name': entry.value}
            ];
          }
        })
        .expand((e) => e)
        .toList();

    return districtList;
  }
}
