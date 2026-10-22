# PowerShell script to generate Word document with full social passports for all 29 students
$ErrorActionPreference = "Stop"

$desktop1 = "C:\Users\nursu\OneDrive\Desktop"
$desktop2 = "C:\Users\nursu\Desktop"
$fileName = "ТБ-26-11_Студенттердің_әлеуметтік_паспорты_және_бақылау_картасы.docx"
$tempHtml = "$env:TEMP\students_doc.html"
$tempDocx = "$env:TEMP\$fileName"

# JSON or Object array with all 29 students
$students = @(
    @{
        num = 1
        fio = "Абдрасилова Умида Розметқызы"
        iin = "081113653438"
        foreign = "Нет"
        gender = "Женский"
        dob = "13.11.2008"
        phone = "+7 777 023 20 08"
        email = "—"
        address = "Түркістан қаласы, Болашақ, Тұрманов 33"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Қайтыс болған (жартылай жетім)"
        mother = "Исаева Гүлчехра"
        guardian = "—"
        fatherEdu = "—"
        motherEdu = "Среднее"
        fatherJob = "—"
        motherJob = "Ә.Науаи атындағы №13 мектеп"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 702 320 43 99"
        familyType = "Неполная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Ребенок, оставшийся без попечения родителей (жартылай жетім)"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Смерть близкого родственника"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 2
        fio = "Абдусаттарова Бибіайша"
        iin = "090626653129"
        foreign = "Нет"
        gender = "Женский"
        dob = "26.06.2009"
        phone = "+7 771 466 20 09"
        email = "abdusattarovabibiajsa@gmail.com"
        address = "Сауран ауданы, Қарашық ауылы, Ибн-Сина 49"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Мамметов Алымжан"
        mother = "Мамметова Бибисора"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке меншік"
        motherJob = "Үй шаруасында (Үй бикесі)"
        guardianJob = "—"
        fatherPhone = "+7 771 795 86 10"
        motherPhone = "+7 771 238 29 78"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 2
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 3
        fio = "Абулаева Севгиля Рахматжанқызы"
        iin = "090322653895"
        foreign = "Нет"
        gender = "Женский"
        dob = "22.03.2009"
        phone = "+7 771 576 18 89"
        email = "abulaeva.sevgilya@mail.ru"
        address = "Сауран ауданы, Шаға ауылы, Түркістан көшесі 50 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Умирзаков Рахматжан"
        mother = "Нарзуллаева Карима"
        guardian = "—"
        fatherEdu = "Техническое и профессиональное"
        motherEdu = "Техническое и профессиональное"
        fatherJob = "Жұмыссыз"
        motherJob = "В.Вахидов атындағы мектеп"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 771 576 18 89"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 8
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 4
        fio = "Алишеров Фарид Ғуламжанұлы"
        iin = "080420553834"
        foreign = "Нет"
        gender = "Мужской"
        dob = "20.04.2008"
        phone = "+7 707 163 68 57"
        email = "alisherovfarid23@gmail.com"
        address = "Түркістан облысы, Жаңа Иқан ауылы, Сейтмұрат болыс 77 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Махмутов Ғуламжан"
        mother = "Шерметова Надира"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Мектепте жұмыс істейді"
        motherJob = "Мектепте жұмыс істейді"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 6
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 5
        fio = "Аллияров Султанбек Абибуллаұлы"
        iin = "080723552665"
        foreign = "Нет"
        gender = "Мужской"
        dob = "23.07.2008"
        phone = "+7 705 831 00 42"
        email = "alliyarovsultanbek@gmail.com"
        address = "Сауран ауданы, Шорнақ ауылы, Аша елді мекені, Тойтақ 8 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Розметов Абибулла"
        mother = "Розметова Гүлбахар"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жұмыссыз"
        motherJob = "Жұмыспен қамту орталығы (Биржа)"
        guardianJob = "—"
        fatherPhone = "+7 705 690 00 19"
        motherPhone = "+7 705 690 00 19"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 4
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 6
        fio = "Амантұр Нұрай Қайратбекқызы"
        iin = "090925650645"
        foreign = "Нет"
        gender = "Женский"
        dob = "25.09.2009"
        phone = "+7 777 146 81 59"
        email = "amanturnuraj@gmail.com"
        address = "Сауран ауданы, Шорнақ ауылы, С.Сейфуллин 48"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Амантұр Қайратбек"
        mother = "Назарова Несібелі"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "—"
        motherJob = "Мектепте"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 777 146 81 59"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 5
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 7
        fio = "Ахатуллаева Мархаба Асадуллақызы"
        iin = "090828650271"
        foreign = "Нет"
        gender = "Женский"
        dob = "28.08.2009"
        phone = "+7 707 646 20 30"
        email = "marhaboahatllaeva@gmail.com"
        address = "Түркістан қаласы, Марқасқа жырау 21"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Абдувалиев Асадулла"
        mother = "Абдукадираева Нигара"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке кәсіпкерлік"
        motherJob = "Жеке кәсіпкерлік"
        guardianJob = "—"
        fatherPhone = "+7 747 507 51 51"
        motherPhone = "+7 747 507 51 51"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 5
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 8
        fio = "Әбдіхалық Аруна Батырқызы"
        iin = "090812650046"
        foreign = "Нет"
        gender = "Женский"
        dob = "12.08.2009"
        phone = "+7 702 035 95 58"
        email = "arunaabdikhalyk2@gmail.com"
        address = "Түркістан облысы, Сауран ауданы, Асанбай, Дурия 1"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Әбдіхалық Батыр"
        mother = "—"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке меншік"
        motherJob = "Үй шаруасында"
        guardianJob = "—"
        fatherPhone = "+7 702 035 95 58"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 2
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 9
        fio = "Әзиева Ақерке Талғатқызы"
        iin = "090210654492"
        foreign = "Нет"
        gender = "Женский"
        dob = "10.02.2009"
        phone = "+7 747 199 03 62"
        email = "azievaaqerke@gmail.com"
        address = "Қызылорда облысы, Шиелі ауданы"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Аймаханов Талғат Әзиұлы"
        mother = "Атаханова Гүлнұр Айтбековна"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Спорт кешені"
        motherJob = "Спорт кешені"
        guardianJob = "—"
        fatherPhone = "+7 747 199 03 62"
        motherPhone = "+7 747 199 03 62"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 10
        fio = "Бахтиярова Құрбанай Бабирқызы"
        iin = "081208653345"
        foreign = "Нет"
        gender = "Женский"
        dob = "08.12.2008"
        phone = "+7 771 226 07 64"
        email = "kurbanay071221@gmail.com"
        address = "Сауран ауданы, 30 жылдық ауыл, Темірқорған 44 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Аубакиров Бабир"
        mother = "Сүлейменова Мавжуда"
        guardian = "—"
        fatherEdu = "Техническое и профессиональное"
        motherEdu = "Техническое и профессиональное"
        fatherJob = "Жұмыссыз"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 747 611 86 61"
        motherPhone = "+7 705 857 50 83"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 6
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 11
        fio = "Газиханова Севинч Азизқызы"
        iin = "090805651016"
        foreign = "Нет"
        gender = "Женский"
        dob = "05.08.2009"
        phone = "+7 776 834 79 00"
        email = "sgazikhanova@gmail.com"
        address = "Сауран ауданы, Бершінтөбе ауылы, 58 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Дадашов Азиз"
        mother = "Юнусова Хумора"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "«Тұран Су» мекемесі"
        motherJob = "Үй шаруасында"
        guardianJob = "—"
        fatherPhone = "+7 771 382 27 28"
        motherPhone = "+7 777 044 48 45"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 5
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 12
        fio = "Диметов Хайтбой Абдиқодирұлы"
        iin = "081001554699"
        foreign = "Нет"
        gender = "Мужской"
        dob = "01.10.2008"
        phone = "+7 705 350 54 18"
        email = "dimetovhaytbay@gmail.com"
        address = "Сауран ауданы, Қарашық ауылы, С.Жамалов 40 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Диметов Абдиқодир"
        mother = "Анарбаева Мукаррам"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Зейнеткер"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 705 675 12 08"
        motherPhone = "+7 705 675 12 08"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 2
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 13
        fio = "Егізбек Толғанай Ерболатқызы"
        iin = "080613650706"
        foreign = "Нет"
        gender = "Женский"
        dob = "13.06.2008"
        phone = "+7 705 491 54 69"
        email = "tolganaiegizbek0@gmail.com"
        address = "Түркістан қаласы, Жаңа қала 9 көше, 17/2 үй"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Молдашбаев Ерболат"
        mother = "Омарова Гүлайым"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жұмыссыз"
        motherJob = "Техникалық қызметкер (Техничка)"
        guardianJob = "—"
        fatherPhone = "+7 705 491 54 69"
        motherPhone = "+7 705 491 54 69"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 7
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 14
        fio = "Жақсыбек Жанкелді Бекайдарұлы"
        iin = "080207550366"
        foreign = "Нет"
        gender = "Мужской"
        dob = "07.02.2008"
        phone = "+7 747 030 97 86"
        email = "zankeldizaksybek50@gmail.com"
        address = "Қызылорда облысы, Жаңақорған ауданы, Зұлпыхар Байзақов 86"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Әуелбеков Бекайдар Жақсыбекұлы"
        mother = "Күлатаева Гүлсім Шермағанбетқызы"
        guardian = "—"
        fatherEdu = "Техническое и профессиональное"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "Жезқазған «Bass cold», машинист-погрузчик"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 702 905 01 78"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Один из родителей работает за границей/в другом городе"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 15
        fio = "Каримова Дурдона Дилшодқызы"
        iin = "081215652948"
        foreign = "Нет"
        gender = "Женский"
        dob = "15.12.2008"
        phone = "+7 700 321 20 08"
        email = "durdonna08@gmail.com"
        address = "Түркістан қаласы, Алтай 72"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Абдижалилов Дилшод"
        mother = "Назарова Дилнора"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Зауытта жұмысшы"
        motherJob = "Зауытта жұмысшы"
        guardianJob = "—"
        fatherPhone = "+7 775 361 69 04"
        motherPhone = "+7 775 361 69 04"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 4
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 16
        fio = "Касымова Шодиена Бахтиярқызы"
        iin = "080822655159"
        foreign = "Нет"
        gender = "Женский"
        dob = "22.08.2008"
        phone = "+7 771 277 24 07"
        email = "shadianakasymova@gmail.com"
        address = "Сауран ауданы, Шорнақ ауылы, С.Сейфуллин 3 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Айтқулов Бахтияр"
        mother = "Халметова Халида"
        guardian = "—"
        fatherEdu = "Высшее, послевузовское"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "Жеке кәсіпкер"
        motherJob = "Жеке кәсіпкер"
        guardianJob = "—"
        fatherPhone = "+7 771 544 55 55"
        motherPhone = "+7 705 294 71 98"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 17
        fio = "Кәрібай Қарақат Тоқтарбайқызы"
        iin = "090815654144"
        foreign = "Нет"
        gender = "Женский"
        dob = "15.08.2009"
        phone = "+7 776 852 02 52"
        email = "karibaykarakat@gmail.com"
        address = "Қызылорда облысы, Шиелі ауданы, Құлтаев 14"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Сыздықов Тоқтарбай Кәрібайұлы"
        mother = "Алтынбекова Айгерим Тулепбергеновна"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "Жұмыссыз"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 776 852 02 52"
        motherPhone = "+7 776 852 02 52"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 18
        fio = "Көлегенова Гүлсезім"
        iin = "080911653542"
        foreign = "Нет"
        gender = "Женский"
        dob = "11.09.2008"
        phone = "+7 705 570 33 08"
        email = "gulsezimkolegen@gmail.com"
        address = "Жаңақорған ауданы, Қаратөбе ауылы, Т.Тоқтаров 10"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Әлсейтов Қоныс"
        mother = "Рысдаулетова Ұлболсын"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жұмыссыз"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 705 570 33 08"
        motherPhone = "+7 705 570 33 08"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 6
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 19
        fio = "Қасымбек Әлдекей Сейтмұратұлы"
        iin = "090109554398"
        foreign = "Нет"
        gender = "Мужской"
        dob = "09.01.2009"
        phone = "+7 775 531 25 35"
        email = "aldekejkasymbek@gmail.com"
        address = "Түркістан қаласы, Шорнақ 16"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Қасымбек Сейтмұрат"
        mother = "Бекжасарова Роза"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Техническое и профессиональное"
        fatherJob = "—"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 775 531 25 35"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 20
        fio = "Махмут Дамир Махмутұлы"
        iin = "090704554085"
        foreign = "Нет"
        gender = "Мужской"
        dob = "04.07.2009"
        phone = "+7 775 379 53 23"
        email = "zakkofako@gmail.com"
        address = "Түркістан қаласы, Үсен Дүйсенұлы 99/1"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Ажырасқан (бірге тұрмайды)"
        mother = "Мекебаева Мадина Абдилатовна"
        guardian = "—"
        fatherEdu = "—"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "—"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 775 379 53 23"
        familyType = "Неполная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Неполная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Развод родителей"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 21
        fio = "Муратова Шадиена Мирзахметқызы"
        iin = "090228653501"
        foreign = "Нет"
        gender = "Женский"
        dob = "28.02.2009"
        phone = "+7 771 887 38 56"
        email = "Shadiena280209@gmail.com"
        address = "Сауран ауданы, Шорнақ ауылы, Сапар 31 үй"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Юсупов Мирзахмет"
        mother = "Низаева Айгүл"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жұмыссыз"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 771 887 38 56"
        motherPhone = "+7 771 887 38 56"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 6
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 22
        fio = "Насирлла Інжу Медетқызы"
        iin = "090430653173"
        foreign = "Нет"
        gender = "Женский"
        dob = "30.04.2009"
        phone = "+7 775 306 60 58"
        email = "nasyrllainzu@gmail.com"
        address = "Түркістан қаласы, Көкжелек 11"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Егенбердиев Медет"
        mother = "Жумашева Назгүл"
        guardian = "—"
        fatherEdu = "Высшее, послевузовское"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "Жеке кәсіпкерлік"
        motherJob = "Жеке кәсіпкерлік"
        guardianJob = "—"
        fatherPhone = "+7 705 698 14 84"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 5
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 23
        fio = "Нематжанова Орзу Азизқызы"
        iin = "090507654193"
        foreign = "Нет"
        gender = "Женский"
        dob = "07.05.2009"
        phone = "+7 778 249 92 56"
        email = "Orzunematjanova@gmail.com"
        address = "Түркістан қаласы, Гаухар батыр 70"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Юсупов Азиз"
        mother = "Юсупова Гүлбахар"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жиһаз ұстасы"
        motherJob = "Аспаз"
        guardianJob = "—"
        fatherPhone = "+7 702 377 35 07"
        motherPhone = "+7 702 043 96 08"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 24
        fio = "Оспан Қарақат Мейрамбекқызы"
        iin = "090105652990"
        foreign = "Нет"
        gender = "Женский"
        dob = "05.01.2009"
        phone = "+7 707 188 01 05"
        email = "mejrambekkyzykarakat35@gmail.com"
        address = "Қызылорда облысы, Жаңақорған ауданы, Ә.Молдағұлова 61"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Асанов Мейрамбек Оспанович"
        mother = "Бейсенбай Нұргүл Арыстанқызы"
        guardian = "—"
        fatherEdu = "Высшее, послевузовское"
        motherEdu = "Высшее, послевузовское"
        fatherJob = "Вахталық жұмыс"
        motherJob = "№169 мектеп мұғалімі"
        guardianJob = "—"
        fatherPhone = "+7 707 253 14 50"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Один из родителей работает за границей/в другом городе"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 25
        fio = "Рустамов Бехзат Алишерұлы"
        iin = "090926550307"
        foreign = "Нет"
        gender = "Мужской"
        dob = "26.09.2009"
        phone = "+7 778 625 39 08"
        email = "rustamovbekzat33@gmail.com"
        address = "Түркістан қаласы, Коммунизм, Серт 44"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Убашов Алишер"
        mother = "Убашова Мадина"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке кәсіпкер"
        motherJob = "«Бірлік» емханасы"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "+7 707 798 87 19"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 5
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 26
        fio = "Сейткаримова Айсу"
        iin = "090824650254"
        foreign = "Нет"
        gender = "Женский"
        dob = "24.08.2009"
        phone = "+7 778 371 13 61"
        email = "saytkarimovaaysu@gmail.com"
        address = "Сауран ауданы, 30 жылдық ауылы, Қазыбек би 12"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Юлдашев Шухрат"
        mother = "Юлдашева Гүлмира"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке кәсіпкерлік"
        motherJob = "Үй шаруасында"
        guardianJob = "—"
        fatherPhone = "+7 778 371 13 61"
        motherPhone = "+7 778 371 13 61"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 6
        socCat = "Многодетная семья"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 27
        fio = "Секентай Мағжан Рустемұлы"
        iin = "090621552395"
        foreign = "Нет"
        gender = "Мужской"
        dob = "21.06.2009"
        phone = "+7 776 337 04 42"
        email = "magjansekentay@gmail.com"
        address = "Сауран ауданы, Құмтүйін ауылы, А. Төлепберген көшесі"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Казах"
        father = "Бегалы Рустем"
        mother = "Қожахметова Күлайша"
        guardian = "—"
        fatherEdu = "Техническое и профессиональное (Суретші)"
        motherEdu = "Техническое и профессиональное (Дизайнер)"
        fatherJob = "Жеке кәсіпкер"
        motherJob = "Үй шаруасында"
        guardianJob = "—"
        fatherPhone = "+7 776 311 68 68"
        motherPhone = "+7 705 370 83 27"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 4
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 28
        fio = "Файзулла Умиджан Садуллаұлы"
        iin = "090825500113"
        foreign = "Нет"
        gender = "Мужской"
        dob = "25.08.2009"
        phone = "+7 707 817 00 83"
        email = "sermetovsadulla2@gmail.com"
        address = "Түркістан қаласы, Жәнібек батыр 66 үй"
        areaType = "Город"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Шерметов Садулла Файзуллаұлы"
        mother = "Шерметова Гүлнора Маккамбаевна"
        guardian = "—"
        fatherEdu = "Высшее, послевузовское"
        motherEdu = "Среднее"
        fatherJob = "Арман-М school мектебі, мұғалім"
        motherJob = "Жұмыссыз"
        guardianJob = "—"
        fatherPhone = "+7 777 038 67 05"
        motherPhone = "+7 771 828 22 84"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 3
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    },
    @{
        num = 29
        fio = "Хакимжанов Бехруз"
        iin = "081207552474"
        foreign = "Нет"
        gender = "Мужской"
        dob = "07.12.2008"
        phone = "+7 705 377 08 01"
        email = "—"
        address = "Сауран ауданы, 30 жылдық ауылы, А. Навои 60"
        areaType = "Село"
        houseType = "Частный дом"
        nat = "Другая национальность (Өзбек)"
        father = "Хакимжанов (көрсетілмеген)"
        mother = "Көрсетілмеген"
        guardian = "—"
        fatherEdu = "Среднее"
        motherEdu = "Среднее"
        fatherJob = "Жеке меншік"
        motherJob = "Үй шаруасында"
        guardianJob = "—"
        fatherPhone = "—"
        motherPhone = "—"
        familyType = "Полная семья"
        stepparent = "Жоқ"
        kidsCount = 2
        socCat = "Жоқ"
        eduCat = "обучающиеся и воспитанники, не относящиеся к категориям, указанным в других пунктах настоящего перечня"
        govService = "Не относится к получателям государственных услуг указанных выше"
        behavior = "Изменений не наблюдается"
        socEnv = "Стабильная, положительная среда; Хорошо общается с друзьями"
        relGroup = "Хорошие"
        relFriends = "Хорошие"
        conflicts = "Не наблюдались"
        relTeachers = "Хорошие; Отношения уважительные"
        bullying = "Не наблюдались"
        difficultSit = "Трудная ситуация не наблюдается"
        conclusion = "Факторы риска не наблюдаются"
    }
)

