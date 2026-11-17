# Projekt PAI-M5-P001

## Zadanie
Napisz aplikację w języku **PHP**, która wczyta dane produktów z pliku tekstowego, wyświetli je na stronie wraz ze statystykami oraz wygeneruje **plik z podsumowaniem**.

Projekt podsumowuje dział *System plików* i wykorzystuje: operacje na plikach, funkcje, tablice, pętle, instrukcje warunkowe oraz obróbkę tekstu i daty.

## Dane wejściowe

W pliku `produkty.txt` każdy wiersz opisuje jeden produkt, a pola oddzielone są średnikiem `;` w kolejności:

```
nazwa;kategoria;cena;ilosc
```

Przykładowa zawartość:

```text
Klawiatura mechaniczna;peryferia;249.00;15
Mysz optyczna;peryferia;59.90;40
Monitor 24 cale;monitory;699.00;8
Pendrive 64GB;nosniki;39.00;120
Dysk SSD 1TB;nosniki;299.00;25
Monitor 27 cali;monitory;999.00;5
Słuchawki;peryferia;149.00;18
Kabel HDMI;akcesoria;19.90;200
```

> Plik `produkty.txt` znajduje się w repozytorium. Umieść go w tym samym katalogu co `index.php`.

## Wymagania

Cały kod PHP umieść w pliku `index.php`.

- **Wczytanie pliku**
  Przed odczytem sprawdź, czy plik `produkty.txt` istnieje (`file_exists`). Jeśli go nie ma — wyświetl komunikat i zakończ działanie skryptu (`die` / `exit`). Wczytaj plik do tablicy wierszy (`file` z flagami `FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES`).
- **Funkcja przetwarzająca dane**
  Napisz funkcję `wczytajProdukty($sciezka)`, która zwróci tablicę rekordów. Każdy rekord to tablica asocjacyjna z kluczami `nazwa`, `kategoria`, `cena`, `ilosc` (rozbicie wiersza funkcją `explode`). Wiersze z mniej niż 4 polami pomiń.
- **Tabela produktów**
  Wyświetl wszystkie produkty w tabeli (kolumny: Nazwa, Kategoria, Cena, Ilość) oraz podaj łączną liczbę produktów. Nazwy wyświetl **wielkimi literami** (`strtoupper`).
- **Statystyki**
  Oblicz i wyświetl:
  - łączną wartość magazynu (suma `cena × ilosc` dla wszystkich produktów),
  - nazwę produktu **najdroższego**,
  - liczbę produktów w każdej kategorii, **posortowaną malejąco** (`arsort`).
- **Zapis podsumowania do pliku**
  Zapisz podsumowanie do pliku `podsumowanie.txt`: datę i godzinę wygenerowania (`date("Y-m-d H:i")`), liczbę produktów, łączną wartość magazynu, produkt najdroższy oraz zestawienie kategorii. Do zapisu użyj `file_put_contents` lub `fopen`/`fwrite`/`fclose`.
- **Jakość kodu**
  Stosuj znaczące nazwy zmiennych i funkcji, komentarze oraz czytelne wcięcia.

## Do oddania
Folder zzipowany podpisany **nazwiskiem**, zawierający:
- `index.php` — kod rozwiązania,
- `produkty.txt` — plik z danymi,
- `podsumowanie.txt` — wygenerowany przez aplikację.
