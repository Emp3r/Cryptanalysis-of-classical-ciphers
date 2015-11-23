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
            "Tehdejsi cisar Rudolf II. roku 1575 cele panstvi daroval Adamovi z Ditrichstejna v majetku jeho rodu zamek zustal az do roku 1945. Ditrichstejnove pokracovali v zapocate prestavbe, ktera vyvrcholila za kardinala Frantiska z Ditrichstejna. Ten na zamek premistil svou kancelar i cely svuj dvur z Olomouce a jeho prestavby vtiskly stavbe pozdne renesancni charakter. Velke prestavby se dockal severni bastion, na nemz byl vybudovan sal predku, ktery slouzil zaroven jako reprezentativni mistnost. Na stenach salu byli vyobrazeni zejmena zemreli clenove rodu Ditrichstejnu; na vyzdobe salu se podileli mnozi znami umelci, jako byl Jiri Gialdi, do soucasne doby se vsak z jednotlivych portretu dochovala jen torza. Rozsirena byla severni a jizni kridla obytnych budov, mezi zapadnim a vychodnim kridlem byla postavena visuta spojovaci chodba, ktera dnes de facto rozdeluje hlavni nadvori na dve casti. V tesne blizkosti hradu nechal Frantisek postavit budovu divadla, vinny sklep s rozsahlymi prostory a knihovnu citajici velke mnozstvi cennych svazku. Architektem techto prestaveb byl pravdepodobne italsky stavitel Giovanni Giacomo Tencalla. Planek hradu z pocatku 18. stoleti (ze sbirky F. F. von Nicolai) Nastupce Frantiska z Ditrichstejna Maxmilian nechal do sklepnich prostor umistit sud na vino, ktery pojal zhruba 1014 hektolitru vina, coz z nej cinilo nejobjemnejsi vinny sud stredni Evropy. Sud se dochoval dodnes a slouzi jako ukazka zrucnosti tehdejsich tesaru. V roce 1645 dobyla mikulovsky zamek svedska armada, ktera vyplenila zamek i mesto. Svedove vyloupili i zameckou knihovnu a vyznamnou cast jejich knih si odvezli s sebou do Svedska. Dalsi vyznamna rekonstrukce zamku probehla v druhe polovine 17. stoleti, kdy byla zamku na popud knizete Ferdinanda z Ditrichstejna vtisknuta barokni podoba. Knize Ferdinand nejdrive opravil zamek po svedskem rabovani a pote nechal na vychodni strane zamku postavit terasu s altanem. Na samem konci 17. stoleti jeste nechal vybudovat konirny. Obe stavby vsak byly v 19. stoleti zboreny. Dulezity okamzik pro historii zamku i Mikulova nastal v roce 1719. Mikulov tehdy zachvatil pozar, ktery sezehl mesto a do zakladu vyhorel i zamek. Ditrichstejnove se vsak rozhodli zamek znovu vystavet. Valcova vez s polygonni kapli a cibulovitou strechou, ktera se nachazi nad skalnim pruchodem k cestnemu nadvori. Pri prestavbe doslo ke sjednoceni vyskovych rozdilu jednotlivych podlazi a navic byly pristaveny budovy jizdaren a do zamku nebo jeho okoli byly umisteny umelecke predmety, jako napriklad kamenne sochy podel prijezdove cesty k zamku ci kovana brana do zamecke zahrady. Hlavnim architektem cele prestavby byl G. A. Oedtl. V roce 1805 si prostory mikulovskeho zamku vybral Napoleon Bonaparte pro vyjednani o mirovych smlouvach mezi Francouzskym a Rakouskym cisarstvim. 26. cervence 1866, po porazce rakouskych vojsk v bitve u Sadove, bylo na zamku podepsano primeri mezi Rakouskem a Pruskem, ktere je zname jako Mikulovske primeri. V 19. stoleti doslo k dalsim, avsak jen malym stavebnim upravam zamku. Povalecne obdobi a soucasnost[editovat | editovat zdroj] Stavebni a architektonicky vyvoj zamku tragicky poznamenal konec druhe svetove valky. 22. dubna roku 1945 v ramci osvobozeneckych boju zamek opet vyhorel, dosud nejsou znamy presne okolnosti vzniku pozaru. Jiz o dva roky pozdeji vsak vznikl Spolek pro obnovu mikulovskeho zamku, ktery se zasadnim zpusobem zaslouzil o nove vystaveni zameckeho komplexu. Autorem soucasne podoby zamku je brnensky architekt Otakar Oplatek. V soucasne dobe zamek spravuje Regionalni muzeum v Mikulove. V roce 2006 podala knezna Mercedes Ditrichstejnova, ktera zije v Argentine, zalobu u okresniho soudu v Breclavi, v niz pozaduje vydani zamku. V srpnu roku 2008 rozsirila svuj pozadavek i na dalsi mikulovske nemovitosti. V kvetnu 2010 breclavsky soud jeji pozadavky zamitl. V srpnu 2007 byla diky destivemu pocasi odhalena jeskyne, ktera se nachazi pod nadvorim zamku. V roce 2005 se v zameckem parku poradala inscenace obsazeni zamku Napoleonovou armadou. Zamek dnes slouzi i jako muzeum a vyjimecne take jako hotel. Porada se zde rada kulturnich akci, kazdorocne se tez stava jednim z dejist palavskeho vinobrani.",
            "The fear was that several individuals with arms and explosives could launch an attack, perhaps even in several places, Mr Michel said. Some of the attackers who killed 130 people in Paris lived in Brussels. Leading suspect Salah Abdeslam is believed to have gone back to Belgium. He is now the focus of a huge manhunt. The Brussels metro is closed till Sunday and people have been told to avoid crowds. These include shopping centres and concerts, and the authorities have also recommended that large events, including football matches, be cancelled, a statement said. The warning for the rest of Belgium stays at a lower level, which is still at a serious level. The Belgian government will review the security situation in Brussels on Sunday afternoon, Mr Michel added. We are closed, exceptional circumstances says a sign posted in a shop inside Brussels' Gare du Midi train station. Be safe. Armed police officers patrol the station's main concourse. One squad check passengers' bags. Two officers escort away a drunk man who has come in search of cigarettes. At 12:08, the Eurostar from London arrives. At the gate, a young woman is embraced by her mother who smiles and says she will take her daughter home as quickly as possible in order to stay safe. Passengers also include a group of British men on a stag weekend. They say they did not want to cancel their plans. They head boisterously out into the city. Along one of the city's main shopping streets, shops are open. Rows of security guards stand at the front doors. I write these words from a table in a half empty fast-food restaurant. Two well armed soldiers in camouflage uniform are standing a metre away from me just inside the front door. Interior Minister Jan Jambon earlier told reporters the country's situation was serious, but under control, as he arrived for a special security cabinet meeting on Saturday. A Belgian man of Moroccan descent, Ahmad Dahmani, has been arrested at a luxury hotel in Antalya along with two other terror suspects, Turkish authorities have told the BBC. He is believed to have been in contact with the suspects who perpetrated the Paris attacks, an official said. He arrived from Amsterdam on 14 November; there is no record of the Belgian authorities having warned Turkey about him, which is why there was no entry ban, the official said. The Belgian authorities have so far charged three people with involvement in the attacks, claimed by Islamic State militants. In Paris, French police have freed seven people arrested during the massive raid on an apartment housing the suspected ringleader, Abdelhamid Abaaoud, prosecutors said according to AFP news agency. Abdelhamid Abaaoud was killed in the raid in the Paris suburb of Saint-Denis. However, Jawad Bendaoud - who has admitted lending the apartment to two people from Belgium as a favour, but denied knowing any more - is being held in custody. Earlier, the UN Security Council adopted a resolution to redouble action against Islamic State following last week's deadly attacks in the French capital. The French-drafted document urges UN members to take all necessary measures in the fight against IS, which said it carried out the attacks. France is still hunting Salah Abdeslam, who hired one of the cars used in the attacks. French media have reported that nine militants carried out the attacks, and seven died on Friday night. So it is possible that another attacker - as well as Salah Abdeslam - is still at large. Investigators suspect the gunmen used safe houses in Saint-Denis, Bobigny and Alfortville in the Paris region. But it is not clear when the group met up to launch the attacks. Other elements of the plot also remain unclear. Investigators will be studying phone records and assessing the weapons seized for further clues. Hundreds of people were wounded in the near-simultaneous attacks on Paris bars and restaurants, a concert hall and sports stadium. IS is a notoriously violent Islamist group which controls large parts of Syria and Iraq. It has declared its territory a caliphate - a state governed in accordance with Islamic law - under its leader Abu Bakr al-Baghdadi. IS demands allegiance from all Muslims, rejects national borders and seeks to expand its territory. It follows its own extreme version of Sunni Islam and regards non-believers as deserving of death. IS projects a powerful image, partly through propaganda and sheer brutality, and is the world's richest insurgent group. It has about 30,000 fighters but is facing daily bombing by a US-led multi-national coalition, which has vowed to destroy it. If you are happy to be contacted by a BBC journalist please leave a telephone number that we can contact you on. In some cases a selection of your comments will be published, displaying your name as you provide it and location, unless you state otherwise. Your contact details will never be published. When sending us pictures, video or eyewitness accounts at no time should you endanger yourself or others, take any unnecessary risks or infringe any laws. Please ensure you have read the terms and conditions."
        ]
    
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
        print("chars: \(texts[6].characters.count)")
        //TranspositionCrack.findingWordKeyGuess(Transposition.encrypt(texts[6], with: "caebd"));

        
        //if TranspositionCrack.hasSameChars("abcdef", and: "ebcdaf") {
            //print(Transposition.getTextParts("abcdefghijklmnopqrstuvwxy", with: 3))
        //}
        
        
        
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

