# PAI-M4 — Ćwiczenia praktyczne: praca z tekstem i czasem

| Zad. | Temat | Główne funkcje |
|---|---|---|
| 1 | Analizator zdania | `trim`, `mb_strlen`, `strtok`, `mb_convert_case`, `mb_str_split`, `array_reverse` |
| 2 | Walidator adresów e-mail | `substr_count`, `strstr`, `substr`, `strpos`, `strtolower`, `printf` |
| 3 | Paragon ze sklepu szkolnego | `str_repeat`, `str_pad`, `sprintf`, `number_format`, `mb_substr`, `date` |
| 4 | Odliczanie do wydarzeń | `mktime`, `date`, `getdate`, różnice znaczników czasu, `intdiv` |
| 5 | Kalendarz miesiąca (HTML) | `checkdate`, `date('t')`, `date('N')`, `mktime` |

## Zasady dla uczniów

- Każde zadanie w osobnym pliku: `zad1.php` … `zad5.php`. Zapis w **UTF-8 bez BOM**.
- Na początku każdego pliku: `declare(strict_types=1);` oraz (zad. 3–5) `date_default_timezone_set('Europe/Warsaw');`.
- Wynik tekstowy wypisuj w znaczniku `<pre>…</pre>`, żeby przeglądarka zachowała spacje i nowe linie.
- Całą logikę zapisz w **funkcjach z typami** (parametry i wartość zwracana), a pod nimi wywołaj je na danych z treści zadania.
- Pamiętaj: funkcje bez `mb_` pracują na **bajtach**, a nie na znakach — przy polskich literach daje to błędne wyniki.

---

## Zadanie 1 — Analizator zdania

Dane: `$zdanie = "  jaki piękny  dzień na naukę PHP  ";` (uwaga: na brzegach są spacje, a w środku **podwójna spacja**).

Napisz funkcje i wypisz raport:

1. `slowa(string $zdanie): array` — zwraca tablicę słów (podwójne spacje nie mogą tworzyć pustych słów).
2. `najdluzszeSlowo(array $slowa): string` — przy remisie zwraca **pierwsze** z najdłuższych.
3. `odwrocTekst(string $t): string` — odwraca kolejność **liter** (z polskimi znakami!).
4. `czyPalindrom(string $t): bool` — ignoruje wielkość liter, spacje i znaki `, . ! ?`.

Raport ma zawierać: zdanie po `trim`, długość w znakach i w bajtach, liczbę słów, najdłuższe słowo, zdanie z każdym słowem wielką literą, słowa w odwróconej kolejności, litery w odwróconej kolejności. Sprawdź palindromy dla: `"Kobyła ma mały bok"`, `"Ala ma kota"`, `"A to kanapa pana kota"`.

**Oczekiwany wynik:**

```text
Zdanie:            [jaki piękny  dzień na naukę PHP]
Długość (znaki):   31
Długość (bajty):   34
Liczba słów:       6
Najdłuższe słowo:  piękny
Każde słowo wielką: Jaki Piękny  Dzień Na Naukę Php
Słowa od końca:    PHP naukę na dzień piękny jaki
Litery od końca:   PHP ękuan an ńeizd  ynkęip ikaj

Kobyła ma mały bok: TAK
Ala ma kota: NIE
A to kanapa pana kota: TAK
```

*Uwaga:* `MB_CASE_TITLE` zamienia `PHP` na `Php` — to nie błąd, tak działa ta funkcja.

**Podpowiedzi:** `strtok` pomija puste fragmenty; do podziału na litery użyj `mb_str_split`; do odwrócenia kolejności elementów `array_reverse`, do sklejenia `implode`.


**Przykładowe rozwiązanie:**

