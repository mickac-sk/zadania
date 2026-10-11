# Projekt: PAD-M1-P001

## Temat: „Konfigurator zamówienia w pizzerii"
 
Zbuduj aplikację Windows Forms (**jedno okno**), w której klient składa zamówienie na pizzę, a program liczy cenę i wyświetla podsumowanie.
 
### Dane techniczne
 
- Szablon projektu: *Windows Forms App* (.NET), język C#.
- Nazwa projektu: `NazwiskoImie_Pizzeria`.
- Wyniki i komunikaty o błędach wyświetlaj **wyłącznie w kontrolkach `Label`** (bez okien dialogowych).
- Czas pracy: 1 blok lekcyjny (90 min), praca samodzielna.
### Cennik (wpisz do kodu jako nazwane stałe lub zmienne, nie jako liczby rozsiane po programie)
 
| Element | Cena |
|---|---|
| Margherita | 24 zł |
| Pepperoni | 28 zł |
| Hawajska | 27 zł |
| Wegetariańska | 29 zł |
| Rozmiar mała | +0 zł |
| Rozmiar średnia | +6 zł |
| Rozmiar duża | +12 zł |
| Każdy dodatek (ser, pieczarki, oliwki) | +3 zł |
 
**Wzór:** `cena = (cena pizzy + dopłata za rozmiar + dopłaty za dodatki) × ilość`
 
### Wymagania funkcjonalne
 
1. **Nagłówek** — `Panel` przyklejony do górnej krawędzi okna (`Dock = Top`) z etykietą z nazwą pizzerii.
2. **Dane klienta**
   - `TextBox` na imię i nazwisko,
   - `TextBox` na numer telefonu: wpisanie czegokolwiek poza cyframi jest blokowane (`KeyPress`, klawisz Backspace musi nadal działać), maksymalnie 9 znaków.
3. **Pizza** — `ComboBox` z czterema pozycjami z cennika, wypełniony w zdarzeniu `Form1_Load`, domyślnie zaznaczona pierwsza pozycja.
4. **Rozmiar** — trzy `RadioButton` (mała / średnia / duża) w `GroupBox`, domyślnie zaznaczona „średnia".
5. **Dodatki** — trzy niezależne `CheckBox` (ser, pieczarki, oliwki).
6. **Ilość** — `TrackBar` (1–10, domyślnie 1). Obok niego etykieta pokazuje aktualną wartość i odświeża się na bieżąco podczas przesuwania suwaka.
7. **Termin dostawy** — `DateTimePicker`, w którym nie da się wybrać daty wcześniejszej niż dzisiejsza.
8. **Regulamin** — `CheckBox` „Akceptuję regulamin". Dopóki nie jest zaznaczony, przycisk „Zamów" jest nieaktywny.
9. **Przycisk „Zamów"**
   - sprawdza dane: imię i nazwisko nie może być puste, telefon musi mieć dokładnie 9 cyfr,
   - przy błędzie wyświetla komunikat w etykiecie **czerwonym kolorem** i nie składa zamówienia,
   - przy poprawnych danych wyświetla w jednej etykiecie, w kilku liniach: imię i nazwisko, telefon, pizzę, rozmiar, listę wybranych dodatków, ilość, termin dostawy i **cenę końcową**; komunikat błędu znika.
10. **Przycisk „Wyczyść"** — przywraca wszystkie kontrolki do wartości domyślnych i czyści etykiety wyników.
11. **Wygląd**
    - przycisk „Zmień kolor tła" otwiera `ColorDialog` i ustawia wybrany kolor jako tło formularza,
    - przycisk „Zamów" jest zakotwiczony w prawym dolnym rogu (`Anchor`) i po rozciągnięciu okna zostaje w rogu,
    - układ jest czytelny, kontrolki nie nakładają się i mają opisy.

### Zadanie dodatkowe
 
Dodaj etykietę „Cena na żywo", która pokazuje aktualną cenę **jeszcze przed** kliknięciem „Zamów" i odświeża się po każdej zmianie pizzy, rozmiaru, dodatków lub ilości. Wykorzystaj **jedną wspólną metodę** podpiętą pod zdarzenia wielu kontrolek.
 
### Wymagania dotyczące kodu
 
- Nazwy kontrolek z przedrostkami typu: `txtImie`, `cmbPizza`, `radMala`, `chkSer`, `trkIlosc`, `dtpTermin`, `btnZamow`, `lblPodsumowanie`.
- Obliczanie ceny wydziel do osobnej metody.
- Komentarze przy kluczowych fragmentach (obliczenia, walidacja).
- Usuń nieużywany kod i puste metody zdarzeń.
- Pisz własny kod w `Form1.cs`, nie edytuj ręcznie `Form1.Designer.cs`.

### Forma oddania
 
Spakowany folder projektu bez katalogów `bin` i `obj`, plik `NazwiskoImie_PAD-M1.zip`. 

>Nauczyciel może poprosić o wyjaśnienie dowolnego fragmentu kodu; **brak zrozumienia własnego kodu** oznacza obniżenie punktacji lub **uznanie pracy za niesamodzielną**.
