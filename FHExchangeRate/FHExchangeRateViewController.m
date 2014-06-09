//
//  FHExchangeRateViewController.m
//  FHExchangeRate
//
//  Created by earth on 6/9/14.
//  Copyright (c) 2014 filmhomage.net. All rights reserved.
//

// This sample code use to EXCHANGE RATE API : www.webservicex.net

//www.webservicex.net//CurrencyConvertor.asmx/ConversionRate?FromCurrency=KRW&ToCurrency=JPY

#import "FHExchangeRateViewController.h"

#define kUserDeafultSourceIndex     @"UserDeafultSourceIndexKey"
#define kUserDeafultTargetIndex     @"UserDeafultTargetIndexKey"
#define kUserDeafultInputMoney       @"UserDeafultInputMoneyKey"

@interface FHExchangeRateViewController ()
{
    NSArray* _arrayMoney;
    double   _currentRate;
}
@end

@implementation FHExchangeRateViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self defineRateAndCountry];
    
    self.pickerSource.delegate = self;
    self.pickerSource.dataSource = self;
    
    self.pickerTarget.delegate = self;
    self.pickerTarget.dataSource = self;
    
    self.textFieldInputSource.delegate = self;
    self.textFieldInputSource.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.labelResult.textAlignment = NSTextAlignmentCenter;
    
    [self loadUserDeafult];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)loadUserDeafult
{
    NSNumber* indexSource = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDeafultSourceIndex];
    NSNumber* indexTarget = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDeafultTargetIndex];
    
    [self.pickerSource selectRow:[indexSource intValue] inComponent:0 animated:YES];
    [self.pickerTarget selectRow:[indexTarget intValue] inComponent:1 animated:YES];
    
    NSString* inputMoney = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDeafultInputMoney];
    if( (inputMoney != nil) &&  ([inputMoney isEqualToString:@""] == NO) )
    {
        self.textFieldInputSource.text = inputMoney;
    }
    
}

