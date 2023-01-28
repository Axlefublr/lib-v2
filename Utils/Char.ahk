﻿;No dependencies

/**
 * Get the hex value of a unicode character using its predefined name
 * @param name *String* The predefined name of the unicode character
 * @returns {Integer}
 */
GetUnicode(name) {

    static Unicodes := Map(

        "pleading",                 0x1F97A,
        "yum",                      0x1F60B,
        "exploding head",           0x1F92F,
        "smirk cat",                0x1F63C,
        "sunglasses",               0x1F60E,
        "sob",                      0x1F62D,
        "face with monocle",        0x1F9D0,
        "flushed",                  0x1F633,
        "face with raised eyebrow", 0x1F928,
        "purple heart",             0x1F49C,
        "skull",                    0x1F480,
        "rolling eyes",             0x1F644,
        "thinking",                 0x1F914,
        "weary",                    0x1F629,
        "woozy",                    0x1F974,
        "finger left",              0x1F448,
        "finger right",             0x1F449,
        "drooling",                 0x1F924,
        "eggplant",                 0x1F346,
        "smiling imp",              0x1F608,
        "fearful",                  0x1F628,
        "middle dot",               0x00B7,
        "discord escape",           0x001B,
        "long dash",                0x2014,
        "sun",                      0x2600,
        "cloud",                    0x2601,
        "nerd",                     0x1F913,
        "handshake",                0x1F91D,
        "shrug",                    0x1F937,
        "clap",                     0x1F44F,
        "amogus",                   0x0D9E,

    )

    return Unicodes[name]
}

/**
 * Sends a unicode character using the Send function by using the character's predefined name
 * @param name *String* The predefined name of the character
 * @param endingChar *String* The string to append to the character. For example, a space or a newline
 */
Symbol(name, endingChar := "") {
    if Type(name) = "Array" {
        symbols := ""
        for key, value in name 
            symbols .= Chr(GetUnicode(value))
    } else
        symbols := Chr(GetUnicode(name))

    Send(symbols endingChar)
}

/**
 * Returns a random word out of the 1000 most used words out of two languages: English and Russian
 * @param language *String*
 * @returns {String}
 */