```php
<?php
declare(strict_types=1);
mb_internal_encoding('UTF-8');

/** Rozbija zdanie na słowa (strtok pomija puste fragmenty, więc podwójne spacje nie przeszkadzają). */
function slowa(string $zdanie): array
{
    $wynik = [];
    $s = strtok($zdanie, ' ');
    while ($s !== false) {
        $wynik[] = $s;
        $s = strtok(' ');
    }
    return $wynik;
}

function najdluzszeSlowo(array $slowa): string
{
    $najdl = '';
    foreach ($slowa as $s) {
        if (mb_strlen($s) > mb_strlen($najdl)) {   // ścisłe ">" => przy remisie zostaje pierwsze
            $najdl = $s;
        }
    }
    return $najdl;
}

function odwrocTekst(string $t): string
{
    return implode('', array_reverse(mb_str_split($t)));
}

function czyPalindrom(string $t): bool
{
    $czysty = str_replace([' ', ',', '.', '!', '?'], '', mb_strtolower($t));
    return $czysty === odwrocTekst($czysty);
}

$zdanie = "  jaki piękny  dzień na naukę PHP  ";
$przyciete = trim($zdanie);
$sl = slowa($przyciete);

echo "<pre>";
echo "Zdanie:            [", $przyciete, "]\n";
echo "Długość (znaki):   ", mb_strlen($przyciete), "\n";
echo "Długość (bajty):   ", strlen($przyciete), "\n";
echo "Liczba słów:       ", count($sl), "\n";
echo "Najdłuższe słowo:  ", najdluzszeSlowo($sl), "\n";
echo "Każde słowo wielką:", " ", mb_convert_case($przyciete, MB_CASE_TITLE), "\n";
echo "Słowa od końca:    ", implode(' ', array_reverse($sl)), "\n";
echo "Litery od końca:   ", odwrocTekst($przyciete), "\n\n";

foreach (["Kobyła ma mały bok", "Ala ma kota", "A to kanapa pana kota"] as $t) {
    echo "$t: ", czyPalindrom($t) ? "TAK" : "NIE", "\n";
}
echo "</pre>";
```

---

## Zadanie 2 — Walidator adresów e-mail

Dane:

```php
$adresy = [
    "jan.kowalski@szkola.edu.pl", "anna.nowak@szkola", "piotr@@szkola.pl", "ewa.kaminska.szkola.pl",
    "@szkola.pl", "zofia@szkola.pl.", "TOMASZ@Szkola.EDU.PL", "marek@poczta.pl",
];
```

Napisz funkcję `sprawdzAdres(string $adres): array`, która zwraca tablicę asocjacyjną `['login' => ..., 'domena' => ..., 'blad' => null|string]`. Adres najpierw normalizujemy (`trim`, małe litery). Reguły sprawdzaj **w tej kolejności**:

1. dokładnie jeden znak `@` (komunikaty: „brak znaku @”, „więcej niż jeden znak @”),
2. login (część przed `@`) nie jest pusty („pusty login”),
3. domena zawiera kropkę („domena bez kropki”),
4. domena nie zaczyna się i nie kończy kropką („domena zaczyna się lub kończy kropką”).

Wypisz tabelkę (adres, OK/BLAD, login, domena lub powód błędu), a pod nią liczbę poprawnych adresów i **statystykę domen** (ile poprawnych adresów w każdej domenie) zapisaną w tablicy asocjacyjnej.

**Oczekiwany wynik:**

```text
jan.kowalski@szkola.edu.pl   OK    jan.kowalski   szkola.edu.pl
anna.nowak@szkola            BLAD  anna.nowak     domena bez kropki
piotr@@szkola.pl             BLAD                 więcej niż jeden znak @
ewa.kaminska.szkola.pl       BLAD                 brak znaku @
@szkola.pl                   BLAD                 pusty login
zofia@szkola.pl.             BLAD  zofia          domena zaczyna się lub kończy kropką
TOMASZ@Szkola.EDU.PL         OK    tomasz         szkola.edu.pl
marek@poczta.pl              OK    marek          poczta.pl

Poprawnych: 3 z 8
  szkola.edu.pl: 2
  poczta.pl: 1
```

