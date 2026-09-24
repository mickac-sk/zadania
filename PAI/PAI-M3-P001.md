### Projekt PAI-M3-P001. Wyniki zawodów pływackich
 
Skopiuj dane do pliku `m3_zad17_nazwisko.php`. Traktuj tablicę jak wynik zapytania do bazy danych — każdy element to jeden wiersz tabeli `wyniki`.
 
```php
$wyniki = [
    ["zawodnik" => "Kowalczyk",  "kraj" => "POL", "czas" => 24.81],
    ["zawodnik" => "Schmidt",    "kraj" => "GER", "czas" => 24.35],
    ["zawodnik" => "Novák",      "kraj" => "CZE", "czas" => 25.02],
    ["zawodnik" => "Wiśniewska", "kraj" => "POL", "czas" => 24.58],
    ["zawodnik" => "Müller",     "kraj" => "GER", "czas" => 25.40],
    ["zawodnik" => "Horváth",    "kraj" => "HUN", "czas" => 24.47],
    ["zawodnik" => "Zielińska",  "kraj" => "POL", "czas" => 25.10],
    ["zawodnik" => "Svoboda",    "kraj" => "CZE", "czas" => 24.93],
];
$wybranyKraj = "POL";
```
 
Wymagania:
 
1. Strona ma nagłówek `<h1>Zawody pływackie – 50 m</h1>` i tabelę z kolumnami: Miejsce, Zawodnik, Kraj, Czas [s], Strata.
2. Zawodnicy są posortowani od najlepszego (najkrótszy czas) do najgorszego.
3. Miejsce jest numerowane od 1. Trzy pierwsze miejsca mają w kolumnie Miejsce dopisek: „złoto”, „srebro”, „brąz”.
4. Kolumna Strata pokazuje różnicę czasu do zwycięzcy z plusem i 2 miejscami po przecinku (np. `+0,12`); u zwycięzcy wyświetla się „—”.
5. Pod tabelą wypisz: liczbę zawodników, średni czas (2 miejsca po przecinku) i liczbę krajów biorących udział. Wskazówka: `array_column` i `array_unique`.
6. W sekcji `<h2>Reprezentacja: …</h2>` wypisz zawodników kraju z `$wybranyKraj` razem z miejscem, które zajęli. Jeśli kraj nie ma zawodników, wypisz „Brak zawodników z tego kraju”. Sprawdź dla „POL”, „HUN” i „FRA”.
7. Kod zawiera komentarze opisujące punkty 2–6.
8. **Dla chętnych:** dodaj pod tabelą klasyfikację krajów — dla każdego kraju liczbę zawodników, posortowaną malejąco.