GetRandomWord(language) {

    static English := [
        "the", "be", "and", "a", "of", "to", "in", "i", "you", "it", "have", "to", "that", "for", "do", "he", "with", "on", "this", "trust", "we", "that", "not", "but", "they", "say", "at", "what", "his", "from", "go", "or", "by", "get", "she", "my", "can", "as", "know", "if", "me", "your", "all", "who", "about", "their", "will", "so", "would", "make", "just", "up", "think", "time", "there", "see", "her", "as", "out", "one", "come", "people", "take", "year", "him", "them", "some", "want", "how", "when", "which", "now", "like", "other", "could", "our", "into", "here", "then", "than", "look", "way", "more", "these", "no", "thing", "well", "because", "also", "two", "use", "tell", "good", "first", "man", "day", "find", "give", "more", "new", "one", "us", "any", "those", "very", "her", "need", "back", "there", "should", "even", "only", "many", "really", "work", "life", "why", "right", "down", "on", "try", "let", "something", "too", "call", "woman", "may", "still", "through", "mean", "after", "never", "no", "world", "in", "feel", "yeah", "great", "last", "child", "oh", "over", "ask", "when", "as", "school", "state", "much", "talk", "out", "keep", "leave", "put", "like", "help", "big", "where", "same", "all", "own", "while", "start", "three", "high", "every", "another", "become", "most", "between", "happen", "family", "over", "president", "old", "yes", "house", "show", "again", "student", "so", "seem", "might", "part", "hear", "its", "place", "problem", "where", "believe", "country", "always", "week", "point", "hand", "off", "play", "turn", "few", "group", "such", "against", "run", "guy", "about", "case", "question", "work", "night", "live", "game", "number", "write", "bring", "without", "money", "lot", "most", "book", "system", "government", "next", "city", "company", "story", "today", "job", "move", "must", "bad", "friend", "during", "begin", "love", "each", "hold", "different", "american", "little", "before", "ever", "word", "fact", "right", "read", "anything", "nothing", "sure", "small", "month", "program", "maybe", "right", "under", "business", "home", "kind", "stop", "pay", "study", "since", "issue", "name", "idea", "room", "percent", "far", "away", "law", "actually", "large", "though", "provide", "lose", "power", "kid", "war", "understand", "head", "mother", "real", "best", "team", "eye", "long", "long", "side", "water", "young", "wait", "okay", "both", "yet", "after", "meet", "service", "area", "important", "person", "hey", "thank", "much", "someone", "end", "change", "however", "only", "around", "hour", "everything", "national", "four", "line", "girl", "around", "watch", "until", "father", "sit", "create", "information", "car", "learn", "least", "already", "kill", "minute", "party", "include", "stand", "together", "back", "follow", "health", "remember", "often", "reason", "speak", "ago", "set", "black", "member", "community", "once", "social", "news", "allow", "win", "body", "lead", "continue", "whether", "enough", "spend", "level", "able", "political", "almost", "boy", "university", "before", "stay", "add", "later", "change", "five", "probably", "center", "among", "face", "public", "die", "food", "else", "history", "buy", "result", "morning", "off", "parent", "office", "course", "send", "research", "walk", "door", "white", "several", "court", "home", "grow", "better", "open", "moment", "including", "consider", "both", "such", "little", "within", "second", "late", "street", "free", "better", "everyone", "policy", "table", "sorry", "care", "low", "human", "please", "hope", "true", "process", "teacher", "data", "offer", "death", "whole", "experience", "plan", "easy", "education", "build", "expect", "fall", "himself", "age", "hard", "sense", "across", "show", "early", "college", "music", "appear", "mind", "class", "police", "use", "effect", "season", "tax", "heart", "son", "art", "possible", "serve", "break", "although", "end", "market", "even", "air", "force", "require", "foot", "up", "listen", "agree", "according", "anyone", "baby", "wrong", "love", "cut", "decide", "republican", "full", "behind", "pass", "interest", "sometimes", "security", "eat", "report", "control", "rate", "local", "suggest", "report", "nation", "sell", "action", "support", "wife", "decision", "receive", "value", "base", "pick", "phone", "thanks", "event", "drive", "strong", "reach", "remain", "explain", "site", "hit", "pull", "church", "model", "perhaps", "relationship", "six", "fine", "movie", "field", "raise", "less", "player", "couple", "million", "themselves", "record", "especially", "difference", "light", "development", "federal", "former", "role", "pretty", "myself", "view", "price", "effort", "nice", "quite", "along", "voice", "finally", "department", "either", "toward", "leader", "because", "photo", "wear", "space", "project", "return", "position", "special", "million", "film", "need", "major", "type", "town", "article", "road", "form", "chance", "drug", "economic", "situation", "choose", "practice", "cause", "happy", "science", "join", "teach", "early", "develop", "share", "yourself", "carry", "clear", "brother", "matter", "dead", "image", "star", "cost", "simply", "post", "society", "picture", "piece", "paper", "energy", "personal", "building", "military", "open", "doctor", "activity", "exactly", "american", "media", "miss", "evidence", "product", "realize", "save", "arm", "technology", "catch", "comment", "look", "term", "color", "cover", "describe", "guess", "choice", "source", "mom", "soon", "director", "international", "rule", "campaign", "ground", "election", "face", "uh", "check", "page", "fight", "itself", "test", "patient", "produce", "certain", "whatever", "half", "video", "support", "throw", "third", "care", "rest", "recent", "available", "step", "ready", "opportunity", "official", "oil", "call", "organization", "character", "single", "current", "likely", "county", "future", "dad", "whose", "less", "shoot", "industry", "second", "list", "general", "stuff", "figure", "attention", "forget", "risk", "no", "focus", "short", "fire", "dog", "red", "hair", "point", "condition", "wall", "daughter", "before", "deal", "author", "truth", "upon", "husband", "period", "series", "order", "officer", "close", "land", "note", "computer", "thought", "economy", "goal", "bank", "behavior", "sound", "deal", "certainly", "nearly", "increase", "act", "north", "well", "blood", "culture", "medical", "ok", "everybody", "top", "difficult", "close", "language", "window", "response", "population", "lie", "tree", "park", "worker", "draw", "plan", "drop", "push", "earth", "cause", "per", "private", "tonight", "race", "than", "letter", "other", "gun", "simple", "course", "wonder", "involve", "hell", "poor", "each", "answer", "nature", "administration", "common", "no", "hard", "message", "song", "enjoy", "similar", "congress", "attack", "past", "hot", "seek", "amount", "analysis", "store", "defense", "bill", "like", "cell", "away", "performance", "hospital", "bed", "board", "protect", "century", "summer", "material", "individual", "recently", "example", "represent", "fill", "state", "place", "animal", "fail", "factor", "natural", "sir", "agency", "usually", "significant", "help", "ability", "mile", "statement", "entire", "democrat", "floor", "serious", "career", "dollar", "vote", "sex", "compare", "south", "forward", "subject", "financial", "identify", "beautiful", "decade", "bit", "reduce", "sister", "quality", "quickly", "act", "press", "worry", "accept", "enter", "mention", "sound", "thus", "plant", "movement", "scene", "section", "treatment", "wish", "benefit", "interesting", "west", "candidate", "approach", "determine", "resource", "claim", "answer", "prove", "sort", "enough", "size", "somebody", "knowledge", "rather", "hang", "sport", "tv", "loss", "argue", "left", "note", "meeting", "skill", "card", "feeling", "despite", "degree", "crime", "that", "sign", "occur", "imagine", "vote", "near", "king", "box", "present", "figure", "seven", "foreign", "laugh", "disease", "lady", "beyond", "discuss", "finish", "design", "concern", "ball", "east", "recognize", "apply", "prepare", "network", "huge", "success", "district", "cup", "name", "physical", "growth", "rise", "hi", "standard", "force", "sign", "fan", "theory", "staff", "hurt", "legal", "september", "set", "outside", "et", "strategy", "clearly", "property", "lay", "final", "authority", "perfect", "method", "region", "since", "impact", "indicate", "safe", "committee", "supposed", "dream", "training", "shit", "central", "option", "eight", "particularly", "completely", "opinion", "main", "ten", "interview", "exist", "remove", "dark", "play", "union", "professor", "pressure", "purpose", "stage", "blue", "herself", "sun", "pain", "artist", "employee", "avoid", "account", "release", "fund", "environment", "treat", "specific", "version", "shot", "hate", "reality", "visit", "club", "justice", "river", "brain", "memory", "rock", "talk", "camera", "global", "various", "arrive", "notice", "bit", "detail", "challenge", "argument", "lot", "nobody", "weapon", "best", "station", "island", "absolutely", "instead", "discussion", "instead", "affect", "design", "little", "anyway", "respond", "control", "trouble", "conversation", "manage", "close", "date", "public", "army", "top", "post", "charge", "seat"
    ]

    static Russian := [
        "и", "в", "не", "на", "я", "быть", "он", "с", "что", "а", "по", "это", "она", "этот", "к", "но", "они", "мы", "как", "из", "у", "который", "то", "за", "свой", "что", "весь", "год", "от", "так", "о", "для", "ты", "же", "все", "тот", "мочь", "вы", "человек", "такой", "его", "сказать", "только", "или", "ещё", "бы", "себя", "один", "как", "уже", "до", "время", "если", "сам", "когда", "другой", "вот", "говорить", "наш", "мой", "знать", "стать", "при", "чтобы", "дело", "жизнь", "кто", "первый", "очень", "два", "день", "её", "новый", "рука", "даже", "во", "со", "раз", "где", "там", "под", "можно", "ну", "какой", "после", "их", "работа", "без", "самый", "потом", "надо", "хотеть", "ли", "слово", "идти", "большой", "должен", "место", "иметь", "ничто", "то", "сейчас", "тут", "лицо", "каждый", "друг", "нет", "теперь", "ни", "глаз", "тоже", "тогда", "видеть", "вопрос", "через", "да", "здесь", "дом", "да", "потому", "сторона", "какой-то", "думать", "сделать", "страна", "жить", "чем", "мир", "об", "последний", "случай", "голова", "более", "делать", "что-то", "смотреть", "ребенок", "просто", "конечно", "сила", "российский", "конец", "перед", "несколько", "вид", "система", "всегда", "работать", "между", "три", "нет", "понять", "пойти", "часть", "спросить", "город", "дать", "также", "никто", "понимать", "получить", "отношение", "лишь", "второй", "именно", "ваш", "хотя", "ни", "сидеть", "над", "женщина", "оказаться", "русский", "один", "взять", "прийти", "являться", "деньги", "почему", "вдруг", "любить", "стоить", "почти", "земля", "общий", "ведь", "машина", "однако", "сразу", "хорошо", "вода", "отец", "высокий", "остаться", "выйти", "много", "проблема", "начать", "хороший", "час", "это", "сегодня", "право", "совсем", "нога", "считать", "главный", "решение", "увидеть", "дверь", "казаться", "образ", "писать", "история", "лучший", "власть", "закон", "все", "война", "бог", "голос", "найти", "поэтому", "стоять", "вообще", "тысяча", "больше", "вместе", "маленький", "книга", "некоторый", "решить", "любой", "возможность", "результат", "ночь", "стол", "никогда", "имя", "область", "молодой", "пройти", "например", "статья", "оно", "число", "компания", "про", "государственный", "полный", "принять", "народ", "никакой", "советский", "жена", "настоящий", "всякий", "группа", "развитие", "процесс", "суд", "давать", "ответить", "старый", "условие", "твой", "пока", "средство", "помнить", "начало", "ждать", "свет", "пора", "путь", "душа", "куда", "нужно", "разный", "нужный", "уровень", "иной", "форма", "связь", "уж", "минута", "кроме", "находиться", "опять", "многий", "белый", "собственный", "улица", "черный", "написать", "вечер", "снова", "основной", "качество", "мысль", "дорога", "мать", "действие", "месяц", "оставаться", "государство", "язык", "любовь", "взгляд", "мама", "играть", "далекий", "лежать", "нельзя", "век", "школа", "подумать", "уйти", "цель", "среди", "общество", "посмотреть", "деятельность", "организация", "кто-то", "вернуться", "президент", "комната", "порядок", "момент", "театр", "следовать", "читать", "письмо", "подобный", "следующий", "утро", "особенно", "помощь", "ситуация", "роль", "бывать", "ходить", "рубль", "начинать", "появиться", "смысл", "состояние", "называть", "рядом", "квартира", "назад", "равный", "из-за", "орган", "внимание", "тело", "труд", "прийтись", "хотеться", "сын", "мера", "пять", "смерть", "живой", "рынок", "программа", "задача", "предприятие", "известный", "окно", "вести", "совершенно", "военный", "разговор", "показать", "правительство", "важный", "семья", "великий", "производство", "простой", "значит", "третий", "сколько", "огромный", "давно", "политический", "информация", "действительно", "положение", "поставить", "бояться", "наконец", "центр", "происходить", "ответ", "муж", "автор", "все-таки", "стена", "существовать", "даже", "интерес", "становиться", "федерация", "правило", "оба", "часто", "московский", "управление", "слышать", "быстро", "смочь", "заметить", "как-то", "мужчина", "долго", "правда", "идея", "партия", "иногда", "использовать", "пытаться", "готовый", "чуть", "зачем", "представить", "чувствовать", "создать", "совет", "счет", "сердце", "движение", "вещь", "материал", "неделя", "чувство", "затем", "данный", "заниматься", "продолжать", "красный", "глава", "ко", "слушать", "наука", "узнать", "ряд", "газета", "причина", "против", "плечо", "современный", "цена", "план", "приехать", "речь", "четыре", "отвечать", "точка", "основа", "товарищ", "культура", "слишком", "рассказывать", "вполне", "далее", "рассказать", "данные", "представлять", "мнение", "социальный", "около", "документ", "институт", "ход", "брать", "забыть", "проект", "ранний", "встреча", "особый", "целый", "директор", "провести", "спать", "плохой", "может", "впрочем", "сильный", "наверное", "скорый", "ведь", "срок", "палец", "опыт", "помочь", "больше", "приходить", "служба", "крупный", "внутренний", "просить", "вспомнить", "открыть", "привести", "судьба", "пока", "девушка", "поскольку", "очередь", "лес", "пусть", "экономический", "оставить", "правый", "состав", "словно", "федеральный", "спрашивать", "принимать", "член", "искать", "близкий", "количество", "похожий", "событие", "объект", "зал", "создание", "войти", "различный", "значение", "назвать", "достаточно", "период", "хоть", "шаг", "необходимый", "успеть", "произойти", "брат", "искусство", "единственный", "легкий", "структура", "выходить", "номер", "предложить", "пример", "пить", "исследование", "гражданин", "глядеть", "человеческий", "игра", "начальник", "сей", "рост", "ехать", "международный", "тема", "принцип", "дорогой", "попасть", "десять", "начаться", "верить", "метод", "тип", "фильм", "небольшой", "держать", "либо", "позволять", "край", "местный", "менее", "гость", "купить", "уходить", "собираться", "воздух", "туда", "относиться", "бывший", "требовать", "характер", "борьба", "использование", "кстати", "подойти", "размер", "удаться", "образование", "получать", "мальчик", "кровь", "район", "небо", "американский", "армия", "класс", "представитель", "участие", "девочка", "политика", "сначала", "герой", "картина", "широкий", "доллар", "спина", "территория", "мировой", "пол", "тяжелый", "довольно", "поле", "ж", "изменение", "умереть", "более", "направление", "рисунок", "течение", "возможный", "церковь", "банк", "отдельный", "средний", "красивый", "сцена", "население", "большинство", "сесть", "двадцать", "случиться", "музыка", "короткий", "правда", "проходить", "составлять", "свобода", "память", "приходиться", "причем", "команда", "установить", "союз", "будто", "поднять", "врач", "серьезный", "договор", "стараться", "уметь", "встать", "дерево", "интересный", "факт", "добрый", "всего", "хозяин", "национальный", "однажды", "длинный", "природа", "домой", "страшный", "прошлый", "будто", "общественный", "угол", "чтоб", "телефон", "позиция", "проводить", "скоро", "наиболее", "двор", "обычно", "бросить", "разве", "писатель", "самолет", "объем", "далеко", "род", "солнце", "вера", "берег", "спектакль", "фирма", "способ", "завод", "цвет", "трудно", "журнал", "руководитель", "специалист", "возможно", "детский", "точно", "объяснить", "оценка", "единый", "снять", "определенный", "низкий", "нравиться", "услышать", "регион", "связать", "песня", "процент", "родитель", "позволить", "чужой", "море", "странный", "требование", "чистый", "весьма", "какой-нибудь", "основание", "половина", "поехать", "положить", "входить", "легко", "поздний", "роман", "круг", "анализ", "стихи", "автомобиль", "специальный", "экономика", "литература", "бумага", "вместо", "впервые", "видно", "научный", "оказываться", "поэт", "показывать", "степень", "вызвать", "касаться", "господин", "надежда", "сложный", "вокруг", "предмет", "отметить", "заявить", "вариант", "министр", "откуда", "реальный", "граница", "действовать", "дух", "модель", "операция", "пара", "сон", "немного", "название", "ум", "повод", "старик", "способный", "мало", "миллион", "малый", "старший", "успех", "практически", "получиться", "личный", "счастье", "необходимо", "свободный", "ребята", "обычный", "кабинет", "прекрасный", "высший", "кричать", "прежде", "магазин", "пространство", "выход", "остановиться", "удар", "база", "знание", "текст", "сюда", "темный", "защита", "предлагать", "руководство", "вовсе", "площадь", "сознание", "гражданский", "убить", "возраст", "молчать", "согласиться", "участник", "участок", "рано", "пункт", "несмотря", "сильно", "столь", "сообщить", "линия", "бежать", "желание", "папа", "кажется", "петь", "доктор", "губа", "известно", "дома", "вызывать", "дочь", "показаться", "среда", "председатель", "представление", "солдат", "художник", "принести", "волос", "оружие", "выглядеть", "соответствие", "никак", "ветер", "внешний", "парень", "служить", "зрение", "попросить", "генерал", "состоять", "огонь", "отдать", "боевой", "понятие", "строительство", "ухо", "выступать", "грудь", "нос", "ставить", "завтра", "возникать", "когда", "страх", "услуга", "рабочий", "что-нибудь", "глубокий", "содержание", "радость", "безопасность", "надеяться", "продукт", "видимо", "комплекс", "бизнес", "подняться", "вспоминать", "мало", "сад", "долгий", "одновременно", "называться", "сотрудник", "лето", "тихо", "зато", "прямой", "курс", "помогать", "предложение", "финансовый", "открытый", "почему-то", "значить", "возникнуть", "рот", "где-то", "технология", "знакомый", "недавно", "реформа", "отсутствие", "нынешний", "собака", "камень", "будущее", "звать", "рассказ", "контроль", "позвонить", "река", "хватать", "продукция", "сумма", "техника", "исторический", "вновь", "народный", "прямо", "ибо", "выпить", "здание", "сфера", "знаменитый", "иначе", "потерять", "необходимость", "больший", "фонд", "иметься", "вперед", "подготовка", "вчера", "лист", "пустой", "очередной", "республика", "хозяйство", "полностью", "получаться", "учиться", "плохо", "воля", "судебный", "бюджет", "возвращаться", "расти", "снег", "деревня", "обнаружить", "мужик", "постоянно", "зеленый", "элемент", "обстоятельство", "почувствовать", "немец", "многое", "победа", "источник", "немецкий", "зол"
    ]

    return %language%[Random(1, %language%.Length)]
}

