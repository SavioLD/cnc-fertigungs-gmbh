# CNC Fertigungs GmbH – Karriere-/Ad-Funnel

Recruiting-Landingpage für die **CNC Fertigungs GmbH** (Gottlieb-Daimler-Straße 39, 89150 Laichingen).
Aufbau 1:1 an der ALWA-Karriereseite orientiert – nur in eigenem CI und mit den beiden aktuellen Stellen.

**Beworbene Stellen (nur diese):**
- CNC-Dreher – Heidenhain-Steuerung (m/w/d)
- Rundschleifer (m/w/d)

## Inhalt

- `index.html` – die komplette Seite (self-contained, keine Build-Schritte nötig)
- `supabase-bewerbungen.sql` – legt/aktualisiert den Storage-Bucket für den optionalen Lebenslauf-Upload
- `bilder/` – Hero-Fotos und Logo (siehe unten)
- `creatives/` – Meta-Ads-Creatives (folgen, sobald Bildmaterial im Repo liegt)
- `werbetexte-meta-ads.md` – Anzeigentexte für Meta Ads (Primary Text, Headlines, Descriptions)
- `.nojekyll` – sorgt dafür, dass GitHub Pages die Dateien 1:1 ausliefert

## ⚠️ CI-Farben (bitte prüfen)

Die Website `cncfertigung.de` war aus dieser Umgebung nicht erreichbar (Egress-Sperre),
daher wurde ein professionelles **Industrieblau als Platzhalter-CI** gewählt.
Sämtliche Farben stecken als CSS-Variablen ganz oben in `index.html` unter `:root`
(`--brand`, `--brand-dark`, `--brand-700`, `--brand-900`, `--brand-soft`, `--grad`,
`--bg-soft`, `--panel-2`). Ein CI-Wechsel ist damit ein Ein-Zeilen-Tausch pro Farbe.
Sobald das echte Logo in `bilder/` liegt bzw. die Hausfarben bekannt sind, bitte die
Tokens anpassen (oder kurz Bescheid geben – wird sofort nachgezogen).

Auch `theme-color` (im `<head>`) entsprechend anpassen.

## Bilder (Hero-Fotos + Logo)

Die Fotos gehören in den Ordner **`bilder/`**. Der Hero lädt automatisch das passende
Bild – fehlt es, bleibt ein Farbverlauf stehen (kein kaputtes Bild). Erwartete Dateinamen:

- `bilder/hero.jpg` – allgemeines Hero-Bild (ohne `?stelle=`-Parameter)
- `bilder/cnc-dreher.jpg` – bei `?stelle=cnc-dreher`
- `bilder/rundschleifer.jpg` – bei `?stelle=rundschleifer`

Querformat, mind. ~1600 px breit. Motiv rechts platzieren – links liegt die Textfläche.

**Logo:** `bilder/cnc-logo.svg` (oder `.png`) ersetzt automatisch den Text-Schriftzug in
Kopfzeile/Hero/Footer. Für Hero + Footer (dunkler Hintergrund) zusätzlich eine helle
Variante als `bilder/cnc-logo-weiss.svg` / `.png` ablegen.

## Stellen-Deeplinks für die Ad

Die Anzeige kann direkt auf eine Stelle verlinken; die Seite wählt sie vor und startet
beim Erfahrungs-Schritt:

- `…/?stelle=cnc-dreher`
- `…/?stelle=rundschleifer`

## Screening (Vorfilterung)

Im 2. Schritt wird die Qualifikation abgefragt. Wer „Weder Ausbildung noch Erfahrung
im Bereich“ wählt, wird freundlich ausgesteuert (**kein Lead** an Leadtable). Ein
Seiten-Neuladen startet den Prozess frisch (keine dauerhafte Sperre).

## Bewerbungen (Leadtable)

Jede abgeschlossene Bewerbung wird per Webhook an die **Leadtable-Kachel** der CNC
Fertigungs GmbH gesendet. Felder u. a.: `vorname`, `nachname`, `name`, `email`,
`telefon`, `stelle`, `erfahrung`, `lebenslauf`, `datenschutz`, `quelle`, `seite`.
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