# Build HTML string
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<!DOCTYPE html>')
[void]$sb.AppendLine('<html lang="kk">')
[void]$sb.AppendLine('<head>')
[void]$sb.AppendLine('<meta charset="UTF-8">')
[void]$sb.AppendLine('<title>Әлеуметтік паспорт және бақылау картасы</title>')
[void]$sb.AppendLine('<style>')
[void]$sb.AppendLine('body { font-family: "Calibri", "Arial", sans-serif; font-size: 11pt; color: #1a1a1a; line-height: 1.35; margin: 20px; }')
[void]$sb.AppendLine('.header-title { text-align: center; font-weight: bold; font-size: 15pt; color: #1b365d; text-transform: uppercase; margin-bottom: 4px; }')
[void]$sb.AppendLine('.header-sub { text-align: center; font-size: 12pt; color: #333333; margin-bottom: 2px; }')
[void]$sb.AppendLine('.header-info { text-align: center; font-size: 10.5pt; color: #555555; margin-bottom: 20px; border-bottom: 2px solid #1b365d; padding-bottom: 12px; }')
[void]$sb.AppendLine('.student-card { page-break-inside: avoid; border: 1.5px solid #1b365d; border-radius: 6px; margin-bottom: 25px; padding: 12px 16px; background-color: #ffffff; }')
[void]$sb.AppendLine('.student-header { background-color: #1b365d; color: #ffffff; font-weight: bold; font-size: 12pt; padding: 6px 12px; margin: -12px -16px 12px -16px; border-radius: 4px 4px 0 0; }')
[void]$sb.AppendLine('.section-title { font-weight: bold; font-size: 11pt; color: #1b365d; margin-top: 10px; margin-bottom: 5px; border-bottom: 1px solid #c0d1e5; padding-bottom: 2px; }')
[void]$sb.AppendLine('table.data-table { width: 100%; border-collapse: collapse; margin-bottom: 10px; font-size: 10.5pt; }')
[void]$sb.AppendLine('table.data-table td { padding: 4px 8px; border: 1px solid #dcdcdc; vertical-align: top; }')
[void]$sb.AppendLine('table.data-table td.field-name { width: 38%; font-weight: bold; background-color: #f7f9fc; color: #2c3e50; }')
[void]$sb.AppendLine('table.data-table td.field-val { width: 62%; background-color: #ffffff; color: #111111; }')
[void]$sb.AppendLine('.summary-table { width: 100%; border-collapse: collapse; font-size: 9.5pt; margin-bottom: 30px; }')
[void]$sb.AppendLine('.summary-table th { background-color: #1b365d; color: #ffffff; padding: 6px; border: 1px solid #1b365d; text-align: center; }')
[void]$sb.AppendLine('.summary-table td { padding: 4px 6px; border: 1px solid #cccccc; vertical-align: middle; }')
[void]$sb.AppendLine('.badge-multi { background-color: #e8f4fd; color: #0b5394; font-weight: bold; padding: 2px 6px; border-radius: 4px; }')
[void]$sb.AppendLine('.badge-incomp { background-color: #fce5cd; color: #b45f06; font-weight: bold; padding: 2px 6px; border-radius: 4px; }')
[void]$sb.AppendLine('</style>')
[void]$sb.AppendLine('</head>')
[void]$sb.AppendLine('<body>')

