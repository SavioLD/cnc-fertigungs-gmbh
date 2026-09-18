# CNC Fertigungs GmbH – Karriere-/Ad-Funnel

Recruiting-Landingpage für die **CNC Fertigungs GmbH** (Gottlieb-Daimler-Straße 39, 89150 Laichingen).
Aufbau 1:1 an der ALWA-Karriereseite orientiert – nur in eigenem CI und mit den beiden aktuellen Stellen.

**Beworbene Stellen (nur diese):**
- CNC-Dreher (m/w/d)
- Rundschleifer (m/w/d)

## Inhalt

- `index.html` – die komplette Seite (self-contained, keine Build-Schritte nötig)
- `supabase-bewerbungen.sql` – legt/aktualisiert den Storage-Bucket für den optionalen Lebenslauf-Upload
- `bilder/` – Hero-Fotos und Logo (siehe unten)
- `creatives/` – Meta-Ads-Creatives (fertig: je Stelle Feed 4:5 + Story 9:16)
- `werbetexte-meta-ads.md` – Anzeigentexte für Meta Ads (Primary Text, Headlines, Descriptions)
- `.nojekyll` – sorgt dafür, dass GitHub Pages die Dateien 1:1 ausliefert

## ⚠️ CI-Farben (bitte prüfen)

Das CI ist an die **Firmenlogo-Farbe** angepasst (Royalblau ≈ `#1a4e8c`, entnommen aus
`md2x-9.png`). Sämtliche Farben stecken als CSS-Variablen ganz oben in `index.html` unter
`:root` (`--brand`, `--brand-dark`, `--brand-700`, `--brand-900`, `--brand-soft`, `--grad`,
`--bg-soft`, `--panel-2`) – ein Ton-Wechsel ist damit ein Ein-Zeilen-Tausch pro Farbe.
`theme-color` (im `<head>`) ist entsprechend gesetzt.

## Bilder (Hero-Fotos + Logo)

**Aktueller Stand – bereits eingebunden:**

- **Logo:** `md2x-9.png` (im Repo-Root) wird automatisch in der Kopfzeile angezeigt.
- **Hero-Fotos:** aus den hochgeladenen Originalfotos (`_DSC7321.jpg`, `_DSC7566.jpg`, `_DSC7119.jpg`)
  wurden **web-optimierte Versionen** erzeugt (1920 px, ~180–310 KB statt 17–20 MB) und
  in `bilder/` abgelegt:
  - `bilder/hero.jpg` – allgemeines Hero-Bild (aus `_DSC7321`, Mitarbeiter an der Maschine)
  - `bilder/cnc-dreher.jpg` – bei `?stelle=cnc-dreher` (aus `_DSC7566`, CLX 450 TC Drehmaschine)
  - `bilder/rundschleifer.jpg` – bei `?stelle=rundschleifer` (aus `_DSC7119`, Rundschleifmaschine)

Die Original-Uploads bleiben unangetastet im Repo-Root liegen (nur nicht direkt eingebunden,
da sie mit 17–18 MB die Ladezeit sprengen würden). Neue/andere Fotos einfach als
`bilder/hero.jpg` · `bilder/cnc-dreher.jpg` · `bilder/rundschleifer.jpg` ablegen
(Querformat, mind. ~1600 px, Motiv rechts – links liegt die Textfläche).

## Stellen-Deeplinks für die Ad

Die Anzeige kann direkt auf eine Stelle verlinken; die Seite wählt sie vor und startet
beim Erfahrungs-Schritt:

- `…/?stelle=cnc-dreher`
- `…/?stelle=rundschleifer`

## Screening (Vorfilterung) mit Punktelogik

Der Funnel stellt **4 Qualifizierungsfragen** (je Antwort ein Score):

1. `erfahrung` – Ausbildung/Berufserfahrung (0–3)
2. `cnc_erfahrung` – Erfahrung an CNC-Maschinen / Steuerung (0–3)
3. `technik` – Zeichnung lesen & Messmittel (0–2)
4. `schicht` – Bereitschaft Zweischichtbetrieb (0–2)

Maximal erreichbar: **10 Punkte**. Eine Bewerbung wird **freundlich abgelehnt**
(**kein Lead** an Leadtable) **nur dann**, wenn die Summe `<= REJECT_AT` ist –
Standard `REJECT_AT = 0`, d. h. **ausschließlich, wenn alle vier Fragen maximal
schlecht** beantwortet wurden. Alles andere geht als Lead durch.

**Strenger/lockerer stellen:** In `index.html` die Variable `REJECT_AT` erhöhen
(z. B. `2`, dann werden auch sehr schwache Profile ausgesteuert) oder die
`data-score`-Werte an den Antworten anpassen. Ein Seiten-Neuladen startet den
Prozess frisch (keine dauerhafte Sperre).

## Bewerbungen (Leadtable)

Jede abgeschlossene Bewerbung wird per Webhook an die **Leadtable-Kachel** der CNC
Fertigungs GmbH gesendet. Felder u. a.: `name` (ein Feld, Vorname + Nachname),
`email`, `telefon`, `stelle`, `erfahrung`, `cnc_erfahrung`, `technik`, `schicht`,
`qualifikation_score`, `lebenslauf`, `datenschutz`, `quelle`, `seite`.
Der Webhook ist in `index.html` in der Variable `WEBHOOK_URL` hinterlegt
(`https://api-v2.lead-table.com/api/webhook/generic/…`).

Leadtable-Kachel:
`https://portal.lead-table.com/customer/6a8ec617a9e3d55df560ff70/table/6a8ec62e806ae78eb15bc0ff/leads`

## Lebenslauf-Upload

Der optionale Datei-Upload nutzt Supabase Storage (Bucket `bewerbungen`,
Ländle-Digital-Projekt – identisch zur ALWA-Seite, Dateien liegen unter zufälliger
UUID). Der Bucket existiert bereits; `supabase-bewerbungen.sql` liegt nur zur
Dokumentation bei. Im Leadtable-Feld `lebenslauf` landet ein direkt öffenbarer Link.

## Live schalten (GitHub Pages)

Der Ordner ist self-contained und kann 1:1 in ein eigenes Repo (z. B. für GitHub Pages)
kopiert werden. Alternativ als Unterseite unter `laendle-digital.com` / im Kundenordner
ausliefern. Danach ist die Seite unter der hinterlegten URL erreichbar.

---
Karriereseite von **Ländle Digital**.