**Podpowiedzi:** `substr_count`, `strstr($a, '@', true)` zwraca część **przed** `@`, `strstr($a, '@')` — od `@`; `str_starts_with`, `str_ends_with`; `strpos(...) === false`.

**Przykładowe rozwiązanie:**

```php
<?php
declare(strict_types=1);

/** Zwraca ['login'=>..., 'domena'=>..., 'blad'=>null|string] */
function sprawdzAdres(string $adres): array
{
    $adres = strtolower(trim($adres));
    $wynik = ['login' => '', 'domena' => '', 'blad' => null];

    $ileMalp = substr_count($adres, '@');
    if ($ileMalp === 0) {
        $wynik['blad'] = 'brak znaku @';
        return $wynik;
    }
    if ($ileMalp > 1) {
        $wynik['blad'] = 'więcej niż jeden znak @';
        return $wynik;
    }
    $wynik['login'] = strstr($adres, '@', true);        // przed @
    $wynik['domena'] = substr(strstr($adres, '@'), 1);   // po @

    if ($wynik['login'] === '') {
        $wynik['blad'] = 'pusty login';
    } elseif (strpos($wynik['domena'], '.') === false) {
        $wynik['blad'] = 'domena bez kropki';
    } elseif (str_starts_with($wynik['domena'], '.') || str_ends_with($wynik['domena'], '.')) {
        $wynik['blad'] = 'domena zaczyna się lub kończy kropką';
    }
    return $wynik;
}

$adresy = [
    "jan.kowalski@szkola.edu.pl",
    "anna.nowak@szkola",
    "piotr@@szkola.pl",
    "ewa.kaminska.szkola.pl",
    "@szkola.pl",
    "zofia@szkola.pl.",
    "TOMASZ@Szkola.EDU.PL",
    "marek@poczta.pl",
];

$domeny = [];
$ok = 0;
echo "<pre>";
foreach ($adresy as $a) {
    $r = sprawdzAdres($a);
    printf("%-28s %-5s %-14s %s\n", $a, $r['blad'] === null ? 'OK' : 'BLAD', $r['login'], $r['blad'] ?? $r['domena']);
    if ($r['blad'] === null) {
        $ok++;
        $domeny[$r['domena']] = ($domeny[$r['domena']] ?? 0) + 1;
    }
}
echo "\nPoprawnych: $ok z ", count($adresy), "\n";
foreach ($domeny as $d => $n) {
    echo "  $d: $n\n";
}
echo "</pre>";
```

---

## Zadanie 3 — Paragon ze sklepu szkolnego

Dane:

```php
$pozycje = [               // [nazwa, ilość, cena brutto]
    ['Zeszyt A5',                  3, 4.50],
    ['Długopis żelowy',            5, 2.99],
    ['Teczka na dokumenty',        2, 7.20],
    ['Zakreślacz fluorescencyjny', 2, 5.40],
    ['Cyrkiel',                    1, 12.00],
];
```

Wypisz paragon o stałej szerokości **40 znaków** (czcionka równoszerokościowa — `<pre>`):

- ramki z `=` i `-` zrób funkcją `str_repeat`, napis „SKLEP SZKOLNY” wyśrodkuj `str_pad(..., STR_PAD_BOTH)`,
- kolumny: nazwa (19 znaków, wyrównana do lewej), ilość (3), cena (7), kwota (8) — liczby wyrównane do prawej,
- nazwy dłuższe niż 19 znaków **skróć** do 18 znaków i dodaj kropkę (np. `Zakreślacz fluores.`),
- kwoty w formacie polskim `1 234,50` (`number_format`),
- pod tabelą: netto, VAT 23% (zawarty w cenie brutto, czyli `razem × 23 / 123`, zaokrąglony do groszy) i **RAZEM DO ZAPŁATY**,
- na końcu numer paragonu w formacie `RRRRMMDD-GGMMSS` (`date`) oraz data i godzina.

