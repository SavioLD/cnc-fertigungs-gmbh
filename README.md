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

## Screening (Vorfilterung) mit KO-Kriterien

Der Funnel stellt **5 Qualifizierungsfragen** (Erfahrung · CNC-Erfahrung · Zeichnung/Messtechnik ·
Schicht · Arbeitsweg). **KO-Kriterien steuern sofort aus:** Wählt jemand eine KO-Antwort,
erscheint direkt die freundliche Absage und es wird **kein Lead** an Leadtable gesendet
(keine Summenlogik – eine einzige KO-Antwort reicht).

**KO-Kriterien (jede einzelne Antwort = sofortige Absage):**
- `erfahrung` = „Weder Ausbildung noch Erfahrung im Bereich”            → beide Stellen
- `technik`   = „Kann ich (noch) nicht” (Zeichnung lesen & Messtechnik) → beide Stellen
- `schicht`   = „Nein, Schichtarbeit passt nicht”                       → beide Stellen (Zweischichtbetrieb)
- `standort`  = „Nein, zu weit weg / Anfahrt nicht zuverlässig machbar” → beide Stellen
- `cnc_erfahrung` = „Keine Erfahrung mit CNC-Maschinen”                 → nur CNC-Dreher

**Optionale Kriterien (steuern NICHT aus, nur Info):**
- die mittleren Stufen aller Fragen (z. B. „Grundkenntnisse”, „nur nach Absprache”,
  „etwas weiter weg, aber Anfahrt zuverlässig machbar”)
- beim **Rundschleifer** zählt fehlende CNC-Erfahrung NICHT als KO (konventionelles Schleifen möglich)

**Arbeitsweg:** Standort ist 89150 Laichingen (Alb-Donau-Kreis). Die Frage filtert Bewerber aus,
die nicht zuverlässig zum Standort kommen (Richtwert ~30–35 km Umkreis). „Etwas weiter weg,
aber zuverlässig machbar” ist bewusst **kein** KO.

**Anpassen:** In `index.html` die Listen `KO_ALWAYS` / `KO_CNC_DREHER` bearbeiten
(Antworttext exakt wie im `value`-Attribut der jeweiligen Option). KO ergänzen = Wert
in die Liste aufnehmen; Kriterium optional machen = Wert entfernen. `qualifikation_score`
(0–10) läuft weiter mit (nur erfahrung/cnc_erfahrung/technik/schicht) und landet zur Info
im Lead. Seiten-Neuladen startet frisch.

## Bewerbungen (Leadtable)

Jede abgeschlossene Bewerbung wird per Webhook an die **Leadtable-Kachel** der CNC
Fertigungs GmbH gesendet. Felder u. a.: `name` (ein Feld, Vorname + Nachname),
`email`, `telefon`, `stelle`, `erfahrung`, `cnc_erfahrung`, `technik`, `schicht`, `standort`,
`qualifikation_score`, `lebenslauf`, `datenschutz`, `quelle`, `seite`.
**Pro Stelle eine eigene Leadtable-Kachel** – in `index.html` in `WEBHOOK_URLS` hinterlegt
(Routing über `webhookFor(stelle)`): CNC-Dreher und Rundschleifer gehen an unterschiedliche
Webhooks (`api-v2.lead-table.com/api/webhook/generic/…`). Weitere/neue Stellen einfach
als Schlüssel (`cnc-dreher` / `rundschleifer` / …) ergänzen.

Leadtable-Kacheln:
- CNC-Dreher:    `…/table/6a8ec62e806ae78eb15bc0ff/leads`
- Rundschleifer: `…/table/6ae08ea8da44e341a1193304/leads`

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