/**
 * Converts a string into what it is in morse code
 * @param toMorse *String*
 * @returns {String}
 */
MorseCode(toMorse) {

    static Morse := Map(
        "a", ".-  ",
        "b", "-...  ",
        "c", "-.-.  ",
        "d", "-..  ",
        "e", ".  ",
        "f", "..-.  ",
        "g", "-.  ",
        "h", "....  ",
        "i", "..  ",
        "j", ".--  ",
        "k", "-.-  ",
        "l", ".-..  ",
        "m", "-  ",
        "n", "-.  ",
        "o", "--  ",
        "p", ".-.  ",
        "q", "-.-  ",
        "r", ".-.  ",
        "s", "...  ",
        "t", "-  ",
        "u", "..-  ",
        "v", "...-  ",
        "w", ".-  ",
        "x", "-..-  ",
        "y", "-.-  ",
        "z", "-..  ",
        " ", "    ",
        "`n", "`n",
        "`t", "`t",
        "0", "---  ",
        "1", ".--  ",
        "2", "..--  ",
        "3", "...-  ",
        "4", "....-  ",
        "5", ".....  ",
        "6", "-....  ",
        "7", "-...  ",
        "8", "--..  ",
        "9", "--.  "
    )

    text := StrLower(toMorse)
    noSpecialText := RegexReplace(text, "[^\w\d\s]+")
    noSpecialChars := StrSplit(noSpecialText)

    morseText := ""
    for key, value in noSpecialChars
        try morseText .= Morse[value]

    return morseText
}