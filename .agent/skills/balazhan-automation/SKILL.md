---
name: balazhan-automation
description: >-
  Automates data ingestion, Social Passport completion, and Curator Observation Card
  creation on the Kazakhstan National Educational Database portal (balazhan.nedb.kz)
  for college and school teachers/curators using Windows UIAutomation.
---

# Balazhan Portal Automation Skill (`balazhan-automation`)

This skill equips AI agents to automate the tedious questionnaire and profile filling on **Balazhan** (`https://balazhan.nedb.kz/cabinet`), the official educational portal used by colleges and schools in Kazakhstan.

Curators often spend days manually filling out 80+ fields, checkboxes, and radio buttons per student. This skill enables an AI coding assistant to ingest raw class lists (from Word documents, Excel sheets, or JSON) and programmatically populate the portal in seconds via Windows UIAutomation.

---

## 1. Core Rules & Regulatory Logic

> [!IMPORTANT]
> **Strict Under-18 Rule:**
> Only students **under 18 years of age** (< 18 as of the current academic year/date) must be added and tracked in Balazhan. Adult students (18+) must be skipped.
> - Calculate student age dynamically: `Age = AcademicYear - BirthYear`.
> - If `Age >= 18`, log `[Skip] Student is adult` and proceed to the next record.

> [!NOTE]
> **Completion Status Requirement:**
> To change a student's card status from **«Не заполнен»** to **«Заполнен 1 сем. 2 сем.»**, two components must be saved:
> 1. **Социальный паспорт** (Social Passport): Student identifiers, parents' education & work, residence, housing type, family structure, and social category.
> 2. **Карточка наблюдения куратора** (Curator Observation Card): Behavioral, psychological, relational, and risk assessments for Semester 1 and Semester 2.

---

## 2. System Architecture

The automation uses direct **Windows UIAutomation (UIA)** in C# attached to Google Chrome's native window (`Chrome_WidgetWin_1`).

```
+-------------------------------------------------------------+
| Teacher Data Input (Word docx / Excel xlsx / JSON)          |
+-------------------------------------------------------------+
                              |
                              v
+-------------------------------------------------------------+
| AI Agent Ingestion & Age Filtering (Strict Age < 18 Filter) |
+-------------------------------------------------------------+
                              |
                              v
+-------------------------------------------------------------+
| BalazhanEngine (C# UIAutomation with STA Desktop Attachment)|
+-------------------------------------------------------------+
                              |
       +----------------------+----------------------+
       |                                             |
       v                                             v
[1. Добавить 1 студента]             [2. Карточка наблюдения]
- ФИО, ИИН, Жынысы / Пол            - Қарым-қатынас / Отношения
- Ата-анасы / Родители               - Мінез-құлық / Поведение
- Мекенжайы / Адрес                  - Тәуекелдер / Риски
- Әлеуметтік санат / Категории       - Статусы: «Заполнен»
```

### Windows Session & Desktop Station Handling
When running inside virtual or agent sessions (e.g. Session 4, non-interactive service station), UIAutomation cannot query the desktop root by default. The engine automatically handles this via:
```csharp
IntPtr hDesk = OpenDesktop("default", 0, false, 0x01FF);
SetThreadDesktop(hDesk);
```
All UIAutomation calls run in a dedicated `ApartmentState.STA` background thread.

---

## 3. Step-by-Step Execution Runbook

### Step 1: Verify Chrome Portal Session
1. Ensure Google Chrome is open and logged into `https://balazhan.nedb.kz/cabinet`.
2. Navigate to the student list of your group/class (e.g., `ТБ-26-11`).
3. Verify the browser window title contains `BALAZHAN - Google Chrome`.

### Step 2: Prepare Student Dataset
Format the student data as JSON matching `templates/students_template.json` or CSV matching `templates/students_template.csv`.

Required keys for each student:
- `num`: Sequential index
- `fio`: Full student name (Cyrillic)
- `iin`: 12-digit Individual Identification Number
- `dob`: Date of birth (`dd.MM.yyyy`)
- `gender`: `"Мужской"` or `"Женский"`
- `father`, `mother`, `guardian`: Parent/guardian full names
- `fatherEdu`, `motherEdu`: `"Высшее, послевузовское"`, `"Техническое и профессиональное"`, `"Среднее"`, or `"Другое"`
- `fatherJob`, `motherJob`: Workplaces
- `address`: Full residential address
- `areaType`: `"Город"` or `"Село"`
- `houseType`: `"Квартира"`, `"Частный дом"`, `"Общежитие"`, etc.
- `motherPhone`, `fatherPhone`, `phone`: Contact numbers
- `familyType`: `"Полная семья"` or `"Неполная семья"`
- `kidsCount`: Number of children in the family
- `socCat`: Social categories (e.g. `"Многодетная семья"`, `"-"`)
- `difficultSit`: Difficult life situations (or `"-"`)

