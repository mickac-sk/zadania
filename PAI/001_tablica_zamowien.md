Masz tablicę zamówień ze sklepu internetowego. Napisz skrypt, który przeanalizuje każde zamówienie, naliczy rabat, przetłumaczy status na język polski oraz ustali koszt dostawy.

1. Przeiteruj po liście zamówień.
2. Wyznacz rabat procentowy zależnie od typu klienta:
    - 'VIP' -> 20%
    - 'REGULAR' -> 10%
    - Inne / 'GUEST' -> 0%
3. Przetłumacz kod statusu zamówienia ('NEW', 'PAID', 'SHIPPED', 'CANCELLED') na opis czytelny dla użytkownika.
4. Określ status dostawy na podstawie kwoty po rabacie:
    - Jeśli zamówienie jest anulowane -> brak dostawy.
    - Jeśli kwota końcowa wynosi co najmniej 200 zł -> darmowa dostawa.
    - W przeciwnym razie -> koszt dostawy 15 zł.
  
```php
$orders = [
    ['id' => 101, 'customer_type' => 'VIP',     'status' => 'PAID',      'amount' => 250],
    ['id' => 102, 'customer_type' => 'REGULAR', 'status' => 'NEW',       'amount' => 180],
    ['id' => 103, 'customer_type' => 'GUEST',   'status' => 'SHIPPED',   'amount' => 300],
    ['id' => 104, 'customer_type' => 'REGULAR', 'status' => 'CANCELLED', 'amount' => 50],
];
```
