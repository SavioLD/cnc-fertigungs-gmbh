-- =====================================================================
-- CNC Fertigung Karriereseite: Storage-Bucket für den optionalen Lebenslauf-Upload
-- ---------------------------------------------------------------------
-- Der Bucket "bewerbungen" wird bereits von der ALWA-Karriereseite genutzt
-- (gleiches Ländle-Digital-Projekt kxqdybjkcrowqdcpvlqa). Dieses Skript ist
-- idempotent und muss nur einmalig ausgeführt werden, falls der Bucket noch
-- nicht existiert. Danach kann die Landingpage kunden/cnc-fertigung/ Dateien
-- in den Bucket "bewerbungen" hochladen; der Link landet im Leadtable-Datensatz.
--
-- Sicherheit:
--   • Der Bucket ist "public", aber die Pfade enthalten eine zufällige
--     UUID – Dateien sind nur mit dem exakten Link abrufbar. Auflisten des
--     Buckets ist anonym NICHT möglich.
--   • Anon darf ausschließlich hochladen (insert) – kein Überschreiben,
--     kein Löschen, kein Listing.
--   • Max. 10 MB, nur PDF / Word / JPG / PNG / WebP.
-- =====================================================================

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'bewerbungen', 'bewerbungen', true, 10485760,
  array[
    'application/pdf',
    'image/jpeg',
    'image/png',
    'image/webp',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  ]
)
on conflict (id) do update set
  public             = excluded.public,
  file_size_limit    = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

-- Anon darf nur neue Dateien in diesen einen Bucket legen.
drop policy if exists "bewerbungen_upload_anon" on storage.objects;
create policy "bewerbungen_upload_anon" on storage.objects
  for insert to anon, authenticated
  with check (bucket_id = 'bewerbungen');