# Header
[void]$sb.AppendLine('<div class="header-title">«Түркістан жоғары көпсалалы, қолөнер колледжі» МКҚК</div>')
[void]$sb.AppendLine('<div class="header-sub"><b>Оқу тобының әлеуметтік паспорты және кураторлық бақылау карточкалары</b></div>')
[void]$sb.AppendLine('<div class="header-info">')
[void]$sb.AppendLine('<b>Оқу жылы:</b> 2026-2027 жж. &nbsp;|&nbsp; <b>Оқу тобы:</b> ТБ-26-11 &nbsp;|&nbsp; <b>Топ кураторы:</b> Әлімхан Нұрсұлтан<br>')
[void]$sb.AppendLine('<b>Мамандығы:</b> 06130100 - «Бағдарламалық қамтамасыз ету (түрлері бойынша)»<br>')
[void]$sb.AppendLine('<b>Біліктілігі:</b> 4S 06130103 - «Бағдарламалық қамтамасыздандыруды құрастырушысы»<br>')
[void]$sb.AppendLine('<b>Топтағы жалпы студент саны:</b> 29 (Ұлдар саны: 10, Қыздар саны: 19)')
[void]$sb.AppendLine('</div>')

# Summary Table First
[void]$sb.AppendLine('<h3 style="color:#1b365d; margin-bottom: 8px;">І. ТБ-26-11 тобы студенттерінің жиынтық кестесі</h3>')
[void]$sb.AppendLine('<table class="summary-table">')
[void]$sb.AppendLine('<thead>')
[void]$sb.AppendLine('<tr>')
[void]$sb.AppendLine('<th style="width:4%;">№</th>')
[void]$sb.AppendLine('<th style="width:23%;">Студенттің аты-жөні</th>')
[void]$sb.AppendLine('<th style="width:13%;">ЖСН (ИИН)</th>')
[void]$sb.AppendLine('<th style="width:6%;">Ұлты</th>')
[void]$sb.AppendLine('<th style="width:14%;">Байланыс телефоны</th>')
[void]$sb.AppendLine('<th style="width:13%;">Отбасы құрамы</th>')
[void]$sb.AppendLine('<th style="width:13%;">Әлеуметтік мәртебесі</th>')
[void]$sb.AppendLine('<th style="width:14%;">Қиын жағдайлар</th>')
[void]$sb.AppendLine('</tr>')
[void]$sb.AppendLine('</thead>')
[void]$sb.AppendLine('<tbody>')

