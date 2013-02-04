CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin2 AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `email`, `pass`) VALUES
(1, 'admin@admin.com', '625b5ff20cb3b0fc0c18552ecd57dd441bb488fc');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `words`
--

CREATE TABLE IF NOT EXISTS `words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `relation` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin2 AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `words`
--

INSERT INTO `words` (`id`, `word`, `description`, `relation`, `slug`) VALUES
(1, 'Kręgosłup', 'Kręgosłup (łac. Columna vertebralis) - część układu kostnego, stanowiąca jego główną oś i podporę. Kręgosłup u zwierząt nie posiadających ogona, w tym człowieka zbudowany jest z 33-34 kręgów, rozciągających się od głowy do kości ogonowej.', '1,2,3,25', 'kregoslup');