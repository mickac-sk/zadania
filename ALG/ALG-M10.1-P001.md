# Projekt — Rejestr zgłoszeń serwisowych

Wykonaj zadanie zgodnie z poniższymi wymaganiami. Pliki z rozwiązaniem umieść w folderze o nazwie będącej Twoim nazwiskiem, w podfolderze `konsolowa`. Dozwolony język: **C++**. **Nie wolno** używać gotowych funkcji bibliotecznych sortujących ani wyszukujących wartość największą.

## Część I. Aplikacja konsolowa

Serwis komputerowy prowadzi rejestr zgłoszeń napraw. Każde zgłoszenie opisują: **numer zgłoszenia** oraz **czas oczekiwania** wyrażony w pełnych godzinach. Zgłoszenia przechowywane są w **liście jednokierunkowej**.

Napisz program konsolowy, który spełnia następujące wymagania:

1. Zdefiniuj strukturę `Wezel` reprezentującą pojedyncze zgłoszenie na liście. Struktura przechowuje: numer zgłoszenia (typ całkowitoliczbowy), czas oczekiwania w godzinach (typ całkowitoliczbowy) oraz wskaźnik na następny element listy.

2. Zdefiniuj strukturę `Rejestr` przechowującą wskaźnik na początek listy oraz liczbę zgłoszeń w rejestrze.

3. Zaimplementuj funkcję **dodającą** nowe zgłoszenie na koniec listy. Rejestr przekazywany jest do funkcji **przez referencję** (lub wskaźnik).

4. Zaimplementuj funkcję **wyświetlającą** wszystkie zgłoszenia rejestru. Każde zgłoszenie wypisz w osobnym wierszu w formacie:

   ```
   <lp>: zgłoszenie #<numer>, czas <czas> h
   ```

   gdzie `<lp>` to kolejny numer porządkowy na liście, liczony od 1.

5. Zaimplementuj funkcję **wyszukującą** zgłoszenie o **najdłuższym** czasie oczekiwania. Funkcja przegląda całą listę **samodzielnym algorytmem** (bez gotowych funkcji) i zwraca wskaźnik na znaleziony element. Jeżeli rejestr jest pusty, funkcja zwraca wartość pustą.

6. Zaimplementuj funkcję zwracającą **liczbę zgłoszeń** w rejestrze.

7. Zaimplementuj funkcję **zwalniającą pamięć** zajmowaną przez wszystkie elementy listy.

8. W programie głównym:
   - utwórz pusty rejestr;
   - wczytaj z klawiatury kolejne zgłoszenia (numer i czas oczekiwania); przyjmij dane **tylko poprawne**: numer większy od 0 oraz czas oczekiwania nie mniejszy od 0 — w razie błędnej wartości wyświetl komunikat i poproś ponownie;
   - wyświetl zawartość całego rejestru (wymaganie 4);
   - wyświetl liczbę zgłoszeń w rejestrze;
   - wyświetl numer zgłoszenia, które czeka najdłużej;
   - przed zakończeniem programu zwolnij pamięć.

Zadbaj o czytelność kodu: wcięcia bloków, znaczące nazwy funkcji i zmiennych, typy danych dopasowane do przechowywanych wartości. Program ma prowadzić zrozumiałą interakcję z użytkownikiem (czytelne komunikaty o wprowadzaniu danych).

## Część III. Dokumentacja

Nad funkcją wyszukującą zgłoszenie o najdłuższym czasie oczekiwania umieść nagłówek dokumentacyjny zgodny ze wzorem:

```
/*
 * Nazwa funkcji:    <nazwa>
 * Opis działania:   <co robi funkcja>
 * Parametry:        <nazwa i opis każdego parametru lub "brak">
 * Zwracana wartość: <typ i opis lub "brak">
 * Autor:            <Twój numer>
 */
```

---

### Przykład działania (poglądowo)

```
Podaj numer zgłoszenia (0 = koniec): 101
Podaj czas oczekiwania [h]: 5
Podaj numer zgłoszenia (0 = koniec): 102
Podaj czas oczekiwania [h]: 12
Podaj numer zgłoszenia (0 = koniec): 103
Podaj czas oczekiwania [h]: 3
Podaj numer zgłoszenia (0 = koniec): 0

Rejestr zgłoszeń:
1: zgłoszenie #101, czas 5 h
2: zgłoszenie #102, czas 12 h
3: zgłoszenie #103, czas 3 h

Liczba zgłoszeń: 3
Najdłużej czeka zgłoszenie: #102
```

> Sposób zakończenia wczytywania (np. numer `0`) możesz zaprojektować samodzielnie — ważne, by dało się wprowadzić dowolną liczbę zgłoszeń.