foreach ($s in $students) {
    $rowBg = if ($s.num % 2 -eq 0) { 'background-color:#f9fbfd;' } else { 'background-color:#ffffff;' }
    $socBadge = if ($s.socCat -like "*Многодетная*") {
        '<span class="badge-multi">Көпбалалы</span>'
    } elseif ($s.socCat -like "*Ребенок, оставшийся*" -or $s.socCat -like "*Неполная*") {
        '<span class="badge-incomp">Толық емес / Жартылай жетім</span>'
    } else {
        'Қалыпты'
    }
    
    [void]$sb.AppendLine("<tr style='$rowBg'>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.num)</td>")
    [void]$sb.AppendLine("<td><b>$($s.fio)</b></td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.iin)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$(if ($s.nat -like '*Казах*') {'Қазақ'} else {'Өзбек'})</td>")
    [void]$sb.AppendLine("<td>$($s.phone)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.familyType)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$socBadge</td>")
    [void]$sb.AppendLine("<td>$($s.difficultSit)</td>")
    [void]$sb.AppendLine("</tr>")
}
[void]$sb.AppendLine('</tbody>')
[void]$sb.AppendLine('</table>')

[void]$sb.AppendLine('<div style="page-break-before: always;"></div>')
[void]$sb.AppendLine('<h3 style="color:#1b365d; margin-bottom: 15px;">ІІ. Әрбір студенттің толық әлеуметтік паспорты және бақылау карточкасы</h3>')

