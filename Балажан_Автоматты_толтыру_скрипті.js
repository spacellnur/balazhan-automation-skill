/**
 * ==============================================================================
 * БАЛАЖАН (balazhan.nedb.kz) АВТОМАТТЫ ТОЛТЫРУ СКРИПТ-РОБОТЫ (ИИ АГЕНТ)
 * Колледж: Түркістан жоғары көпсалалы, қолөнер колледжі
 * Оқу тобы: ТБ-26-11 (2026-2027 оқу жылы)
 * Куратор: Әлімхан Нұрсұлтан
 * Студенттер саны: 29
 * ==============================================================================
 * 
 * ҚОЛДАНУ НҰСҚАУЛЫҒЫ:
 * 1. Браузерде (Google Chrome) «balazhan.nedb.kz/cabinet» парақшасын ашыңыз.
 * 2. Пернетақтада F12 батырмасын басыңыз (немесе тінтуірдің оң жағын басып, «Просмотреть код» / «Inspect» таңдаңыз).
 * 3. Ашылған терезеден «Console» (Консоль) бөліміне өтіңіз.
 * 4. Осы файлдағы барлық кодты толық көшіріп, Консольге қойыңыз (Ctrl + V) және Enter басыңыз.
 *    (Егер Chrome алғаш рет «allow pasting» деп сұраса, жазып Enter басып, сосын қайта қойыңыз).
 * 5. Экранның оң жақ жоғарғы бұрышында арнайы басқару панелі пайда болады!
 * 6. «БАСТАУ (АВТОМАТТЫ ТОЛТЫРУ)» батырмасын басыңыз, қалғанын робот өзі рет-ретімен жасайды!
 * ==============================================================================
 */