**Pułapka:** `str_pad` i `sprintf('%-19s')` liczą **bajty**, więc nazwa „Długopis żelowy” zostanie wyrównana źle. Napisz własną funkcję dopełniającą na podstawie `mb_strlen`.

**Oczekiwany wynik:**

```text
========================================
             SKLEP SZKOLNY              
========================================
Nazwa               Szt    Cena    Kwota
----------------------------------------
Zeszyt A5             3    4,50    13,50
Długopis żelowy       5    2,99    14,95
Teczka na dokumenty   2    7,20    14,40
Zakreślacz fluores.   2    5,40    10,80
Cyrkiel               1   12,00    12,00
----------------------------------------
Netto                              53,37
VAT 23%                            12,28
RAZEM DO ZAPŁATY               65,65 PLN
========================================
Nr paragonu: <RRRRMMDD-GGMMSS>
<dd.mm.rrrr gg:mm>
```

**Podpowiedzi:** `sprintf('%3d %7s %8s', ...)` do liczb (ASCII — bez problemu), `mb_substr` do skracania, `max(0, ...)` chroni przed ujemnym argumentem `str_repeat`.

**Przykładowe rozwiązanie:**

```php
<?php
declare(strict_types=1);
mb_internal_encoding('UTF-8');
date_default_timezone_set('Europe/Warsaw');

const SZER = 40;

/** str_pad liczy BAJTY, więc "ż" psuje wyrównanie - dlatego własna wersja na mb_strlen. */
function dopelnijPrawo(string $t, int $dl): string
{
    return $t . str_repeat(' ', max(0, $dl - mb_strlen($t)));
}

function skroc(string $t, int $dl): string
{
    return mb_strlen($t) <= $dl ? $t : mb_substr($t, 0, $dl - 1) . '.';
}

function kwota(float $k): string
{
    return number_format($k, 2, ',', ' ');
}

$pozycje = [
    ['Zeszyt A5',                  3, 4.50],
    ['Długopis żelowy',            5, 2.99],
    ['Teczka na dokumenty',        2, 7.20],
    ['Zakreślacz fluorescencyjny', 2, 5.40],
    ['Cyrkiel',                    1, 12.00],
];

$razem = 0.0;
echo "<pre>";
echo str_repeat('=', SZER), "\n";
echo str_pad('SKLEP SZKOLNY', SZER, ' ', STR_PAD_BOTH), "\n";
echo str_repeat('=', SZER), "\n";
echo dopelnijPrawo('Nazwa', 19), sprintf(' %3s %7s %8s', 'Szt', 'Cena', 'Kwota'), "\n";
echo str_repeat('-', SZER), "\n";
foreach ($pozycje as [$nazwa, $ilosc, $cena]) {
    $wartosc = $ilosc * $cena;
    $razem += $wartosc;
    echo dopelnijPrawo(skroc($nazwa, 19), 19), sprintf(' %3d %7s %8s', $ilosc, kwota($cena), kwota($wartosc)), "\n";
}
echo str_repeat('-', SZER), "\n";
$vat = round($razem * 23 / 123, 2);        // VAT 23% zawarty w cenie brutto
echo dopelnijPrawo('Netto', 19), sprintf(' %20s', kwota($razem - $vat)), "\n";
echo dopelnijPrawo('VAT 23%', 19), sprintf(' %20s', kwota($vat)), "\n";
echo dopelnijPrawo('RAZEM DO ZAPŁATY', 19), sprintf(' %20s', kwota($razem) . ' PLN'), "\n";
echo str_repeat('=', SZER), "\n";
echo 'Nr paragonu: ', date('Ymd-His'), "\n";
echo date('d.m.Y H:i'), "\n";
echo "</pre>";
```

---

## Zadanie 4 — Odliczanie do wydarzeń

