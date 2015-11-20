import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        initializeApplicationDefaults()
        
        
        // TESTS:
        let texts = ["Nejjednodussi je vytvorit si online profesni profil na Jobs.cz. System vas provede vsemi dulezitymi kroky, takze na nic podstatneho nezapomenete. CV si pote muzete ulozit, vytisknout nebo prilozit k odpovedi na pozici. Pokud profil zpristupnite 23 tisicum zamestnavatelu z nasi databaze (staci na to jeden klik), umoznite jim oslovit vas s nabidkou naprimo.",
            "Pruvodnim dopisem sdelujete, proc jste prave vy tim vhodnym clovekem, ktereho by firma mela prijmout.",
            "Na pohovoru ale nesmeji padnout diskriminacni otazky.",
            "Zivotopisem, motivacnim dopisem a pohovorem prijimaci rizeni do firmy nekonci. V posledni dobe se prosazuji dalsi metody naboru, napriklad psychometricke testy nebo videodotazniky.",
            "Nejjednodussi je vytvorit si online profesni profil na Jobs.cz. System vas provede vsemi dulezitymi kroky, takze na nic podstatneho nezapomenete. CV si pote muzete ulozit, vytisknout nebo prilozit k odpovedi na pozici. Pokud profil zpristupnite 23 tisicum zamestnavatelu z nasi databaze (staci na to jeden klik), umoznite jim oslovit vas s nabidkou naprimo. Pruvodnim dopisem sdelujete, proc jste prave vy tim vhodnym clovekem, ktereho by firma mela prijmout. Na pohovoru ale nesmeji padnout diskriminacni otazky. Zivotopisem, motivacnim dopisem a pohovorem prijimaci rizeni do firmy nekonci. V posledni dobe se prosazuji dalsi metody naboru, napriklad psychometricke testy nebo videodotazniky.",
            "Tehdejsi cisar Rudolf II. roku 1575 cele panstvi daroval Adamovi z Ditrichstejna v majetku jeho rodu zamek zustal az do roku 1945. Ditrichstejnove pokracovali v zapocate prestavbe, ktera vyvrcholila za kardinala Frantiska z Ditrichstejna. Ten na zamek premistil svou kancelar i cely svuj dvur z Olomouce a jeho prestavby vtiskly stavbe pozdne renesancni charakter. Velke prestavby se dockal severni bastion, na nemz byl vybudovan sal predku, ktery slouzil zaroven jako reprezentativni mistnost. Na stenach salu byli vyobrazeni zejmena zemreli clenove rodu Ditrichstejnu; na vyzdobe salu se podileli mnozi znami umelci, jako byl Jiri Gialdi, do soucasne doby se vsak z jednotlivych portretu dochovala jen torza. Rozsirena byla severni a jizni kridla obytnych budov, mezi zapadnim a vychodnim kridlem byla postavena visuta spojovaci chodba, ktera dnes de facto rozdeluje hlavni nadvori na dve casti. V tesne blizkosti hradu nechal Frantisek postavit budovu divadla, vinny sklep s rozsahlymi prostory a knihovnu citajici velke mnozstvi cennych svazku. Architektem techto prestaveb byl pravdepodobne italsky stavitel Giovanni Giacomo Tencalla. Planek hradu z pocatku 18. stoleti (ze sbirky F. F. von Nicolai) Nastupce Frantiska z Ditrichstejna Maxmilian nechal do sklepnich prostor umistit sud na vino, ktery pojal zhruba 1014 hektolitru vina, coz z nej cinilo nejobjemnejsi vinny sud stredni Evropy. Sud se dochoval dodnes a slouzi jako ukazka zrucnosti tehdejsich tesaru. V roce 1645 dobyla mikulovsky zamek svedska armada, ktera vyplenila zamek i mesto. Svedove vyloupili i zameckou knihovnu a vyznamnou cast jejich knih si odvezli s sebou do Svedska. Dalsi vyznamna rekonstrukce zamku probehla v druhe polovine 17. stoleti, kdy byla zamku na popud knizete Ferdinanda z Ditrichstejna vtisknuta barokni podoba. Knize Ferdinand nejdrive opravil zamek po svedskem rabovani a pote nechal na vychodni strane zamku postavit terasu s altanem. Na samem konci 17. stoleti jeste nechal vybudovat konirny. Obe stavby vsak byly v 19. stoleti zboreny. Dulezity okamzik pro historii zamku i Mikulova nastal v roce 1719. Mikulov tehdy zachvatil pozar, ktery sezehl mesto a do zakladu vyhorel i zamek. Ditrichstejnove se vsak rozhodli zamek znovu vystavet. Valcova vez s polygonni kapli a cibulovitou strechou, ktera se nachazi nad skalnim pruchodem k cestnemu nadvori. Pri prestavbe doslo ke sjednoceni vyskovych rozdilu jednotlivych podlazi a navic byly pristaveny budovy jizdaren a do zamku nebo jeho okoli byly umisteny umelecke predmety, jako napriklad kamenne sochy podel prijezdove cesty k zamku ci kovana brana do zamecke zahrady. Hlavnim architektem cele prestavby byl G. A. Oedtl. V roce 1805 si prostory mikulovskeho zamku vybral Napoleon Bonaparte pro vyjednani o mirovych smlouvach mezi Francouzskym a Rakouskym cisarstvim. 26. cervence 1866, po porazce rakouskych vojsk v bitve u Sadove, bylo na zamku podepsano primeri mezi Rakouskem a Pruskem, ktere je zname jako Mikulovske primeri. V 19. stoleti doslo k dalsim, avsak jen malym stavebnim upravam zamku. Povalecne obdobi a soucasnost[editovat | editovat zdroj] Stavebni a architektonicky vyvoj zamku tragicky poznamenal konec druhe svetove valky. 22. dubna roku 1945 v ramci osvobozeneckych boju zamek opet vyhorel, dosud nejsou znamy presne okolnosti vzniku pozaru. Jiz o dva roky pozdeji vsak vznikl Spolek pro obnovu mikulovskeho zamku, ktery se zasadnim zpusobem zaslouzil o nove vystaveni zameckeho komplexu. Autorem soucasne podoby zamku je brnensky architekt Otakar Oplatek. V soucasne dobe zamek spravuje Regionalni muzeum v Mikulove. V roce 2006 podala knezna Mercedes Ditrichstejnova, ktera zije v Argentine, zalobu u okresniho soudu v Breclavi, v niz pozaduje vydani zamku. V srpnu roku 2008 rozsirila svuj pozadavek i na dalsi mikulovske nemovitosti. V kvetnu 2010 breclavsky soud jeji pozadavky zamitl. V srpnu 2007 byla diky destivemu pocasi odhalena jeskyne, ktera se nachazi pod nadvorim zamku. V roce 2005 se v zameckem parku poradala inscenace obsazeni zamku Napoleonovou armadou. Zamek dnes slouzi i jako muzeum a vyjimecne take jako hotel. Porada se zde rada kulturnich akci, kazdorocne se tez stava jednim z dejist palavskeho vinobrani."]
    
        /*
        
        var caesarTests = [String]()
        var vigenereTests = [String]()
        //var monoalphabeticTests = [String]()
        var transpositionTests = [String]()
        
        let caesarKey = Caesar.generateRandomKey()
        let vigenereKey = Vigenere.generateRandomKey()
        print("> Caesar: \(caesarKey),  Vigenere: \(vigenereKey)")
        
        for i in 0...texts.count-1 {
            print("  \(i):   ")
            
            caesarTests.append(Caesar.encrypt(texts[i], with: caesarKey))
            vigenereTests.append(Vigenere.encrypt(texts[i], with:vigenereKey))
            // monoalphabeticTests.append(Monoalphabetic.encrypt(texts[i], with: "abcdefghijklmnopqrstuvwxyz"))
            transpositionTests.append(Transposition.encrypt(texts[i], with: "caebd"))
            
            
            print("caesar \(caesarTests[i].characters.count) ... FA:\(CaesarCrack.frequencyAnalysisKeyGuess(caesarTests[i])), RW:\(CaesarCrack.realWordsAnalysisKeyGuess(caesarTests[i])), MD:\(CaesarCrack.lettersDistanceKeyGuess(caesarTests[i]))")
            
            print("vigenere \(vigenereTests[i].characters.count) ... key length: \(VigenereCrack.guessKeyLength(vigenereTests[i])), FA:\(VigenereCrack.frequencyAnalysisKeyGuess(vigenereTests[i])), MD:\(VigenereCrack.lettersDistanceKeyGuess(vigenereTests[i]))")
            
            print("transposition \(transpositionTests[i].characters.count) ... RW:\(TranspositionCrack.realWordsAnalysisKeyGuess(transpositionTests[i]))")
            
        }
        */




        
        
        // print(Language.expectedFrequency())
        // print(Utils.frequencyDictionary(Language.expectedFrequency()))
        // print(Utils.frequencyDictionary(Utils.lettersFrequency(texts[5])))
        // print("most: \(CaesarCrack.mostUsedChars(Language.expectedFrequency(), size: 7))")
        // print("least \(CaesarCrack.leastUsedChars(Language.expectedFrequency(), size: 7))")
        //
        /*
        let letters:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        for i in letters {
            print(CaesarCrack.lettersDistanceKeyGuess(Caesar.encrypt(texts[0], with:i)))
            print(CaesarCrack.lettersDistanceKeyGuess(Caesar.encrypt(texts[3], with:i)))
            print(CaesarCrack.lettersDistanceKeyGuess(Caesar.encrypt(texts[5], with:i)))
        }
        */
        
        
        
        
        
        //
        
        return true
    }
    
    
    
    func initializeApplicationDefaults() {
        window?.tintColor = UIColor.redColor()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // set language statistics
        if let lang = userDefaults.stringForKey("language") {
            Language.setLanguage(lang)
        }
        else {
            let defaultLang = "English"
            Language.setLanguage(defaultLang)
            userDefaults.setObject(defaultLang, forKey: "language")        }
        
        // set chosen cipher (index)
        if userDefaults.objectForKey("cipher") == nil {
            userDefaults.setInteger(1, forKey: "cipher")    // 1 for Vigenere
            userDefaults.setInteger(0, forKey: "attack")
        }
        
        userDefaults.synchronize()
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

