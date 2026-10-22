# 🚀 Balazhan Educational Portal Automation & AI Agent Skill
### Балажан (balazhan.nedb.kz) порталын автоматтандыру және ИИ агент дағдысы (Skill)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Antigravity Skill](https://img.shields.io/badge/Agent%20Skill-balazhan--automation-blue.svg)](.agent/skills/balazhan-automation/SKILL.md)
[![Graphify Standard](https://img.shields.io/badge/Graphify-Knowledge%20Graph%20v1.0-brightgreen.svg)](graphify-out/GRAPH_REPORT.md)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Chrome-0078D6.svg)](docs/ARCHITECTURE.md)

---

## 🇰🇿 1. Қазақша нұсқаулық (Мұғалімдер мен кураторларға арналған)

### Бұл не және қандай мәселені шешеді?
Қазақстанның әрбір колледж және мектеп кураторы жыл сайын **Балажан** (`https://balazhan.nedb.kz/cabinet`) порталына әр студент бойынша **Әлеуметтік паспорт** пен **Куратордың бақылау картасын** толтыруға мәжбүр. 

Бұл жұмыс:
- Әр студентке **80-нен астам өріс, чекбокс және радио-батырманы** қолмен басуды талап етеді.
- 25–30 студенттен тұратын бір топты толтыруға **кемінде 5–8 сағат** мағынасыз уақыт кетеді.

**Бұл жоба сол жұмысты 2 минутта толық автоматты түрде орындап береді!** 

### Негізгі ережелер:
1. **18 жасқа толмағандар ережесі:** Порталға **тек 18 жасқа толмаған** студенттер ғана енгізіледі. 18-ге толғандар автоматты түрде өткізіліп жіберіледі.
2. **«Заполнен 1 сем. 2 сем.» мәртебесі:** Әлеуметтік паспорт пен бақылау картасы қатар толтырылып, студент мәртебесі ресми түрде толық жабылады.

### Жылдам бастау (Quick Start):
1. **Google Chrome** браузерін ашып, `balazhan.nedb.kz` порталына өз логин-құпиясөзіңізбен кіріп, тобыңыздың тізімін ашып қойыңыз.
2. Студенттер тізімін `templates/students_template.json` немесе Excel арқылы толтырыңыз.
3. PowerShell арқылы мына пәрменді орындаңыз:
```powershell
powershell -ExecutionPolicy Bypass -File .\automation\sync_students.ps1 -JsonPath "..\students.json" -MaxAge 18
```
4. Скрипт экранда Chrome-ды тауып, барлық 18 жасқа толмаған студенттерді жеке-жеке енгізіп, сақтап шығады.

---

## 🇷🇺 2. Инструкция на русском (Для преподавателей и кураторов)

### Для чего предназначен этот проект?
Автоматизация рутинного заполнения данных в системе **Балажан** (`balazhan.nedb.kz`). Избавляет куратора от сотен однотипных кликов при оформлении:
- Личных данных и ИИН студента;
- Сведений о родителях, местах работы, образовании и телефонах;
- Жилищных условий, состава семьи и количества детей;
- Социальных категорий (многодетные, сироты, стабильная среда и т.д.);
- Карточки наблюдения куратора за 1 и 2 семестры (статус переходит в **«Заполнен 1 сем. 2 сем.»**).

### Требования:
- Windows 10 / 11;
- Браузер Google Chrome (авторизованный в кабинете Балажан);
- PowerShell 5.1+ (встроен в любую Windows, ничего дополнительно устанавливать не нужно).

### Запуск одной командой:
```powershell
powershell -ExecutionPolicy Bypass -File .\automation\sync_students.ps1 -JsonPath "..\students.json" -MaxAge 18
```

---

## 🇬🇧 3. English Technical Overview & AI Agent Skill

This project packages the entire Balazhan portal automation pipeline into an **AI Coding Assistant Skill** compatible with:
- **Google Antigravity**
- **Claude Code**
- **Cursor**
- **Gemini CLI / Codex**

### Skill Manifest
The skill is located at [`.agent/skills/balazhan-automation/SKILL.md`](.agent/skills/balazhan-automation/SKILL.md). When mounted, an AI assistant can:
1. Ingest class data directly from teacher Word documents (`.docx`), Excel sheets (`.xlsx`), or raw text.
2. Validate IIN numbers and enforce the strict academic **Under-18 age restriction**.
3. Attach to the interactive Windows session station (`WinSta0\default`) using native Win32 `OpenDesktop` APIs.
4. Drive Chromium's Accessibility Tree without requiring ChromeDriver, Selenium, or node dependencies.

---

## 📊 4. Graphify Knowledge Graph & Architecture

This repository is certified under the **[Graphify Codebase Knowledge Graph Standard (safishamsi/graphify)](https://github.com/safishamsi/graphify)**.

```
graphify-out/
├── graph.json        # Machine-readable knowledge graph (AST calls, UI DOM, data flows)
├── graph.html        # Standalone interactive D3/Vis.js visual graph explorer
└── GRAPH_REPORT.md   # Architectural audit report: 6 communities, 4 god nodes, zero-drift metrics
```

### Knowledge Graph Summary
- **36 Entities (Nodes):** Engine classes, Win32 P/Invoke methods, DOM controls, data schemas, and documentation.
- **64 Relationships (Edges):** `EXTRACTED` AST bindings, `INVOKES`, `SETS_VALUE`, `TOGGLES`, and `AUTOMATES`.
- **6 Modular Subsystems:**
  1. 🟦 `Windows UIAutomation Engine`
  2. 🟥 `Balazhan Portal Web DOM`
  3. 🟩 `Student Data Pipeline`
  4. 🟨 `Curator Observation Workflow`
  5. 🟪 `Agent Skill & CLI Interfaces`
  6. 🟫 `Documentation & Governance`
- **4 Central God Nodes:** `BalazhanEngine`, `students.json`, `balazhan.nedb.kz`, and `SKILL.md`.

👉 **Interactive Visualizer:** Open [`graphify-out/graph.html`](graphify-out/graph.html) directly in any web browser to search nodes, inspect neighbor dependencies, and filter subsystems!

---

## 📁 5. Repository Structure

```
antigravity/
├── .agent/
│   └── skills/
│       └── balazhan-automation/
│           └── SKILL.md                 # Agent Skill definition
├── automation/
│   ├── BalazhanEngine.cs                # Core C# Windows UIA Automation Engine
│   └── sync_students.ps1                # PowerShell CLI entrypoint
├── templates/
│   ├── students_template.json           # Standard student JSON schema
│   ├── students_template.csv            # Excel-ready CSV template
│   └── sample_students.json             # Anonymized sample data
├── docs/
│   ├── BALAZHAN_PORTAL_GUIDE.md         # Teacher manual & field breakdown
│   ├── ARCHITECTURE.md                  # Win32 desktop & UIA technical architecture
│   ├── modal_checkboxes.txt             # 105 social checkbox index reference
│   └── observation_card_details.txt     # 69 observation checkbox index reference
├── graphify-out/
│   ├── graph.json                       # Graphify persistent graph data
│   ├── graph.html                       # Standalone interactive visual graph
│   └── GRAPH_REPORT.md                  # Architectural audit report
├── LICENSE                              # MIT License
├── .gitignore                           # Git ignore rules
└── README.md                            # Tri-lingual documentation
```

---

## 🛠️ 6. How to Push This Repository to GitHub

To publish this project to your GitHub account:

```bash
# 1. Initialize git
git init

# 2. Add files
git add .

# 3. Commit
git commit -m "feat: complete Balazhan automation engine, AI agent skill, and Graphify knowledge graph"

# 4. Link your GitHub remote repository
git remote add origin https://github.com/<your-username>/balazhan-automation.git

# 5. Push to main branch
git branch -M main
git push -u origin main
```

---

## 📜 7. License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details. Free for all educators, teachers, and developers to use, share, and improve.