(function() {
  // Алдын ала ашылған ескі панель болса алып тастау
  const oldPanel = document.getElementById('balazhan-bot-panel');
  if (oldPanel) oldPanel.remove();

  // 29 СТУДЕНТТІҢ ТОЛЫҚ ДЕРЕКТЕР ҚОРЫ
  const STUDENTS_DATA = [
    {
      num: 1,
      fio: "Абдрасилова Умида Розметқызы",
      iin: "081113653438",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Қайтыс болған",
      mother: "Исаева Гүлчехра",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "—",
      motherJob: "Ә.Науаи атындағы №13 мектеп",
      address: "Түркістан қаласы, Болашақ, Тұрманов 33",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 702 320 43 99",
      phone: "+7 777 023 20 08",
      familyType: "Неполная семья",
      kidsCount: 3,
      socCat: ["Ребенок, оставшийся без попечения родителей"],
      difficultSit: ["Смерть близкого родственника"]
    },
    {
      num: 2,
      fio: "Абдусаттарова Бибіайша",
      iin: "090626653129",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Мамметов Алымжан",
      mother: "Мамметова Бибисора",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке меншік",
      motherJob: "Үй шаруасында",
      address: "Сауран ауданы, Қарашық ауылы, Ибн-Сина 49",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 771 795 86 10",
      motherPhone: "+7 771 238 29 78",
      phone: "+7 771 466 20 09",
      familyType: "Полная семья",
      kidsCount: 2,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 3,
      fio: "Абулаева Севгиля Рахматжанқызы",
      iin: "090322653895",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Умирзаков Рахматжан",
      mother: "Нарзуллаева Карима",
      fatherEdu: "Техническое и профессиональное",
      motherEdu: "Техническое и профессиональное",
      fatherJob: "Жұмыссыз",
      motherJob: "В.Вахидов атындағы мектеп",
      address: "Сауран ауданы, Шаға ауылы, Түркістан көшесі 50 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 771 576 18 89",
      phone: "+7 771 576 18 89",
      familyType: "Полная семья",
      kidsCount: 8,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 4,
      fio: "Алишеров Фарид Ғуламжанұлы",
      iin: "080420553834",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Махмутов Ғуламжан",
      mother: "Шерметова Надира",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Мектепте жұмыс істейді",
      motherJob: "Мектепте жұмыс істейді",
      address: "Түркістан облысы, Жаңа Иқан ауылы, Сейтмұрат болыс 77 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "",
      phone: "+7 707 163 68 57",
      familyType: "Полная семья",
      kidsCount: 6,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 5,
      fio: "Аллияров Султанбек Абибуллаұлы",
      iin: "080723552665",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Розметов Абибулла",
      mother: "Розметова Гүлбахар",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жұмыссыз",
      motherJob: "Жұмыспен қамту орталығы",
      address: "Сауран ауданы, Шорнақ ауылы, Аша елді мекені, Тойтақ 8 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 705 690 00 19",
      motherPhone: "+7 705 690 00 19",
      phone: "+7 705 831 00 42",
      familyType: "Полная семья",
      kidsCount: 4,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 6,
      fio: "Амантұр Нұрай Қайратбекқызы",
      iin: "090925650645",
      gender: "Женский",
      nat: "Казах",
      father: "Амантұр Қайратбек",
      mother: "Назарова Несібелі",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "—",
      motherJob: "Мектепте",
      address: "Сауран ауданы, Шорнақ ауылы, С.Сейфуллин 48",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 777 146 81 59",
      phone: "+7 777 146 81 59",
      familyType: "Полная семья",
      kidsCount: 5,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 7,
      fio: "Ахатуллаева Мархаба Асадуллақызы",
      iin: "090828650271",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Абдувалиев Асадулла",
      mother: "Абдукадираева Нигара",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке кәсіпкерлік",
      motherJob: "Жеке кәсіпкерлік",
      address: "Түркістан қаласы, Марқасқа жырау 21",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 747 507 51 51",
      motherPhone: "+7 747 507 51 51",
      phone: "+7 707 646 20 30",
      familyType: "Полная семья",
      kidsCount: 5,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 8,
      fio: "Әбдіхалық Аруна Батырқызы",
      iin: "090812650046",
      gender: "Женский",
      nat: "Казах",
      father: "Әбдіхалық Батыр",
      mother: "—",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке меншік",
      motherJob: "Үй шаруасында",
      address: "Түркістан облысы, Сауран ауданы, Асанбай, Дурия 1",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 702 035 95 58",
      motherPhone: "",
      phone: "+7 702 035 95 58",
      familyType: "Полная семья",
      kidsCount: 2,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 9,
      fio: "Әзиева Ақерке Талғатқызы",
      iin: "090210654492",
      gender: "Женский",
      nat: "Казах",
      father: "Аймаханов Талғат Әзиұлы",
      mother: "Атаханова Гүлнұр Айтбековна",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Спорт кешені",
      motherJob: "Спорт кешені",
      address: "Қызылорда облысы, Шиелі ауданы",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 747 199 03 62",
      motherPhone: "+7 747 199 03 62",
      phone: "+7 747 199 03 62",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 10,
      fio: "Бахтиярова Құрбанай Бабирқызы",
      iin: "081208653345",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Аубакиров Бабир",
      mother: "Сүлейменова Мавжуда",
      fatherEdu: "Техническое и профессиональное",
      motherEdu: "Техническое и профессиональное",
      fatherJob: "Жұмыссыз",
      motherJob: "Жұмыссыз",
      address: "Сауран ауданы, 30 жылдық ауыл, Темірқорған 44 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 747 611 86 61",
      motherPhone: "+7 705 857 50 83",
      phone: "+7 771 226 07 64",
      familyType: "Полная семья",
      kidsCount: 6,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 11,
      fio: "Газиханова Севинч Азизқызы",
      iin: "090805651016",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Дадашов Азиз",
      mother: "Юнусова Хумора",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "«Тұран Су» мекемесі",
      motherJob: "Үй шаруасында",
      address: "Сауран ауданы, Бершінтөбе ауылы, 58 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 771 382 27 28",
      motherPhone: "+7 777 044 48 45",
      phone: "+7 776 834 79 00",
      familyType: "Полная семья",
      kidsCount: 5,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 12,
      fio: "Диметов Хайтбой Абдиқодирұлы",
      iin: "081001554699",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Диметов Абдиқодир",
      mother: "Анарбаева Мукаррам",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Зейнеткер",
      motherJob: "Жұмыссыз",
      address: "Сауран ауданы, Қарашық ауылы, С.Жамалов 40 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 705 675 12 08",
      motherPhone: "+7 705 675 12 08",
      phone: "+7 705 350 54 18",
      familyType: "Полная семья",
      kidsCount: 2,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 13,
      fio: "Егізбек Толғанай Ерболатқызы",
      iin: "080613650706",
      gender: "Женский",
      nat: "Казах",
      father: "Молдашбаев Ерболат",
      mother: "Омарова Гүлайым",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жұмыссыз",
      motherJob: "Техникалық қызметкер",
      address: "Түркістан қаласы, Жаңа қала 9 көше, 17/2 үй",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 705 491 54 69",
      motherPhone: "+7 705 491 54 69",
      phone: "+7 705 491 54 69",
      familyType: "Полная семья",
      kidsCount: 7,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 14,
      fio: "Жақсыбек Жанкелді Бекайдарұлы",
      iin: "080207550366",
      gender: "Мужской",
      nat: "Казах",
      father: "Әуелбеков Бекайдар Жақсыбекұлы",
      mother: "Күлатаева Гүлсім Шермағанбетқызы",
      fatherEdu: "Техническое и профессиональное",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "Жезқазған «Bass cold», машинист",
      motherJob: "Жұмыссыз",
      address: "Қызылорда облысы, Жаңақорған ауданы, Зұлпыхар Байзақов 86",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 702 905 01 78",
      motherPhone: "",
      phone: "+7 747 030 97 86",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Один из родителей работает за границей/в другом городе"]
    },
    {
      num: 15,
      fio: "Каримова Дурдона Дилшодқызы",
      iin: "081215652948",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Абдижалилов Дилшод",
      mother: "Назарова Дилнора",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Зауытта жұмысшы",
      motherJob: "Зауытта жұмысшы",
      address: "Түркістан қаласы, Алтай 72",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 775 361 69 04",
      motherPhone: "+7 775 361 69 04",
      phone: "+7 700 321 20 08",
      familyType: "Полная семья",
      kidsCount: 4,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 16,
      fio: "Касымова Шодиена Бахтиярқызы",
      iin: "080822655159",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Айтқулов Бахтияр",
      mother: "Халметова Халида",
      fatherEdu: "Высшее, послевузовское",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "Жеке кәсіпкер",
      motherJob: "Жеке кәсіпкер",
      address: "Сауран ауданы, Шорнақ ауылы, С.Сейфуллин 3 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 771 544 55 55",
      motherPhone: "+7 705 294 71 98",
      phone: "+7 771 277 24 07",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 17,
      fio: "Кәрібай Қарақат Тоқтарбайқызы",
      iin: "090815654144",
      gender: "Женский",
      nat: "Казах",
      father: "Сыздықов Тоқтарбай Кәрібайұлы",
      mother: "Алтынбекова Айгерим Тулепбергеновна",
      fatherEdu: "Среднее",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "Жұмыссыз",
      motherJob: "Жұмыссыз",
      address: "Қызылорда облысы, Шиелі ауданы, Құлтаев 14",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 776 852 02 52",
      motherPhone: "+7 776 852 02 52",
      phone: "+7 776 852 02 52",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 18,
      fio: "Көлегенова Гүлсезім",
      iin: "080911653542",
      gender: "Женский",
      nat: "Казах",
      father: "Әлсейтов Қоныс",
      mother: "Рысдаулетова Ұлболсын",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жұмыссыз",
      motherJob: "Жұмыссыз",
      address: "Жаңақорған ауданы, Қаратөбе ауылы, Т.Тоқтаров 10",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 705 570 33 08",
      motherPhone: "+7 705 570 33 08",
      phone: "+7 705 570 33 08",
      familyType: "Полная семья",
      kidsCount: 6,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 19,
      fio: "Қасымбек Әлдекей Сейтмұратұлы",
      iin: "090109554398",
      gender: "Мужской",
      nat: "Казах",
      father: "Қасымбек Сейтмұрат",
      mother: "Бекжасарова Роза",
      fatherEdu: "Среднее",
      motherEdu: "Техническое и профессиональное",
      fatherJob: "—",
      motherJob: "Жұмыссыз",
      address: "Түркістан қаласы, Шорнақ 16",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 775 531 25 35",
      phone: "+7 775 531 25 35",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 20,
      fio: "Махмут Дамир Махмутұлы",
      iin: "090704554085",
      gender: "Мужской",
      nat: "Казах",
      father: "Ажырасқан (бірге тұрмайды)",
      mother: "Мекебаева Мадина Абдилатовна",
      fatherEdu: "—",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "—",
      motherJob: "Жұмыссыз",
      address: "Түркістан қаласы, Үсен Дүйсенұлы 99/1",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 775 379 53 23",
      phone: "+7 775 379 53 23",
      familyType: "Неполная семья",
      kidsCount: 3,
      socCat: ["Малообеспеченные"],
      difficultSit: ["Развод родителей"]
    },
    {
      num: 21,
      fio: "Муратова Шадиена Мирзахметқызы",
      iin: "090228653501",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Юсупов Мирзахмет",
      mother: "Низаева Айгүл",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жұмыссыз",
      motherJob: "Жұмыссыз",
      address: "Сауран ауданы, Шорнақ ауылы, Сапар 31 үй",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 771 887 38 56",
      motherPhone: "+7 771 887 38 56",
      phone: "+7 771 887 38 56",
      familyType: "Полная семья",
      kidsCount: 6,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 22,
      fio: "Насирлла Інжу Медетқызы",
      iin: "090430653173",
      gender: "Женский",
      nat: "Казах",
      father: "Егенбердиев Медет",
      mother: "Жумашева Назгүл",
      fatherEdu: "Высшее, послевузовское",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "Жеке кәсіпкерлік",
      motherJob: "Жеке кәсіпкерлік",
      address: "Түркістан қаласы, Көкжелек 11",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 705 698 14 84",
      motherPhone: "",
      phone: "+7 775 306 60 58",
      familyType: "Полная семья",
      kidsCount: 5,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 23,
      fio: "Нематжанова Орзу Азизқызы",
      iin: "090507654193",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Юсупов Азиз",
      mother: "Юсупова Гүлбахар",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жиһаз ұстасы",
      motherJob: "Аспаз",
      address: "Түркістан қаласы, Гаухар батыр 70",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 702 377 35 07",
      motherPhone: "+7 702 043 96 08",
      phone: "+7 778 249 92 56",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 24,
      fio: "Оспан Қарақат Мейрамбекқызы",
      iin: "090105652990",
      gender: "Женский",
      nat: "Казах",
      father: "Асанов Мейрамбек Оспанович",
      mother: "Бейсенбай Нұргүл Арыстанқызы",
      fatherEdu: "Высшее, послевузовское",
      motherEdu: "Высшее, послевузовское",
      fatherJob: "Вахталық жұмыс",
      motherJob: "№169 мектеп мұғалімі",
      address: "Қызылорда облысы, Жаңақорған ауданы, Ә.Молдағұлова 61",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 707 253 14 50",
      motherPhone: "",
      phone: "+7 707 188 01 05",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Один из родителей работает за границей/в другом городе"]
    },
    {
      num: 25,
      fio: "Рустамов Бехзат Алишерұлы",
      iin: "090926550307",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Убашов Алишер",
      mother: "Убашова Мадина",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке кәсіпкер",
      motherJob: "«Бірлік» клиникасы",
      address: "Түркістан қаласы, Коммунизм, Серт 44",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "+7 707 798 87 19",
      phone: "+7 778 625 39 08",
      familyType: "Полная семья",
      kidsCount: 5,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 26,
      fio: "Сейткаримова Айсу",
      iin: "090824650254",
      gender: "Женский",
      nat: "Другая национальность",
      father: "Юлдашев Шухрат",
      mother: "Юлдашева Гүлмира",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке кәсіпкерлік",
      motherJob: "Үй шаруасында",
      address: "Сауран ауданы, 30 жылдық ауылы, Қазыбек би 12",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 778 371 13 61",
      motherPhone: "+7 778 371 13 61",
      phone: "+7 778 371 13 61",
      familyType: "Полная семья",
      kidsCount: 6,
      socCat: ["Многодетная семья"],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 27,
      fio: "Секентай Мағжан Рустемұлы",
      iin: "090621552395",
      gender: "Мужской",
      nat: "Казах",
      father: "Бегалы Рустем",
      mother: "Қожахметова Күлайша",
      fatherEdu: "Техническое и профессиональное",
      motherEdu: "Техническое и профессиональное",
      fatherJob: "Жеке кәсіпкер",
      motherJob: "Үй шаруасында",
      address: "Сауран ауданы, Құмтүйін ауылы, А. Төлепберген көшесі",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "+7 776 311 68 68",
      motherPhone: "+7 705 370 83 27",
      phone: "+7 776 337 04 42",
      familyType: "Полная семья",
      kidsCount: 4,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 28,
      fio: "Файзулла Умиджан Садуллаұлы",
      iin: "090825500113",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Шерметов Садулла Файзуллаұлы",
      mother: "Шерметова Гүлнора Маккамбаевна",
      fatherEdu: "Высшее, послевузовское",
      motherEdu: "Среднее",
      fatherJob: "Арман-М school мектебі, мұғалім",
      motherJob: "Жұмыссыз",
      address: "Түркістан қаласы, Жәнібек батыр 66 үй",
      areaType: "Город",
      houseType: "Частный дом",
      fatherPhone: "+7 777 038 67 05",
      motherPhone: "+7 771 828 22 84",
      phone: "+7 707 817 00 83",
      familyType: "Полная семья",
      kidsCount: 3,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    },
    {
      num: 29,
      fio: "Хакимжанов Бехруз",
      iin: "081207552474",
      gender: "Мужской",
      nat: "Другая национальность",
      father: "Хакимжанов",
      mother: "—",
      fatherEdu: "Среднее",
      motherEdu: "Среднее",
      fatherJob: "Жеке меншік",
      motherJob: "Үй шаруасында",
      address: "Сауран ауданы, 30 жылдық ауылы, А. Навои 60",
      areaType: "Село",
      houseType: "Частный дом",
      fatherPhone: "",
      motherPhone: "",
      phone: "+7 705 377 08 01",
      familyType: "Полная семья",
      kidsCount: 2,
      socCat: [],
      difficultSit: ["Трудная ситуация не наблюдается"]
    }
  ];

  let currentIndex = 0;
  let isRunning = false;
  let isPaused = false;

  // КӨМЕКШІ ФУНКЦИЯЛАР (DOM & Input)
  const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

  function setNativeValue(element, value) {
    if (!element) return;
    const prototype = Object.getPrototypeOf(element);
    const descriptor = Object.getOwnPropertyDescriptor(prototype, 'value');
    if (descriptor && descriptor.set) {
      descriptor.set.call(element, value);
    } else {
      element.value = value;
    }
    element.dispatchEvent(new Event('input', { bubbles: true }));
    element.dispatchEvent(new Event('change', { bubbles: true }));
  }

  function clickEl(el) {
    if (!el) return;
    el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    el.dispatchEvent(new MouseEvent('mouseover', { bubbles: true }));
    el.dispatchEvent(new MouseEvent('mousedown', { bubbles: true }));
    el.click();
    el.dispatchEvent(new MouseEvent('mouseup', { bubbles: true }));
    el.dispatchEvent(new Event('change', { bubbles: true }));
  }

  // Модаль терезені табу
  function getModal() {
    const dialogs = Array.from(document.querySelectorAll('div, section, form')).filter(el => {
      const text = el.innerText || '';
      return (text.includes('Добавить 1 студента') || text.includes('ФИО студента')) && el.querySelector('input');
    });
    return dialogs[dialogs.length - 1] || document.body;
  }

  // Label немесе placeholder арқылы Input табу
  function findInput(root, keywords) {
    if (typeof keywords === 'string') keywords = [keywords];
    
    // 1. Placeholder тексеру
    for (const kw of keywords) {
      const byPlaceholder = root.querySelector(`input[placeholder*="${kw}" i], textarea[placeholder*="${kw}" i]`);
      if (byPlaceholder) return byPlaceholder;
    }

    // 2. Жақын орналасқан мәтін / Label тексеру
    const allLabels = Array.from(root.querySelectorAll('label, div, span, p')).filter(el => {
      const t = el.innerText ? el.innerText.trim() : '';
      return keywords.some(kw => t.toLowerCase().includes(kw.toLowerCase()));
    });

    for (const label of allLabels) {
      // Ішінде input бар ма?
      const inside = label.querySelector('input, textarea');
      if (inside) return inside;
      
      // Келесі бауырлас элемент немесе ата-анасының ішіндегі input
      let next = label.nextElementSibling;
      while (next) {
        if (next.tagName === 'INPUT' || next.tagName === 'TEXTAREA') return next;
        const sub = next.querySelector('input, textarea');
        if (sub) return sub;
        next = next.nextElementSibling;
      }
      
      if (label.parentElement) {
        const parentInput = label.parentElement.querySelector('input, textarea');
        if (parentInput) return parentInput;
      }
    }
    return null;
  }

  // Select / Dropdown толтыру
  function setDropdown(root, labelKeyword, optionKeyword) {
    const labels = Array.from(root.querySelectorAll('label, div, span')).filter(el => 
      el.innerText && el.innerText.toLowerCase().includes(labelKeyword.toLowerCase())
    );
    
    for (const lbl of labels) {
      const select = lbl.parentElement?.querySelector('select') || lbl.nextElementSibling?.querySelector('select') || (lbl.nextElementSibling?.tagName === 'SELECT' ? lbl.nextElementSibling : null);
      if (select) {
        for (let i = 0; i < select.options.length; i++) {
          if (select.options[i].text.toLowerCase().includes(optionKeyword.toLowerCase())) {
            select.selectedIndex = i;
            select.dispatchEvent(new Event('change', { bubbles: true }));
            return true;
          }
        }
      }
    }
    return false;
  }

  // Radio немесе Checkbox таңдау
  function selectRadioOrCheckbox(root, keyword) {
    const candidates = Array.from(root.querySelectorAll('label, span, div, p')).filter(el => {
      const t = el.innerText ? el.innerText.trim() : '';
      return t.toLowerCase().includes(keyword.toLowerCase());
    });

    for (const cand of candidates) {
      const input = cand.querySelector('input[type="radio"], input[type="checkbox"]') || 
                    (cand.previousElementSibling?.tagName === 'INPUT' ? cand.previousElementSibling : null);
      if (input) {
        if (!input.checked) clickEl(input);
        return true;
      } else {
        clickEl(cand);
        return true;
      }
    }
    return false;
  }

  // 1 СТУДЕНТТІ ТОЛЫҚ ТОЛТЫРУ ФУНКЦИЯСЫ
  async function fillStudent(s) {
    log(`⏳ [${s.num}/29] «${s.fio}» толтырылуда...`, '#0284c7');
    
    // Модаль ашық емес болса «Добавить 1 студента» батырмасын басу
    let modal = getModal();
    if (!modal || !modal.querySelector('input[placeholder*="12"], input[placeholder*="ИИН"]')) {
      const addBtn = Array.from(document.querySelectorAll('button, div, a')).find(el => {
        const t = el.innerText ? el.innerText.trim() : '';
        return t.includes('Добавить 1 студента') || (t.includes('ОДИН СТУДЕНТ') && t.includes('Добавить'));
      });
      if (addBtn) {
        clickEl(addBtn);
        await sleep(1200);
        modal = getModal();
      }
    }

    if (!modal) {
      log('❌ Модальді терезе табылмады! Бетті жаңартып көріңіз.', 'red');
      return false;
    }

    // 1. Курс пен Группа
    setDropdown(modal, 'курс', '1');
    setDropdown(modal, 'группа', 'ТБ-26-11');

    // 2. ФИО
    const fioInput = findInput(modal, ['ФИО', 'Фамилия Имя', 'студента']);
    if (fioInput) setNativeValue(fioInput, s.fio);

    // 3. ИИН
    const iinInput = findInput(modal, ['ИИН', '12 цифр']);
    if (iinInput) setNativeValue(iinInput, s.iin);

    // 4. Пол
    setDropdown(modal, 'Пол', s.gender);

    // 5. Национальность
    selectRadioOrCheckbox(modal, s.nat);

    // 6. Отец және Мать
    const fatherInput = findInput(modal, ['Отец']);
    if (fatherInput) setNativeValue(fatherInput, s.father);

    const motherInput = findInput(modal, ['Мать']);
    if (motherInput) setNativeValue(motherInput, s.mother);

    // 7. Образование
    selectRadioOrCheckbox(modal, s.fatherEdu);
    selectRadioOrCheckbox(modal, s.motherEdu);

    // 8. Место работы
    const fJob = findInput(modal, ['Место работы отца']);
    if (fJob) setNativeValue(fJob, s.fatherJob);

    const mJob = findInput(modal, ['Место работы матери']);
    if (mJob) setNativeValue(mJob, s.motherJob);

    // 9. Адрес
    const addr = findInput(modal, ['Адрес проживания', 'Адрес']);
    if (addr) setNativeValue(addr, s.address);

    // 10. Место проживания & Тип жилья
    selectRadioOrCheckbox(modal, s.areaType);
    selectRadioOrCheckbox(modal, s.houseType);

    // 11. Телефондар
    if (s.fatherPhone) {
      const fPhone = findInput(modal, ['Телефон отца']);
      if (fPhone) setNativeValue(fPhone, s.fatherPhone);
    }
    if (s.motherPhone) {
      const mPhone = findInput(modal, ['Телефон матери']);
      if (mPhone) setNativeValue(mPhone, s.motherPhone);
    }
    const stPhone = findInput(modal, ['Телефон']);
    if (stPhone) setNativeValue(stPhone, s.phone);

    // 12. Состав семьи & Бала саны
    selectRadioOrCheckbox(modal, s.familyType);
    const kCount = findInput(modal, ['Количество детей']);
    if (kCount) setNativeValue(kCount, s.kidsCount.toString());

    // 13. Социальные категории
    for (const cat of s.socCat) {
      selectRadioOrCheckbox(modal, cat);
    }

    // 14. Бақылау карточкасы (стандартты көрсеткіштер)
    selectRadioOrCheckbox(modal, 'Изменений не наблюдается');
    selectRadioOrCheckbox(modal, 'Стабильная, положительная среда');
    selectRadioOrCheckbox(modal, 'Хорошо общается с друзьями');
    selectRadioOrCheckbox(modal, 'Хорошие');
    selectRadioOrCheckbox(modal, 'Не наблюдались');
    selectRadioOrCheckbox(modal, 'Отношения уважительные');
    selectRadioOrCheckbox(modal, 'Факторы риска не наблюдаются');

    // Қиын жағдайлар
    for (const diff of s.difficultSit) {
      selectRadioOrCheckbox(modal, diff);
    }

    log(`✅ [${s.num}/29] «${s.fio}» өрістері толтырылды!`, '#16a34a');
    await sleep(800);

    // «Добавить студента» батырмасын басу
    const submitBtn = Array.from(modal.querySelectorAll('button')).find(btn => {
      const t = btn.innerText || '';
      return t.includes('Добавить студента') || t.includes('Сохранить');
    });

    if (submitBtn) {
      log(`💾 Сақталуда... («Добавить студента»)`, '#0284c7');
      clickEl(submitBtn);
      await sleep(2500); // Сақталуын күту
      log(`🎉 [${s.num}/29] Студент сәтті сақталды!`, '#16a34a');
      return true;
    } else {
      log('⚠️ «Добавить студента» батырмасы табылмады, өзіңіз қолмен басыңыз.', 'orange');
      return false;
    }
  }

  // ЦИКЛ АВТОМАТТАНДЫРУ
  async function runBatch() {
    if (isRunning) return;
    isRunning = true;
    isPaused = false;
    updateStatus('Жұмыс істеп тұр...', '#16a34a');

    for (let i = currentIndex; i < STUDENTS_DATA.length; i++) {
      if (!isRunning) break;
      while (isPaused) {
        updateStatus('Кідіртілді (Пауза)', '#d97706');
        await sleep(500);
      }

      currentIndex = i;
      updateProgress(currentIndex + 1, STUDENTS_DATA.length);
      const ok = await fillStudent(STUDENTS_DATA[i]);
      if (!ok) {
        log(`⚠️ Студент #${i + 1} тоқтатылды, қайта көріңіз немесе келесіге өтіңіз.`, 'orange');
        break;
      }
      await sleep(1500);
    }

    if (currentIndex >= STUDENTS_DATA.length - 1) {
      log('🎊 БАРЛЫҚ 29 СТУДЕНТ ТОЛЫҚ АЯҚТАЛДЫ!', '#16a34a');
      updateStatus('Дайын! Барлығы енгізілді', '#16a34a');
    }
    isRunning = false;
  }

  // БАСҚАРУ ПАНЕЛІН (UI) ҚҰРУ
  const panel = document.createElement('div');
  panel.id = 'balazhan-bot-panel';
  panel.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    width: 360px;
    background: #ffffff;
    border: 2px solid #1b365d;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
    z-index: 999999;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
    color: #1e293b;
    overflow: hidden;
  `;

  panel.innerHTML = `
    <div style="background:#1b365d; color:white; padding:12px 16px; font-weight:bold; font-size:14px; display:flex; justify-content:space-between; align-items:center;">
      <span>🤖 Балажан Авто-Куратор (ТБ-26-11)</span>
      <button id="bb-close" style="background:transparent; border:none; color:white; font-size:16px; cursor:pointer;">✖</button>
    </div>
    <div style="padding:14px;">
      <div style="font-size:12px; color:#64748b; margin-bottom:8px;">
        Куратор: <b>Әлімхан Нұрсұлтан</b> | Барлығы: <b>29 студент</b>
      </div>
      
      <div style="margin-bottom:12px;">
        <div style="display:flex; justify-content:space-between; font-size:13px; font-weight:bold; margin-bottom:4px;">
          <span>Орындалу барысы:</span>
          <span id="bb-counter">0 / 29</span>
        </div>
        <div style="width:100%; height:8px; background:#e2e8f0; border-radius:4px; overflow:hidden;">
          <div id="bb-bar" style="width:0%; height:100%; background:#10b981; transition:width 0.3s;"></div>
        </div>
      </div>

      <div id="bb-status" style="font-size:12px; font-weight:bold; color:#0284c7; margin-bottom:12px;">
        Күйі: Күтуде (Бастауға дайын)
      </div>

      <div style="display:flex; flex-direction:column; gap:8px;">
        <button id="bb-start" style="background:#10b981; color:white; border:none; padding:10px; border-radius:6px; font-weight:bold; font-size:13px; cursor:pointer; box-shadow:0 2px 4px rgba(16,185,129,0.3);">
          ▶️ БАСТАУ (АВТОМАТТЫ ТОЛТЫРУ)
        </button>
        <div style="display:flex; gap:8px;">
          <button id="bb-step" style="flex:1; background:#3b82f6; color:white; border:none; padding:8px; border-radius:6px; font-weight:bold; font-size:12px; cursor:pointer;">
            ⏭️ Келесі 1 студент
          </button>
          <button id="bb-pause" style="flex:1; background:#f59e0b; color:white; border:none; padding:8px; border-radius:6px; font-weight:bold; font-size:12px; cursor:pointer;">
            ⏸️ Пауза
          </button>
          <button id="bb-stop" style="flex:1; background:#ef4444; color:white; border:none; padding:8px; border-radius:6px; font-weight:bold; font-size:12px; cursor:pointer;">
            ⏹️ Тоқтату
          </button>
        </div>
      </div>

      <div style="margin-top:12px;">
        <div style="font-size:11px; font-weight:bold; color:#64748b; margin-bottom:4px;">Оқиғалар журналы:</div>
        <div id="bb-logs" style="height:110px; background:#f8fafc; border:1px solid #e2e8f0; border-radius:6px; padding:6px; font-size:11px; overflow-y:auto; line-height:1.4;">
          <div style="color:#64748b;">Робот дайын. «БАСТАУ» басыңыз...</div>
        </div>
      </div>
    </div>
  `;

  document.body.appendChild(panel);

  // Оқиғаларды тіркеу
  document.getElementById('bb-close').onclick = () => panel.remove();
  document.getElementById('bb-start').onclick = () => runBatch();
  document.getElementById('bb-pause').onclick = () => {
    isPaused = !isPaused;
    document.getElementById('bb-pause').innerText = isPaused ? '▶️ Жалғастыру' : '⏸️ Пауза';
  };
  document.getElementById('bb-stop').onclick = () => {
    isRunning = false;
    isPaused = false;
    updateStatus('Тоқтатылды', '#ef4444');
    log('⏹️ Процесс қолмен тоқтатылды.', '#ef4444');
  };
  document.getElementById('bb-step').onclick = async () => {
    if (currentIndex < STUDENTS_DATA.length) {
      updateProgress(currentIndex + 1, STUDENTS_DATA.length);
      await fillStudent(STUDENTS_DATA[currentIndex]);
      currentIndex++;
    }
  };

  function log(msg, color='#1e293b') {
    const logs = document.getElementById('bb-logs');
    if (!logs) return;
    const time = new Date().toLocaleTimeString('kk-KZ', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    const item = document.createElement('div');
    item.style.color = color;
    item.innerHTML = `<span style="color:#94a3b8;">[${time}]</span> ${msg}`;
    logs.appendChild(item);
    logs.scrollTop = logs.scrollHeight;
  }

  function updateStatus(text, color) {
    const el = document.getElementById('bb-status');
    if (el) {
      el.innerText = 'Күйі: ' + text;
      el.style.color = color;
    }
  }

  function updateProgress(curr, total) {
    const counter = document.getElementById('bb-counter');
    const bar = document.getElementById('bb-bar');
    if (counter) counter.innerText = `${curr} / ${total}`;
    if (bar) bar.style.width = `${Math.round((curr / total) * 100)}%`;
  }

  log('✨ Авто-Куратор сәтті қосылды! Панельді қолдана аласыз.', '#10b981');
})();
