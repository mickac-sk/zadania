# Zadanie praktyczne — ALG-M5-P001
## Analiza wyników klasówki

| | |
|-|-|
|**Język:** | C++ |
|**Czas:** | 90 min |
|**Forma:** | zadanie praktyczne (programistyczne) przy komputerze |
|**Dozwolone materiały:** | własne notatki, dokumentacja języka |

---
 
## Treść zadania
 
Napisz w języku C++ program wspomagający nauczyciela w analizie wyników klasówki. Program przechowuje w **tablicy jednowymiarowej** punkty uzyskane przez uczniów (liczby całkowite z zakresu 0–100) i wykonuje na nich obliczenia statystyczne.
 
Tablica ma stały rozmiar **25 elementów** i jest wypełniana **liczbami losowymi**. Program dzielisz na **osobne funkcje** — każda realizuje jedno zadanie, a funkcje obliczeniowe **zwracają** wynik (nie wypisują go same).
 
### Wymagania — część I
 
1. Zadeklaruj tablicę 25 liczb całkowitych (stała na rozmiar).
2. Napisz funkcję **wypełniającą** tablicę liczbami losowymi z zakresu **0–100** (włącznie).
3. Przed wypełnieniem program pyta o **ziarno** generatora: wartość `0` oznacza losowanie zależne od zegara (`srand(time(0))`), inna wartość — ustawienie podanego ziarna (powtarzalny wynik).
4. Napisz funkcję **wyświetlającą** tablicę — elementy oddzielone **przecinkami i spacją**, **bez** przecinka po ostatnim elemencie.
5. Napisz funkcję liczącą **sumę** wszystkich punktów.
6. Napisz funkcję liczącą **średnią** arytmetyczną (wynik typu `double`, z poprawnym rzutowaniem).
7. Napisz funkcję zwracającą **najwyższy wynik** (maksimum) w tablicy.
8. W programie głównym wywołaj funkcje i wypisz: zawartość tablicy, średnią, najwyższy wynik.
### Wymagania — część II
 
9. Napisz funkcję **wyszukującą** podany wynik w tablicy. Funkcja **zwraca indeks** pierwszego wystąpienia albo **−1**, gdy wyniku nie ma. Wartość do wyszukania program wczytuje od użytkownika. Nalezy rozdzielić logikę i prezetację.
10. W programie głównym: komunikat „nie znaleziono" wypisz **tylko** wtedy, gdy funkcja zwróci −1; w przeciwnym razie wypisz **pozycję** (indeks) znalezionego wyniku.
11. Napisz funkcję liczącą, **ilu uczniów uzyskało wynik powyżej średniej**.
12. Napisz funkcję liczącą, **ile wyników mieści się w przedziale** podanym przez użytkownika (dwie liczby: dolna i górna granica, włącznie).
---
 
## Przykładowy przebieg programu
 
```
Podaj ziarno (0 = losowe): 42
Wyniki klasowki: 21, 71, 37, 39, 59, 74, 78, 16, 69, 5, 21, 49, 4, 18, 56, 0, 59, 100, 49, 83, 73, 21, 46, 0, 82
Srednia: 45.2
Najwyzszy wynik: 100
Powyzej sredniej: 14 uczniow
Wyniki w przedziale 90-100: 1
Podaj szukany wynik: 59
Wynik 59 pierwszy raz na pozycji 4
```
 
Dla wyniku, którego nie ma w tablicy:
```
Podaj szukany wynik: 95
Wyniku 95 nie ma w tablicy
```
 
> Uwaga: przy ziarnie `42` powyższe liczby są powtarzalne — pozwala to na szybkie sprawdzenie poprawności. Przy ziarnie `0` wyniki będą inne za każdym uruchomieniem.
 
---
 
## Wymagania techniczne
 
- program dzieli się na **osobne funkcje** (nie cały kod w `main`);
- funkcje obliczeniowe (suma, średnia, maksimum, wyszukiwanie, zliczanie) **zwracają** wynik przez `return` — nie wypisują go wewnątrz funkcji;
- tablicę przekazujesz do funkcji wraz z jej **rozmiarem** jako osobnym parametrem;
- kod ma być **czytelny**: konsekwentne wcięcia, znaczące nazwy funkcji i zmiennych;
- każda funkcja ma **nagłówek dokumentacyjny** (wg wzoru CKE: nazwa, opis, parametry, typ zwracany, autor);
- program **kompiluje się bez błędów**; jeeli trzebazrób **zrzut ekranu** udanej kompilacji i działania.