# Individual Student Cards
foreach ($s in $students) {
    [void]$sb.AppendLine('<div class="student-card">')
    [void]$sb.AppendLine("<div class=\"student-header\">$($s.num). $($s.fio)</div>")
    
    # 1. Main Info
    [void]$sb.AppendLine('<div class="section-title">1. Негізгі мәліметтер (Основные данные студента)</div>')
    [void]$sb.AppendLine('<table class="data-table">')
    [void]$sb.AppendLine("<tr><td class='field-name'>ФИО студента:</td><td class='field-val'><b>$($s.fio)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>ИИН студента (12 цифр):</td><td class='field-val'><b>$($s.iin)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Иностранный гражданин:</td><td class='field-val'>$($s.foreign)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Пол:</td><td class='field-val'>$($s.gender)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Туған күні / Эл. пошта:</td><td class='field-val'>$($s.dob) &nbsp;|&nbsp; $($s.email)</td></tr>")
    [void]$sb.AppendLine('</table>')
    
    # 2. Social Passport
    [void]$sb.AppendLine('<div class="section-title">2. Данные для социального паспорта (Әлеуметтік паспорт)</div>')
    [void]$sb.AppendLine('<table class="data-table">')
    [void]$sb.AppendLine("<tr><td class='field-name'>Национальность:</td><td class='field-val'>$($s.nat)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Отец (ФИО):</td><td class='field-val'>$($s.father)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Мать (ФИО):</td><td class='field-val'>$($s.mother)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Опекун / попечитель:</td><td class='field-val'>$($s.guardian)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Образование отца:</td><td class='field-val'>$($s.fatherEdu)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Образование матери:</td><td class='field-val'>$($s.motherEdu)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Место работы отца:</td><td class='field-val'>$($s.fatherJob)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Место работы матери:</td><td class='field-val'>$($s.motherJob)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Место работы опекуна:</td><td class='field-val'>$($s.guardianJob)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Адрес проживания:</td><td class='field-val'>$($s.address)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Место проживания:</td><td class='field-val'><b>$($s.areaType)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Тип жилья:</td><td class='field-val'><b>$($s.houseType)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Телефон отца:</td><td class='field-val'>$($s.fatherPhone)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Телефон матери:</td><td class='field-val'>$($s.motherPhone)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Телефон студента:</td><td class='field-val'><b>$($s.phone)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Состав семьи:</td><td class='field-val'><b>$($s.familyType)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Проживает с отчимом / мачехой:</td><td class='field-val'>$($s.stepparent)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Количество детей в семье:</td><td class='field-val'><b>$($s.kidsCount)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Социальные категории:</td><td class='field-val'><b>$($s.socCat)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Относится к категориям обучающихся:</td><td class='field-val'>$($s.eduCat)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Относится к получателям госуслуг:</td><td class='field-val'>$($s.govService)</td></tr>")
    [void]$sb.AppendLine('</table>')
    
    # 3. Observation Card
    [void]$sb.AppendLine('<div class="section-title">3. Данные для карточки наблюдения (Кураторлық бақылау картасы)</div>')
    [void]$sb.AppendLine('<table class="data-table">')
    [void]$sb.AppendLine("<tr><td class='field-name'>Какие изменения в поведении наблюдались?</td><td class='field-val'>$($s.behavior)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Какая социальная среда у обучающегося?</td><td class='field-val'>$($s.socEnv)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Какие отношения с одногруппниками?</td><td class='field-val'>$($s.relGroup)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Какие отношения с друзьями?</td><td class='field-val'>$($s.relFriends)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Наблюдались ли конфликтные ситуации?</td><td class='field-val'>$($s.conflicts)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Какие отношения с учителями?</td><td class='field-val'>$($s.relTeachers)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Наблюдались ли случаи буллинга?</td><td class='field-val'>$($s.bullying)</td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Есть ли в семье трудные ситуации?</td><td class='field-val'><b>$($s.difficultSit)</b></td></tr>")
    [void]$sb.AppendLine("<tr><td class='field-name'>Общее заключение куратора группы:</td><td class='field-val'><b>$($s.conclusion)</b></td></tr>")
    [void]$sb.AppendLine('</table>')
    
    [void]$sb.AppendLine('</div>')
}

