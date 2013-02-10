--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `pass`) VALUES
(1, 'Daniel', 'Wojciechowski', 'admin@admin.com', '407a9214f5d933864a9c788d7f2cc5e677502893');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `words`
--

CREATE TABLE IF NOT EXISTS `words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `relation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Zrzut danych tabeli `words`
--

INSERT INTO `words` (`id`, `word`, `description`, `relation`, `slug`) VALUES
(1, 'Kręgosłup', 'Kręgosłup (łac. Columna vertebralis) - część układu kostnego, stanowiąca jego główną oś i podporę. Kręgosłup u \r\n\r\nzwierząt nie posiadających ogona, w tym człowieka zbudowany jest z 33-34 kręgów, rozciągających się od głowy do kości ogonowej.', '1,3,25,', 'kregoslup'),
(3, 'Rower', 'Rower – pojazd napędzany siłą mięśni osoby nim kierującej za pomocą przekładni mechanicznej, wprawianej w ruch (najczęściej) nogami.\r\n\r\nPierwotnie nosił nazwę welocyped oraz bicykl i podobnie nazywany jest w większości nowożytnych języków europejskich. Obecna polska nazwa pochodzi od brytyjskiej firmy Rover, która dawniej produkowała rowery.', ',', 'rower'),
(4, 'Donald Tusk', 'Donald Franciszek Tusk (ur. 22 kwietnia 1957 w Gdańsku) – polski polityk, od 2007 prezes Rady Ministrów.\r\n\r\n\r\nZ wykształcenia historyk. Współzałożyciel i od 2003 przewodniczący Platformy Obywatelskiej, w latach 2005–2006 przewodniczący klubu parlamentarnego tego ugrupowania. Wicemarszałek Senatu IV kadencji w latach 1997–2001, wicemarszałek Sejmu IV kadencji w latach 2001–2005, senator IV kadencji, poseł na Sejm I, IV, V, VI i VII kadencji. W 2005 kandydat na urząd Prezydenta RP. Jest osobą najdłużej sprawującą urząd premiera w III RP.', ',', 'donald-tusk'),
(5, 'Kakao', 'Kakao (nah. cacauatl – ziarno kakaowe) – nasiona z owoców kakaowca, z których proszek stosowany jest jako składnik wielu wyrobów cukierniczych: tabliczek czekolady, napojów, polew, wiórków czekoladowych, mas czekoladowych, cukierków.', ',', 'kakao'),
(6, 'Malibu', 'Malibu to przyrządzany na bazie karaibskiego rumu likier kokosowy o objętościowej zawartości alkoholu 21,0%. Malibu jest międzynarodową marką dostępną w ponad 150 krajach świata, a jej właścicielem jest francuska kompania Pernod Ricard . W Polsce Malibu zajmuje pozycję lidera w segmencie likierów Premium.', '11,', 'malibu'),
(7, 'Księżyc', 'Księżyc (łac. Luna, gr. Σελήνη Selḗnē w dawnej polszczyźnie oraz niekiedy we współczesnych utworach literackich Miesiąc) – jedyny naturalny satelita Ziemi (nie licząc tzw. księżyców Kordylewskiego, które są obiektami pyłowymi i przez niektórych badaczy uważane za obiekty przejściowe). Jest piątym co do wielkości księżycem w Układzie Słonecznym. Przeciętna odległość od środka Ziemi do środka Księżyca to 384 403 km, co stanowi mniej więcej trzydziestokrotność średnicy ziemskiej. Średnica Księżyca wynosi 3474 km[1], nieco więcej niż 1/4 średnicy Ziemi. Oznacza to, że objętość Księżyca wynosi około 1/50 objętości kuli ziemskiej. Przyspieszenie grawitacyjne na jego powierzchni jest blisko 6 razy słabsze niż na Ziemi. Księżyc wykonuje pełny obieg wokół Ziemi w ciągu 27,3 dnia (tzw. miesiąc syderyczny), a okresowe zmiany w geometrii układu Ziemia-Księżyc-Słońce powodują występowanie powtarzających się w cyklu 29,5-dniowym (tzw. miesiąc synodyczny) faz Księżyca.', '3,', 'ksiezyc'),
(8, 'Pies domowy', 'Pies domowy – udomowiona forma wilka szarego, ssaka drapieżnego z rodziny psowatych (Canidae), uznana przez niektórych za podgatunek wilka, a przez niektórych za odrębny gatunek[potrzebne źródło] opisywany pod synonimicznymi nazwami Canis lupus familiaris lub Canis familiaris. Od czasu jego udomowienia powstało wiele ras znacznie różniących się morfologią i cechami użytkowymi. Rasy pierwotne powstawały głównie w wyniku presji środowiskowej, a rasy współczesne uzyskano w wyniku doboru sztucznego.', '5,', 'pies-domowy'),
(9, 'Szyba', 'Szyba – płaska tafla szkła, umieszczana w oknie.', ',', 'szyba'),
(10, 'Piłka', 'Piłka to kulisty przedmiot najczęściej używany w sportach i grach. Piłki są zwykle kuliste, lecz mogą mieć inny kształt, na przykład elipsoidy obrotowej. Większość piłek jest elastyczna, a w środku wypełniona powietrzem. Sportowcy kopią piłkę nogami, odbijają rękami, głową czy tułowiem. W większości gier zespołowych piłka jest przekazywana między członkami drużyny w celu umieszczenia jej w bramce, koszu czy też na polu przeciwnika. Niektóre piłki są sztywne i sprężyste, co pozwala im na odbijanie się od twardych powierzchni stołów czy rakietek. Inne piłki są wypełnione sprężonym powietrzem, co pozwala na uderzanie w nie z dużą siłą bez ryzyka urazu i posyłanie ich na duże odległości. Tak kopnięta czy odbita piłka kreśli często w powietrzu złożone trajektorie, bo zawodnicy starają się ją podkręcić. Zadanie piłce celnego uderzenia tak, aby zmylić przeciwnika jest podstawą sukcesu w wielu grach.', ',', 'pilka'),
(11, 'Wino', 'Wino – napój alkoholowy uzyskiwany w wyniku fermentacji moszczu z winogron, która w tym przypadku jest nazywana procesem winifikacji. Proces ten jest bardzo skomplikowany i ulega modyfikacjom w zależności od producenta i rodzaju wina.\r\n\r\nIstnieją setki odmian, smaków i rodzajów wina. Jego smak oraz bukiet zapachowy zależy od rodzaju szczepów winogron, sposobu ich uprawy, klimatu i ziemi, na której się je uprawia oraz od sposobu winifikacji.', ',', 'wino');