Dane (tablica asocjacyjna: nazwa → `[rok, miesiąc, dzień]`):

```php
$wydarzenia = [
    'Początek roku szkolnego' => [2026, 9, 1],
    'Zebranie z rodzicami'    => [2026, 10, 22],
    'Dyżur w bibliotece'      => [2026, 10, 23],
    'Wigilia'                 => [2026, 12, 24],
    'Sylwester'               => [2026, 12, 31],
    'Koniec semestru'         => [2027, 1, 29],
    'Dzień otwarty'           => [2027, 3, 15],
];
```

Dla każdego wydarzenia wypisz: nazwę, datę `dd.mm.rrrr`, **dzień tygodnia po polsku** i opis odliczania:

- 0 dni → `DZIŚ!`, 1 → `jutro`, −1 → `wczoraj`, mniej niż −1 → `minęło N dni temu`,
- w przyszłości → `za N dni`, a jeśli to co najmniej tydzień, dopisz w nawiasie `(X tygodni i Y dni)`; gdy reszta wynosi 0 — samo `(X tygodni)`,
- poprawna **odmiana**: 1 dzień / 2 dni; 1 tydzień / 2–4 tygodnie / 5–21 tygodni / 22–24 tygodnie … (liczby 12–14 mają formę „wiele”).

Pracuj na północy dzisiejszego dnia: `$dzis = mktime(0, 0, 0);`. **Do sprawdzenia wyników** ustaw stałą datę `$dzis = mktime(0, 0, 0, 10, 22, 2026);`.

**Oczekiwany wynik (dla 22.10.2026):**

```text
Dziś: 22.10.2026

Początek roku szkolnego: 01.09.2026 (wtorek) - minęło 51 dni temu
Zebranie z rodzicami: 22.10.2026 (czwartek) - DZIŚ!
Dyżur w bibliotece: 23.10.2026 (piątek) - jutro
Wigilia: 24.12.2026 (czwartek) - za 63 dni (9 tygodni)
Sylwester: 31.12.2026 (czwartek) - za 70 dni (10 tygodni)
Koniec semestru: 29.01.2027 (piątek) - za 99 dni (14 tygodni i 1 dzień)
Dzień otwarty: 15.03.2027 (poniedziałek) - za 144 dni (20 tygodni i 4 dni)
```

**Podpowiedzi:** `date('l')` zwraca nazwy angielskie → tablica `DNI`; różnicę dni licz jako `round(($ts2 - $ts1) / 86400)` (doba przy zmianie czasu ma 23 lub 25 godzin); tygodnie `intdiv($dni, 7)`, reszta `$dni % 7`; odmianę zapisz w jednej funkcji `odmien(int $n, string $jeden, string $kilka, string $wiele)`.

**Przykładowe rozwiązanie:**