-(void)defineRateAndCountry
{
    NSDictionary* dictionaryCountry = @{@"Afghanistan Afghani": @"AFA",
                              @"Albanian Lek": @"ALL",
                              @"Algerian Dinar": @"DZD",
                              @"Argentine Peso": @"ARS",
                              @"Aruba Florin": @"AWG",
                              @"Australian Dollar": @"AUD",
                              @"Bahamian Dollar": @"BSD",
                              @"Bahraini Dinar": @"BHD",
                              @"Bangladesh Taka": @"BDT",
                              @"Barbados Dollar": @"BBD",
                              @"Belize Dollar": @"BZD",
                              @"Bermuda Dollar": @"BMD",
                              @"Bhutan Ngultrum": @"BTN",
                              @"Bolivian Boliviano": @"BOB",
                              @"Botswana Pula": @"BWP",
                              @"Brazilian Real": @"BRL",
                              @"British Pound": @"GBP",
                              @"Brunei Dollar": @"BND",
                              @"Burundi Franc": @"BIF",
                              @"CFA Franc (BCEAO)": @"XOF",
                              @"CFA Franc (BEAC)": @"XAF",
                              @"Cambodia Riel": @"KHR",
                              @"Canadian Dollar": @"CAD",
                              @"Cape Verde Escudo": @"CVE",
                              @"Cayman Islands Dollar": @"KYD",
                              @"Chilean Peso": @"CLP",
                              @"Chinese Yuan": @"CNY",
                              @"Colombian Peso": @"COP",
                              @"Comoros Franc": @"KMF",
                              @"Costa Rica Colon": @"CRC",
                              @"Croatian Kuna": @"HRK",
                              @"Cuban Peso": @"CUP",
                              @"Cyprus Pound": @"CYP",
                              @"Czech Koruna": @"CZK",
                              @"Danish Krone": @"DKK",
                              @"Dijibouti Franc": @"DJF",
                              @"Dominican Peso": @"DOP",
                              @"East Caribbean Dollar": @"XCD",
                              @"Egyptian Pound": @"EGP",
                              @"El Salvador Colon": @"SVC",
                              @"Estonian Kroon": @"EEK",
                              @"Ethiopian Birr": @"ETB",
                              @"Euro": @"EUR",
                              @"Falkland Islands Pound": @"FKP",
                              @"Gambian Dalasi": @"GMD",
                              @"Ghanian Cedi": @"GHC",
                              @"Gibraltar Pound": @"GIP",
                              @"Gold Ounces": @"XAU",
                              @"Guatemala Quetzal": @"GTQ",
                              @"Guinea Franc": @"GNF",
                              @"Guyana Dollar": @"GYD",
                              @"Haiti Gourde": @"HTG",
                              @"Honduras Lempira": @"HNL",
                              @"Hong Kong Dollar": @"HKD",
                              @"Hungarian Forint": @"HUF",
                              @"Iceland Krona": @"ISK",
                              @"Indian Rupee": @"INR",
                              @"Indonesian Rupiah": @"IDR",
                              @"Iraqi Dinar": @"IQD",
                              @"Israeli Shekel": @"ILS",
                              @"Jamaican Dollar": @"JMD",
                              @"Japanese Yen": @"JPY",
                              @"Jordanian Dinar": @"JOD",
                              @"Kazakhstan Tenge": @"KZT",
                              @"Kenyan Shilling": @"KES",
                              @"Korean Won": @"KRW",
                              @"Kuwaiti Dinar": @"KWD",
                              @"Lao Kip": @"LAK",
                              @"Latvian Lat": @"LVL",
                              @"Lebanese Pound": @"LBP",
                              @"Lesotho Loti": @"LSL",
                              @"Liberian Dollar": @"LRD",
                              @"Libyan Dinar": @"LYD",
                              @"Lithuanian Lita": @"LTL",
                              @"Macau Pataca": @"MOP",
                              @"Macedonian Denar": @"MKD",
                              @"Malagasy Franc": @"MGF",
                              @"Malawi Kwacha": @"MWK",
                              @"Malaysian Ringgit": @"MYR",
                              @"Maldives Rufiyaa": @"MVR",
                              @"Maltese Lira": @"MTL",
                              @"Mauritania Ougulya": @"MRO",
                              @"Mauritius Rupee": @"MUR",
                              @"Mexican Peso": @"MXN",
                              @"Moldovan Leu": @"MDL",
                              @"Mongolian Tugrik": @"MNT",
                              @"Moroccan Dirham": @"MAD",
                              @"Mozambique Metical": @"MZM",
                              @"Myanmar Kyat": @"MMK",
                              @"Namibian Dollar": @"NAD",
                              @"Nepalese Rupee": @"NPR",
                              @"Neth Antilles Guilder": @"ANG",
                              @"New Zealand Dollar": @"NZD",
                              @"Nicaragua Cordoba": @"NIO",
                              @"Nigerian Naira": @"NGN",
                              @"North Korean Won": @"KPW",
                              @"Norwegian Krone": @"NOK",
                              @"Omani Rial": @"OMR",
                              @"Pacific Franc": @"XPF",
                              @"Pakistani Rupee": @"PKR",
                              @"Palladium Ounces": @"XPD",
                              @"Panama Balboa": @"PAB",
                              @"Papua New Guinea Kina": @"PGK",
                              @"Paraguayan Guarani": @"PYG",
                              @"Peruvian Nuevo Sol": @"PEN",
                              @"Philippine Peso": @"PHP",
                              @"Platinum Ounces": @"XPT",
                              @"Polish Zloty": @"PLN",
                              @"Qatar Rial": @"QAR",
                              @"Romanian Leu": @"ROL",
                              @"Russian Rouble": @"RUB",
                              @"Samoa Tala": @"WST",
                              @"Sao Tome Dobra": @"STD",
                              @"Saudi Arabian Riyal": @"SAR",
                              @"Seychelles Rupee": @"SCR",
                              @"Sierra Leone Leone": @"SLL",
                              @"Silver Ounces": @"XAG",
                              @"Singapore Dollar": @"SGD",
                              @"Slovak Koruna": @"SKK",
                              @"Slovenian Tolar": @"SIT",
                              @"Solomon Islands Dollar": @"SBD",
                              @"Somali Shilling": @"SOS",
                              @"South African Rand": @"ZAR",
                              @"Sri Lanka Rupee": @"LKR",
                              @"St Helena Pound": @"SHP",
                              @"Sudanese Dinar": @"SDD",
                              @"Surinam Guilder": @"SRG",
                              @"Swaziland Lilageni": @"SZL",
                              @"Swedish Krona": @"SEK",
                              @"Turkey Lira": @"TRY",
                              @"Swiss Franc": @"CHF",
                              @"Syrian Pound": @"SYP",
                              @"Taiwan Dollar": @"TWD",
                              @"Tanzanian Shilling": @"TZS",
                              @"Thai Baht": @"THB",
                              @"Tonga Pa'anga": @"TOP",
                              @"Trinidad Tobago Dollar": @"TTD",
                              @"Tunisian Dinar": @"TND",
                              @"Turkish Lira": @"TRL",
                              @"U.S. Dollar": @"USD",
                              @"UAE Dirham": @"AED",
                              @"Ugandan Shilling": @"UGX",
                              @"Ukraine Hryvnia": @"UAH",
                              @"Uruguayan New Peso": @"UYU",
                              @"Vanuatu Vatu": @"VUV",
                              @"Venezuelan Bolivar": @"VEB",
                              @"Vietnam Dong": @"VND",
                              @"Yemen Riyal": @"YER",
                              @"Yugoslav Dinar": @"YUM",
                              @"Zambian Kwacha": @"ZMK",
                              @"Zimbabwe Dollar": @"ZWD"};
    
    NSLog(@"_dictionaryCountry COUNT : %ld", (long)dictionaryCountry.count);
    
    
    _arrayMoney = [dictionaryCountry allValues];
    _arrayMoney = [_arrayMoney sortedArrayUsingSelector:@selector(compare:)];
    
}

