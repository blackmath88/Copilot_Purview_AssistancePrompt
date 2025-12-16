# 🔍 Copilot Purview Assistance Prompt

**Analysiere deine Microsoft Purview Konfiguration mit AI und erhalte Swiss FADP-optimierte Empfehlungen.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)](https://github.com/PowerShell/PowerShell)
[![SC-401](https://img.shields.io/badge/Microsoft-SC--401-red)](https://learn.microsoft.com/en-us/credentials/certifications/information-security-administrator/)

Entwickelt für **SC-401 Training Participants** und IT Professionals, die ihre Purview-Konfiguration optimieren möchten.

---

## 🎯 Was macht dieses Tool?

Dieses Repository enthält Tools und Prompts für:

1. **Export:** PowerShell Script exportiert deine Purview Config als JSON
2. **Analyse:** AI (Claude, ChatGPT, Copilot) analysiert Labels, DLP Policies, Retention
3. **Roadmap:** Erhalte einen HTML Report mit:
   - ✅ Current State Assessment
   - 🇨🇭 Swiss FADP Gap Analysis  
   - 📅 4-Wochen Implementation Roadmap
   - 💡 Quick Wins & Prioritäten

---

## 🚀 Quick Start (5 Minuten)

### Schritt 1: Clone das Repo
```bash
git clone https://github.com/blackmath88/Copilot_Purview_AssistancePrompt.git
cd Copilot_Purview_AssistancePrompt
```

### Schritt 2: Export deine Purview Config
```powershell
# Navigiere zu scripts/
cd scripts

# Führe Export aus
.\Export-PurviewConfig.ps1

# Output: Purview_Export_[timestamp].json auf deinem Desktop
```

**Was wird exportiert:**
- ✅ Sensitivity Labels (Name, Priority, Encryption)
- ✅ DLP Policies (Locations, Mode, Rules)
- ✅ DLP Rules (Conditions, Actions, Priority)
- ✅ Retention Policies
- ✅ Statistics & Metadata

---

### Schritt 3: Analysiere mit AI

#### Option A: Claude.ai (Empfohlen)

1. Gehe zu [claude.ai](https://claude.ai)
2. Öffne `prompts/ANALYZER_PROMPT.md` aus diesem Repo
3. Kopiere den kompletten System Prompt
4. Starte neuen Chat in Claude
5. Paste den Prompt als erste Nachricht
6. Upload dein JSON File **oder** paste den Inhalt
7. Claude generiert deinen HTML Report
8. Kopiere das HTML und speichere als `.html` Datei

#### Option B: ChatGPT / Copilot

Gleicher Workflow - nutze denselben Prompt aus `prompts/ANALYZER_PROMPT.md`

---

### Schritt 4: Review deinen Report
```powershell
# Öffne den generierten HTML Report
start .\Purview_Analysis_Report.html
```

**Der Report zeigt dir:**
- 📊 Configuration Overview (Labels, Policies, Rules)
- 🇨🇭 Swiss FADP Compliance Score (0-100%)
- ⚠️ Identified Gaps & Risks
- 🎯 4-Week Implementation Roadmap
- 💡 Quick Wins (< 1 week implementation)
- 📋 Action Items mit Prioritäten
- 💻 Ready-to-use PowerShell Scripts

---

## 📖 Detaillierte Dokumentation

### Export Script Features

**Standard Export:**
```powershell
.\Export-PurviewConfig.ps1
```
Exportiert: Labels, DLP Policies, Rules, Retention, Statistics

**Erweiteter Export mit Details:**
```powershell
.\Export-PurviewConfig.ps1 -Detailed
```
Zusätzlich: Sensitive Info Types, Insider Risk (wenn verfügbar)

**Custom Output Path:**
```powershell
.\Export-PurviewConfig.ps1 -OutputPath "C:\MyExports"
```

**Quick Export (Minimal):**
```powershell
.\Quick-Export.ps1
```
Nur: Labels und DLP Policies (schneller für erste Tests)

---

## 🎓 Für SC-401 Kursteilnehmer

### Learning Journey Integration

Dieses Tool unterstützt deine SC-401 Learning Journey:

**Week 1 - Information Protection:**
- ✅ Export deine Lab-Config
- ✅ Analysiere Label-Struktur  
- ✅ Identifiziere Optimierungen
- 📝 **Deliverable:** Optimized Label Taxonomy

**Week 2 - DLP Implementation:**
- ✅ Export inkl. DLP Rules
- ✅ Analysiere Policy Coverage
- ✅ Design Swiss-specific Policies
- 📝 **Deliverable:** Swiss DLP Implementation Plan

**Week 3 - Compliance & Governance:**
- ✅ Complete Export (all components)
- ✅ FADP Gap Analysis
- ✅ Create Remediation Roadmap
- 📝 **Deliverable:** Compliance Assessment Report

### Learning Objectives

Mit diesem Tool lernst du:
- ✅ Purview Configuration via PowerShell exportieren
- ✅ Configuration Analysis durchführen
- ✅ Swiss FADP Requirements verstehen & implementieren
- ✅ Implementation Roadmaps erstellen
- ✅ AI-assisted Decision Making für Security
- ✅ PowerShell-basierte Automation

---

## 🇨🇭 Swiss FADP Focus

Dieses Tool ist spezialisiert auf **Swiss Federal Data Protection Act (FADP)** Requirements:

### FADP Coverage

Der Analyzer prüft auf:

- **Art. 5 FADP:** Personal data processing principles
  - ✅ Data classification (Labels)
  - ✅ Purpose limitation (DLP Policies)
  
- **Art. 6 FADP:** Data minimization & retention
  - ✅ Retention Policies konfiguriert?
  - ✅ Auto-deletion nach Retention Period?

- **Art. 16 FADP:** Cross-border data transfers
  - ✅ DLP Rules für External Sharing?
  - ✅ Geo-fencing konfiguriert?

- **Art. 25 FADP:** Data subject rights
  - ✅ eDiscovery für Access Requests?
  - ✅ Deletion workflows implementiert?

### Swiss PII Detection

Der Analyzer empfiehlt DLP Policies für:
- 🇨🇭 AHV/AVS Numbers (Swiss Social Security)
- 🇨🇭 Swiss IBAN Format
- 🇨🇭 Swiss Passport Numbers
- 🇨🇭 Swiss Phone Numbers (+41)

---

## 🔧 Prerequisites

### Software Requirements

- **PowerShell:** 5.1 oder höher
```powershell
  $PSVersionTable.PSVersion
```

- **Exchange Online Management Module:**
```powershell
  Install-Module -Name ExchangeOnlineManagement -Force
```

### Permissions Required

Du benötigst **eine** dieser Rollen in deinem Microsoft 365 Tenant:

- ✅ **Compliance Administrator** (Empfohlen für Training)
- ✅ **Security Administrator**
- ✅ **Global Reader** (Read-Only, reicht für Export)

### Environment

- **Zugang zu:** Microsoft Purview / Security & Compliance Center
- **Empfohlen:** Non-Production / Lab Tenant für Training
- **Optional:** AI Tool mit File Upload (Claude Pro, ChatGPT Plus, Copilot)

---

## 📚 Repository Struktur
```
Copilot_Purview_AssistancePrompt/
│
├── README.md                          ← Du bist hier
│
├── scripts/                           
│   ├── Export-PurviewConfig.ps1      ← Haupt-Export Script
│   └── Quick-Export.ps1              ← Simplified Export
│
├── prompts/
│   ├── ANALYZER_PROMPT.md            ← System Prompt für AI Analysis
│   └── COPILOT_RESEARCHER_BRIEF.md   ← Research Task für Optimierung
│
├── examples/
│   ├── sample_export.json            ← Demo Data (anonymisiert)
│   └── sample_analysis.html          ← Beispiel Report Output
│
└── docs/
    ├── SETUP_GUIDE.md                ← Detaillierte Setup-Anleitung
    └── TROUBLESHOOTING.md            ← Häufige Probleme & Lösungen
```

---

## 🚨 Troubleshooting

### Problem 1: "Module not found"
```powershell
# Überprüfe ob Modul installiert ist
Get-Module -ListAvailable ExchangeOnlineManagement

# Falls nicht da:
Install-Module -Name ExchangeOnlineManagement -Force
Import-Module ExchangeOnlineManagement
```

### Problem 2: "Access Denied"

**Lösung:** Überprüfe deine Rolle im Microsoft 365 Admin Center:
1. Gehe zu [admin.microsoft.com](https://admin.microsoft.com)
2. Users → Active Users → Dein User
3. Roles → Check ob Compliance Admin oder Security Admin assigned

### Problem 3: "Cannot connect to Security & Compliance Center"
```powershell
# Disconnect alte Session
Disconnect-ExchangeOnline -Confirm:$false

# Neu verbinden mit expliziter Authentifizierung
Connect-IPPSSession -UserPrincipalName your-email@domain.com
```

### Problem 4: "No data exported" / Leere JSON

**Mögliche Ursachen:**
- ✅ Frische Umgebung ohne Konfiguration → Normal!
- ✅ Keine Permissions → Check Rollen (siehe oben)
- ✅ Falsche Connection → Nutze `Connect-IPPSSession` nicht `Connect-ExchangeOnline`

**Quick Check:**
```powershell
# Test ob connected
Get-Label

# Sollte Labels zeigen (oder "No labels found" wenn leer)
```

Weitere Hilfe: Siehe `docs/TROUBLESHOOTING.md`

---

## 🤝 Contributing

Verbesserungen sind willkommen! So kannst du beitragen:

1. **Fork** dieses Repository
2. **Create** einen Feature Branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** deine Changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to Branch (`git push origin feature/AmazingFeature`)
5. **Open** einen Pull Request

### Was wir suchen

- 🐛 Bug Fixes im PowerShell Script
- 📝 Verbesserungen am Analyzer Prompt
- 🇨🇭 Zusätzliche Swiss Compliance Checks
- 🌍 Translations (DE, FR, IT für Swiss users)
- 📊 HTML Template Improvements

---

## 📜 License

Dieses Projekt ist lizenziert unter der **MIT License** - siehe [LICENSE](LICENSE) File für Details.

**Nutze es frei für:**
- ✅ Training & Education
- ✅ Internal Company Use
- ✅ Consulting Projects
- ✅ Certification Preparation

---

## 🙏 Credits & Acknowledgments

- **Entwickelt von:** Miro Steibruchmätteli
- **Für:** SC-401 Training Participants
- **Swiss FADP Guidance:** Based on [FDPIC](https://www.edoeb.admin.ch/) recommendations
- **Microsoft Documentation:** [Microsoft Purview](https://learn.microsoft.com/en-us/purview/)

### Special Thanks

- SC-401 Kursteilnehmer für Feedback und Testing
- Microsoft Learn Community
- Swiss IT Security Community

---

## 📞 Support & Contact

- **Issues:** [GitHub Issues](https://github.com/blackmath88/Copilot_Purview_AssistancePrompt/issues)
- **Discussions:** [GitHub Discussions](https://github.com/blackmath88/Copilot_Purview_AssistancePrompt/discussions)
- **SC-401 Questions:** Use repository Discussions

---

## 🔗 Links & Resources

### Microsoft Documentation
- [Microsoft Purview Documentation](https://learn.microsoft.com/en-us/purview/)
- [SC-401 Exam Study Guide](https://learn.microsoft.com/en-us/credentials/certifications/information-security-administrator/)
- [PowerShell for Purview](https://learn.microsoft.com/en-us/powershell/exchange/exchange-online-powershell)

### Swiss Compliance
- [FDPIC - Federal Data Protection Commissioner](https://www.edoeb.admin.ch/)
- [FADP - Federal Act on Data Protection](https://www.fedlex.admin.ch/eli/cc/2022/491/en)

### AI Tools
- [Claude.ai](https://claude.ai) - Empfohlen für diesen Analyzer
- [ChatGPT](https://chat.openai.com)
- [Microsoft Copilot](https://copilot.microsoft.com)

---

## ⭐ Star This Repository

Wenn dieses Tool hilfreich war, gib dem Repo einen ⭐ Star!

Das hilft anderen SC-401 Teilnehmern, es zu finden.

---

**Ready to start?** → [scripts/Export-PurviewConfig.ps1](https://github.com/blackmath88/Copilot_Purview_AssistancePrompt/blob/main/scripts/Export-PurviewConfig.ps1) 🚀