```php
<?php
declare(strict_types=1);
date_default_timezone_set('Europe/Warsaw');

const DNI = ['Sunday' => 'niedziela', 'Monday' => 'poniedziałek', 'Tuesday' => 'wtorek', 'Wednesday' => 'środa',
             'Thursday' => 'czwartek', 'Friday' => 'piątek', 'Saturday' => 'sobota'];

/** Polska odmiana: 1 tydzień, 2-4 tygodnie, 5-21 tygodni, 22-24 tygodnie... */
function odmien(int $n, string $jeden, string $kilka, string $wiele): string
{
    if ($n === 1) {
        return "$n $jeden";
    }
    $ostatnie = $n % 10;
    $ostatnieDwie = $n % 100;
    if ($ostatnie >= 2 && $ostatnie <= 4 && !($ostatnieDwie >= 12 && $ostatnieDwie <= 14)) {
        return "$n $kilka";
    }
    return "$n $wiele";
}

function roznicaDni(int $odTs, int $doTs): int
{
    return (int)round(($doTs - $odTs) / 86400);     // round - doby przy zmianie czasu mają 23/25 h
}

function opisOdliczania(int $dni): string
{
    if ($dni === 0) {
        return 'DZIŚ!';
    }
    if ($dni === 1) {
        return 'jutro';
    }
    if ($dni === -1) {
        return 'wczoraj';
    }
    if ($dni < 0) {
        return 'minęło ' . odmien(-$dni, 'dzień', 'dni', 'dni') . ' temu';
    }
    $tyg = intdiv($dni, 7);
    $reszta = $dni % 7;
    $opis = 'za ' . odmien($dni, 'dzień', 'dni', 'dni');
    if ($tyg > 0) {
        $opis .= ' (' . odmien($tyg, 'tydzień', 'tygodnie', 'tygodni');
        $opis .= $reszta > 0 ? ' i ' . odmien($reszta, 'dzień', 'dni', 'dni') : '';
        $opis .= ')';
    }
    return $opis;
}

// Do sprawdzenia wyników ustaw stałą datę; na co dzień: $dzis = mktime(0, 0, 0);
$dzis = mktime(0, 0, 0, 10, 22, 2026);

$wydarzenia = [
    'Początek roku szkolnego' => [2026, 9, 1],
    'Zebranie z rodzicami'    => [2026, 10, 22],
    'Dyżur w bibliotece'      => [2026, 10, 23],
    'Wigilia'                 => [2026, 12, 24],
    'Sylwester'               => [2026, 12, 31],
    'Koniec semestru'         => [2027, 1, 29],
    'Dzień otwarty'           => [2027, 3, 15],
];

echo "<pre>";
echo 'Dziś: ', date('d.m.Y', $dzis), "\n\n";
foreach ($wydarzenia as $nazwa => [$r, $m, $d]) {
    $ts = mktime(0, 0, 0, $m, $d, $r);
    $dni = roznicaDni($dzis, $ts);
    echo $nazwa, ': ', date('d.m.Y', $ts), ' (', DNI[date('l', $ts)], ') - ', opisOdliczania($dni), "\n";
}
echo "</pre>";
```

---

## Zadanie 5 — Kalendarz miesiąca w HTML

Napisz funkcję `kalendarz(int $rok, int $mies, array $swieta = [], ?int $dzis = null): string`, która zwraca **tabelę HTML** z kalendarzem miesiąca:

- nagłówek (`<caption>`) z polską nazwą miesiąca i rokiem, np. „Listopad 2026” (tablica nazw w mianowniku),
- kolumny **Pn Wt Śr Cz Pt So Nd** (tydzień zaczyna się w poniedziałek),
- puste komórki przed pierwszym dniem miesiąca i po ostatnim (tabela prostokątna),
- weekendy i dni z tablicy `$swieta` mają klasę CSS `wolne` (czerwony kolor), a **dzisiejszy** dzień (jeśli należy do wyświetlanego miesiąca) — klasę `dzis`,
- dla niepoprawnego miesiąca/roku (np. 13) funkcja zwraca `<p>Niepoprawny miesiąc lub rok</p>`.

Wywołaj ją dla: `(2026, 10)`, `(2026, 11, [1, 11])`, `(2028, 2)` oraz `(2026, 13)`. Do testu ustaw `$dzis = mktime(0, 0, 0, 10, 22, 2026);`.

**Oczekiwane układy (cyfry w kolejnych wierszach tabeli, `.` = pusta komórka):**

```text
Październik 2026        Listopad 2026           Luty 2028
. . . 1 2 3 4           . . . . . . 1           . 1 2 3 4 5 6
5 6 7 8 9 10 11         2 3 4 5 6 7 8           7 8 9 10 11 12 13
12 13 14 15 16 17 18    9 10 11 12 13 14 15     14 15 16 17 18 19 20
19 20 21 22 23 24 25    16 17 18 19 20 21 22    21 22 23 24 25 26 27
26 27 28 29 30 31 .     23 24 25 26 27 28 29    28 29 . . . . .
                        30 . . . . . .
```