### Step 3: Run Social Passport Automation
Run the PowerShell launcher:
```powershell
powershell -ExecutionPolicy Bypass -File .\automation\sync_students.ps1 -JsonPath "..\students.json" -MaxAge 18 -Action SocialPassport
```

The engine will:
1. Iterate through students under 18.
2. Click **«Добавить студента»** -> **«ОДИН СТУДЕНТ»**.
3. Fill 14 text fields via `ValuePattern`.
4. Select 6 radio groups via `SelectionItemPattern`.
5. Select combobox (Gender) via `ValuePattern`.
6. Toggle applicable social checkboxes via `TogglePattern`.
7. Click **«Добавить студента»** to save.

### Step 4: Run Curator Observation Cards
To complete the observation cards and turn status to **«Заполнен 1 сем. 2 сем.»**:
1. Open student profile in Balazhan.
2. Run:
```powershell
powershell -ExecutionPolicy Bypass -File .\automation\sync_students.ps1 -Action ObservationCard
```
The engine toggles standard positive observation indicators and clicks **«Сохранить карточку»**.

---

## 4. UI Control Index Reference

### Modal «Добавить 1 студента» (14 Edit Fields, 6 Radio Groups, 105 Checkboxes)
- **Edit Fields:**
  - `edits[1]`: ФИО студента
  - `edits[2]`: ИИН студента (12 digits)
  - `edits[3]`: Отец (ФИО)
  - `edits[4]`: Мать (ФИО)
  - `edits[5]`: Опекун / попечитель
  - `edits[6]`: Место работы отца
  - `edits[7]`: Место работы матери
  - `edits[8]`: Место работы опекуна
  - `edits[9]`: Адрес проживания
  - `edits[10]`: Телефон матери
  - `edits[11]`: Телефон отца
  - `edits[12]`: Телефон студента
  - `edits[13]`: Количество детей в семье

- **Radio Groups:**
  - `radios[0, 1]`: Национальность (0 = Казах, 1 = Другая)
  - `radios[2..5]`: Образование отца (2=Высшее, 3=ТиПО, 4=Среднее, 5=Другое)
  - `radios[6..9]`: Образование матери (6=Высшее, 7=ТиПО, 8=Среднее, 9=Другое)
  - `radios[10, 11]`: Место проживания (10=Город, 11=Село)
  - `radios[12..15]`: Тип жилья (12=Квартира, 13=Частный дом, 14=Общежитие, 15=Другое)
  - `radios[16, 17]`: Состав семьи (16=Полная, 17=Неполная)

- **Key Checkboxes:**
  - `chk[4]`: Многодетная семья
  - `chk[28]`: Не относящиеся к категориям
  - `chk[35]`: Не относится к госуслугам
  - `chk[47]`: Стабильная среда
  - `chk[54]`: Отношения с одногруппниками: Хорошие
  - `chk[61]`: Отношения с друзьями: Хорошие
  - `chk[68]`: Конфликты: Не наблюдались
  - `chk[75]`: Отношения с учителями: Хорошие
  - `chk[82]`: Буллинг: Не наблюдались
  - `chk[96]`: Трудные жизненные ситуации отсутствуют
  - `chk[102]`: Факторы риска не наблюдаются

---

## 5. Troubleshooting & Best Practices

1. **PowerShell Cyrillic Encoding:**
   Always keep strings in UTF-8. Never pass Cyrillic string literals directly through raw PowerShell 5.1 CLI parameters; pass JSON file paths and let C# `File.ReadAllText(path, Encoding.UTF8)` handle parsing.
2. **Timing & Animation:**
   Add 200–500ms delay between modal opening and control querying to allow Vue/React DOM elements to finish rendering.
3. **Chrome Zoom & DPI:**
   Keep Chrome at standard 100% zoom. UIAutomation works with bounding coordinates and pattern providers regardless of window position.