//--------------------------------------------------------------//
#pragma mark -- UIPickerView - DataSource --
//--------------------------------------------------------------//
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    long nCount = _arrayMoney.count;
	return nCount;
}

//--------------------------------------------------------------//
#pragma mark -- UIPickerView --
//--------------------------------------------------------------//
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat fWidth = self.pickerSource.frame.size.width;
    if(component == 0)
    {
        fWidth = 150;
    }
    else if(component == 1)
    {
        fWidth = 150;
    }
    
    return  fWidth;
}

//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString* stringColumn = nil;
//    if(component == 0)
//    {
////        stringColumn = [NSString stringWithFormat:@"%@", [self.familyNames objectAtIndex:row]];
//    }
//    else if(component == 1)
//    {
////        stringColumn = [NSString stringWithFormat:@"%@", [self.fontType objectAtIndex:row]];
//    }
//    
//    return stringColumn;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView*)view
{
    UILabel* fontlabel = (UILabel*)view;
    if (!fontlabel)
    {
        fontlabel =  [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ([pickerView rowSizeForComponent:component].width - 8.0f), [pickerView rowSizeForComponent:component].height)];
        fontlabel.adjustsFontSizeToFitWidth = YES;
        fontlabel.backgroundColor = [UIColor clearColor];
        

        
        fontlabel.text = _arrayMoney[row];
    }
    
    return fontlabel;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        NSNumber* indexSource = [NSNumber numberWithLong:row];
        [[NSUserDefaults standardUserDefaults] setObject:indexSource forKey:kUserDeafultSourceIndex];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    else if(component == 1)
    {
        NSNumber* indexTarget = [NSNumber numberWithLong:row];
        [[NSUserDefaults standardUserDefaults] setObject:indexTarget forKey:kUserDeafultTargetIndex];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    [self calculateStart:nil];
}

//--------------------------------------------------------------//
#pragma mark -- TextField Delegate --
//--------------------------------------------------------------//
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange rangeDecimal = [textField.text rangeOfString:@"."];
    if(rangeDecimal.location != NSNotFound)
    {
        if([string isEqualToString:@"."])
        {
            return NO;
        }
    }

    return  YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");

    NSString* inputMoney = textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:inputMoney forKey:kUserDeafultInputMoney];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

//--------------------------------------------------------------//
#pragma mark -- Calculte --
//--------------------------------------------------------------//
- (IBAction)calculateStart:(id)sender
{
    [self.textFieldInputSource resignFirstResponder];
    
    [self sendRequest];
}

-(void)sendRequest
{
    long nSelectedSourceIndex = [self.pickerSource selectedRowInComponent:0];
    long nSelectedTargetIndex = [self.pickerTarget selectedRowInComponent:1];

    NSString* sourceMoney = _arrayMoney[nSelectedSourceIndex];
    NSString* targetMoney = _arrayMoney[nSelectedTargetIndex];
    NSString* stringRequest = [NSString stringWithFormat:@"FromCurrency=%@&ToCurrency=%@", sourceMoney, targetMoney];

    NSLog(@"%@ -> %@", sourceMoney, targetMoney);
    
    // GET
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate"]];
    
    // POST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate"]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:3.0];

    NSMutableString* muStr = [NSMutableString stringWithCapacity:0];
    [muStr setString:stringRequest];
    NSData* postData = [muStr dataUsingEncoding:NSUTF8StringEncoding];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"www.webservicex.net" forHTTPHeaderField:@"Host"];
    [request setValue:[NSString stringWithFormat:@"%ld", (long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded"] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData   *response    = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *stringResult = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"stringResult %@", stringResult);
    
    if(stringResult && [stringResult length] > 0)
    {
        NSString* stringRate = @"";
        
        NSRange startRange = [stringResult rangeOfString:@"<double xmlns=\"http://www.webserviceX.NET/\">" options:NSCaseInsensitiveSearch];
        NSRange endRange = [stringResult rangeOfString:@"</double>" options:NSCaseInsensitiveSearch];
        if(startRange.location > 0 && startRange.length > 0 && endRange.location > 0 && endRange.length > 0)
        {
            long targetLength = endRange.location - (startRange.location + startRange.length);
            stringRate = [stringResult substringWithRange:NSMakeRange(startRange.location + startRange.length, targetLength)];
            NSLog(@"stringRate : %@", stringRate);
            
            _currentRate = [stringRate doubleValue];
        }
    }
    
    double changedRate = [self.textFieldInputSource.text doubleValue] * _currentRate;
    self.labelResult.text = [NSString stringWithFormat:@"%f", changedRate];
    
}

@end
