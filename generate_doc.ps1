$ErrorActionPreference = "Stop"

$desktop1 = "C:\Users\nursu\OneDrive\Desktop"
$desktop2 = "C:\Users\nursu\Desktop"
$fileName = "ТБ-26-11_Студенттердің_әлеуметтік_паспорты_және_бақылау_картасы.docx"
$jsonPath = "c:\Users\nursu\Downloads\antigravity\students.json"
$tempHtml = "$env:TEMP\students_doc.html"
$tempDocx = "$env:TEMP\$fileName"

# Load students from JSON
$jsonText = [System.IO.File]::ReadAllText($jsonPath, [System.Text.Encoding]::UTF8)
$students = $jsonText | ConvertFrom-Json

# Build HTML
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<!DOCTYPE html>')
[void]$sb.AppendLine('<html>')
[void]$sb.AppendLine('<head>')
[void]$sb.AppendLine('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">')
[void]$sb.AppendLine('<title>Әлеуметтік паспорт және бақылау картасы</title>')
[void]$sb.AppendLine('<style>')
[void]$sb.AppendLine('@page { size: A4; margin: 2cm 1.5cm 2cm 1.5cm; }')
[void]$sb.AppendLine('body { font-family: "Calibri", "Arial", sans-serif; font-size: 11pt; color: #1a1a1a; line-height: 1.3; }')
[void]$sb.AppendLine('.header-title { text-align: center; font-weight: bold; font-size: 14pt; color: #1b365d; text-transform: uppercase; margin-bottom: 4px; }')
[void]$sb.AppendLine('.header-sub { text-align: center; font-size: 12pt; color: #222222; margin-bottom: 4px; }')
[void]$sb.AppendLine('.header-info { text-align: center; font-size: 10.5pt; color: #444444; margin-bottom: 20px; border-bottom: 2px solid #1b365d; padding-bottom: 10px; }')
[void]$sb.AppendLine('.student-card { margin-bottom: 30px; border: 1.5px solid #1b365d; }')
[void]$sb.AppendLine('.student-header { background-color: #1b365d; color: #ffffff; font-weight: bold; font-size: 12pt; padding: 6px 12px; }')
[void]$sb.AppendLine('.section-title { font-weight: bold; font-size: 10.5pt; color: #1b365d; background-color: #e9eef4; padding: 5px 10px; border-top: 1px solid #1b365d; border-bottom: 1px solid #1b365d; }')
[void]$sb.AppendLine('table.data-table { width: 100%; border-collapse: collapse; font-size: 10.5pt; }')
[void]$sb.AppendLine('table.data-table td { padding: 4px 8px; border: 1px solid #d5dbe1; vertical-align: top; }')
[void]$sb.AppendLine('table.data-table td.field-name { width: 36%; font-weight: bold; background-color: #f7f9fa; color: #2c3e50; }')
[void]$sb.AppendLine('table.data-table td.field-val { width: 64%; background-color: #ffffff; color: #111111; }')
[void]$sb.AppendLine('.summary-table { width: 100%; border-collapse: collapse; font-size: 9.5pt; margin-bottom: 25px; }')
[void]$sb.AppendLine('.summary-table th { background-color: #1b365d; color: #ffffff; padding: 6px 4px; border: 1px solid #1b365d; text-align: center; }')
[void]$sb.AppendLine('.summary-table td { padding: 4px 5px; border: 1px solid #cccccc; vertical-align: middle; }')
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
[void]$sb.AppendLine('<h3 style="color:#1b365d; margin-bottom: 8px;">І. ТБ-26-11 тобы студенттерінің жиынтық тізімі</h3>')
[void]$sb.AppendLine('<table class="summary-table">')
[void]$sb.AppendLine('<thead>')
[void]$sb.AppendLine('<tr>')
[void]$sb.AppendLine('<th style="width:4%;">№</th>')
[void]$sb.AppendLine('<th style="width:23%;">Студенттің аты-жөні</th>')
[void]$sb.AppendLine('<th style="width:13%;">ЖСН (ИИН)</th>')
[void]$sb.AppendLine('<th style="width:7%;">Ұлты</th>')
[void]$sb.AppendLine('<th style="width:13%;">Байланыс тел.</th>')
[void]$sb.AppendLine('<th style="width:12%;">Отбасы құрамы</th>')
[void]$sb.AppendLine('<th style="width:13%;">Әлеуметтік санаты</th>')
[void]$sb.AppendLine('<th style="width:15%;">Қиын жағдайлар</th>')
[void]$sb.AppendLine('</tr>')
[void]$sb.AppendLine('</thead>')
[void]$sb.AppendLine('<tbody>')

foreach ($s in $students) {
    $rowBg = if ($s.num % 2 -eq 0) { 'background-color:#f9fbfd;' } else { 'background-color:#ffffff;' }
    $natText = if ($s.nat -like "*Казах*") { "Қазақ" } else { "Өзбек" }
    $socText = if ($s.socCat -like "*Многодетная*") {
        "Көпбалалы"
    } elseif ($s.socCat -like "*Ребенок, оставшийся*" -or $s.socCat -like "*Неполная*") {
        "Толық емес / Жетім"
    } else {
        "Қалыпты"
    }

    [void]$sb.AppendLine("<tr style='$rowBg'>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.num)</td>")
    [void]$sb.AppendLine("<td><b>$($s.fio)</b></td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.iin)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$natText</td>")
    [void]$sb.AppendLine("<td>$($s.phone)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$($s.familyType)</td>")
    [void]$sb.AppendLine("<td style='text-align:center;'>$socText</td>")
    [void]$sb.AppendLine("<td>$($s.difficultSit)</td>")
    [void]$sb.AppendLine("</tr>")
}
[void]$sb.AppendLine('</tbody>')
[void]$sb.AppendLine('</table>')

[void]$sb.AppendLine('<br><hr style="border:0; border-top: 1.5px solid #1b365d; margin: 20px 0;"><br>')
[void]$sb.AppendLine('<h3 style="color:#1b365d; margin-bottom: 15px;">ІІ. Әрбір студенттің толық әлеуметтік паспорты және бақылау карточкасы</h3>')

# Individual Student Cards
foreach ($s in $students) {
    [void]$sb.AppendLine('<div class="student-card">')
    [void]$sb.AppendLine("<div class=`"student-header`">$($s.num). $($s.fio)</div>")
    
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