Dodatkowo: 22 października jest podświetlony (`dzis`), w listopadzie klasę `wolne` ma także 11 (święto w środę), a luty 2028 ma 29 dni. Dla `(2026, 13)` pojawia się komunikat o błędzie.

**Podpowiedzi:** `$pierwszy = mktime(0, 0, 0, $mies, 1, $rok);` — `date('t', $pierwszy)` daje liczbę dni miesiąca, `date('N', $pierwszy)` numer dnia tygodnia (1 = poniedziałek … 7 = niedziela), więc pustych komórek na początku jest `N − 1`. Licz kolumny w pętli i po siódmej zamykaj wiersz `</tr><tr>`. Uważaj, żeby nie dodać pustego wiersza po ostatnim dniu, gdy miesiąc kończy się w niedzielę.

**Przykładowe rozwiązanie:**

```php
<?php
declare(strict_types=1);
date_default_timezone_set('Europe/Warsaw');

const MIESIACE = [1 => 'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec',
                  'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'];

/**
 * Zwraca kalendarz miesiąca jako tabelę HTML (tydzień od poniedziałku).
 * $swieta - numery dni miesiąca, które są świętami.
 */
function kalendarz(int $rok, int $mies, array $swieta = [], ?int $dzis = null): string
{
    if (!checkdate($mies, 1, $rok)) {
        return '<p>Niepoprawny miesiąc lub rok</p>';
    }
    $pierwszy = mktime(0, 0, 0, $mies, 1, $rok);
    $ileDni = (int)date('t', $pierwszy);
    $pustych = (int)date('N', $pierwszy) - 1;           // N: 1 = poniedziałek ... 7 = niedziela

    $html = '<table class="kal"><caption>' . MIESIACE[$mies] . ' ' . $rok . '</caption>';
    $html .= '<tr><th>Pn</th><th>Wt</th><th>Śr</th><th>Cz</th><th>Pt</th><th>So</th><th>Nd</th></tr><tr>';

    for ($i = 0; $i < $pustych; $i++) {
        $html .= '<td></td>';
    }
    $kolumna = $pustych;
    for ($d = 1; $d <= $ileDni; $d++) {
        $klasy = [];
        if ($kolumna >= 5 || in_array($d, $swieta, true)) {
            $klasy[] = 'wolne';
        }
        if ($dzis !== null && (int)date('Y', $dzis) === $rok && (int)date('n', $dzis) === $mies && (int)date('j', $dzis) === $d) {
            $klasy[] = 'dzis';
        }
        $html .= '<td' . ($klasy ? ' class="' . implode(' ', $klasy) . '"' : '') . '>' . $d . '</td>';
        $kolumna++;
        if ($kolumna === 7 && $d < $ileDni) {
            $html .= '</tr><tr>';
            $kolumna = 0;
        }
    }
    while ($kolumna < 7 && $kolumna > 0) {     // dopełnienie ostatniego tygodnia
        $html .= '<td></td>';
        $kolumna++;
    }
    return $html . '</tr></table>';
}
?>
<!DOCTYPE html>
<html lang="pl"><head><meta charset="UTF-8"><title>Kalendarz</title>
<style>
 .kal{border-collapse:collapse;margin:1rem;display:inline-table}
 .kal caption{font-weight:bold;padding:.3rem}
 .kal th,.kal td{border:1px solid #999;width:2.4rem;height:2rem;text-align:center}
 .kal th{background:#eee} .wolne{color:#c00} .dzis{background:#ffd54f;font-weight:bold}
</style></head><body>
<?php
$dzis = mktime(0, 0, 0, 10, 22, 2026);       // do testów; na co dzień: mktime(0, 0, 0)
echo kalendarz(2026, 10, [], $dzis);
echo kalendarz(2026, 11, [1, 11], $dzis);
echo kalendarz(2028, 2);
echo kalendarz(2026, 13);
?>
</body></html>
```
