# Zadanie praktyczne — Analizator numerów katalogowych towaru

## 1. Jak zbudowany jest numer katalogowy NKT

W magazynie każdy towar ma **13-znakowy** wewnętrzny numer katalogowy **NKT** (bez odstępów i myślników).
Kolejne znaki (pozycje liczone od 1) kodują następujące informacje:

```
 K K   R R M M D D   N N N N   C
 └┬┘   └───┬────┘    └──┬──┘   |
poz.1-2   poz.3-8     poz.9-12  poz.13
kategoria  data prod.  nr partii kontrola
```

- **Pozycje 1–2 — kategoria:** dwie **wielkie litery** oznaczające rodzaj towaru (tabela niżej).
- **Pozycje 3–8 — data produkcji:** format `RRMMDD` (rok dwucyfrowy, miesiąc, dzień).
  Rok odczytujemy jako `2000 + RR`, np. `240315` → **15 marca 2024**.
- **Pozycje 9–12 — numer partii:** czterocyfrowy numer kolejny partii z danego dnia (`0001`–`9999`).
- **Pozycja 13 — cyfra kontrolna:** **suma dziesięciu cyfr** z pozycji 3–12, wzięta **modulo 10**.

| Kod | Kategoria   | Kod | Kategoria  |
|-----|-------------|-----|------------|
| `EL`| Elektronika | `OD`| Odzież     |
| `AG`| AGD         | `NA`| Narzędzia  |
| `SP`| Spożywcze   |     |            |

### Przykład zbudowania kodu `EL24031500421`

- kategoria `EL` → Elektronika
- data `240315` → 15 marca 2024
- numer partii `0042`
- cyfra kontrolna: cyfry `2403150042` → 2+4+0+3+1+5+0+0+4+2 = 21, a 21 mod 10 = **1**
- gotowy numer: `EL2403150042` + `1` = **`EL24031500421`**

---

## 2. Dane wejściowe

W swoim skrypcie umieść poniższą tablicę numerów do przeanalizowania:

```php
$kody = [
    'EL24031500421',
    'AG25120100034',
    'NA26021400083',
    'SP26071500127',
    'XY24010100019',
    'EL2512',
];
```

---

## 3. Polecenie

Napisz skrypt, który **dla każdego** numeru z tablicy wykona poniższe kroki i wypisze czytelny raport:

- **a)** Sprawdź **długość** numeru. Jeśli nie ma dokładnie 13 znaków — wypisz komunikat o błędzie i przejdź do następnego.
- **b)** Sprawdź, czy pozycje 3–13 zawierają **wyłącznie cyfry**. Jeśli nie — wypisz komunikat o błędzie i przejdź dalej.
- **c)** Wydziel **kod kategorii** (poz. 1–2) i wypisz jej **pełną nazwę**. Dla nieznanego kodu wypisz „nieznana kategoria".
- **d)** Odczytaj **datę produkcji** i wypisz ją słownie w formacie: `15 marca 2024, piątek` (dzień, nazwa miesiąca, rok oraz nazwa dnia tygodnia).
- **e)** Oblicz i wypisz **wiek towaru w dniach** — liczbę pełnych dni od daty produkcji do dnia uruchomienia skryptu.
- **f)** Oblicz **cyfrę kontrolną** z pozycji 3–12 i porównaj z 13. znakiem. Wypisz, czy numer jest **poprawny**, czy **błędny**.
- **g)** Na końcu raportu wypisz **stopkę** z datą i godziną jego wygenerowania.

---

## 4. Wymagania techniczne i podpowiedzi

- Wyłącznie **PHP** uruchamiany lokalnie (przeglądarka lub wiersz poleceń).
- Do wycinania pól z numeru użyj `substr()`; do zmiany wielkości liter `strtoupper()` / `mb_strtolower()`.
- Do dat i czasu wykorzystaj `mktime()`, `date()` oraz `time()`. Nazwę dnia tygodnia uzyskasz z `date('w', $ts)` (0 = niedziela) i własnej tablicy nazw.
- Kod podziel na **funkcje** (np. osobna funkcja licząca cyfrę kontrolną) i **komentuj** ważniejsze fragmenty.

---

## 5. Przykład formatu wyjścia (dla numeru `EL24031500421`)

```
Kod: EL24031500421
  Kategoria       : EL -> Elektronika
  Data produkcji  : 15 marca 2024, piątek
  Numer partii    : 0042
  Wiek towaru     : 956 dni
  Cyfra kontrolna : w kodzie 1, obliczona 1 -> POPRAWNY
```

> Wartość „Wiek towaru" zależy od dnia uruchomienia skryptu — powyżej policzona dla 27 października 2026.