# Footer sign
[void]$sb.AppendLine('<div style="margin-top:30px; padding-top:15px; border-top:1.5px solid #1b365d;">')
[void]$sb.AppendLine('<table style="width:100%; border:none; font-size:11pt;">')
[void]$sb.AppendLine('<tr>')
[void]$sb.AppendLine('<td style="width:50%; border:none;"><b>Топ кураторы:</b> _______________ Әлімхан Нұрсұлтан</td>')
[void]$sb.AppendLine('<td style="width:50%; border:none; text-align:right;"><b>Күні:</b> «____» ____________ 2026 ж.</td>')
[void]$sb.AppendLine('</tr>')
[void]$sb.AppendLine('</table>')
[void]$sb.AppendLine('</div>')

[void]$sb.AppendLine('</body>')
[void]$sb.AppendLine('</html>')

# Write UTF-8 HTML file
[System.IO.File]::WriteAllText($tempHtml, $sb.ToString(), [System.Text.Encoding]::UTF8)

# Convert HTML to DOCX using Word COM
$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open($tempHtml)
    # Save as docx (format 16 = wdFormatDocumentDefault)
    $doc.SaveAs2($tempDocx, 16)
    $doc.Close([ref]$false)
} finally {
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

# Copy to both Desktops
if (Test-Path $desktop1) {
    Copy-Item -Path $tempDocx -Destination "$desktop1\$fileName" -Force
}
if (Test-Path $desktop2) {
    Copy-Item -Path $tempDocx -Destination "$desktop2\$fileName" -Force
}

Write-Output "SUCCESS: Document generated and saved to Desktop: $fileName"
