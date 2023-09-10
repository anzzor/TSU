# ЛАБОРАТОРНАЯ РАБОТА № 0

>## I. Основы
>>### 1. Даны 2 целых числа. Вычислите их произведение.
``` Pascal
program Multiplication;

var num1, num2: integer;

begin
    writeln('Введите два числа: '); readln(num1, num2);
    writeln(num1, '*', num2, '=', num1 * num2);

end.
```
>## II. Ветвления
>>### 2. Даны 3 числа. Выведите числа в порядке возрастания.
```pascal
program ThreeIntegersInAscendingOrder;
var
    num1, num2, num3, temp : integer;
begin
  write('Type three numbers through the space: '); readln(num1, num2, num3);
  
  if num1 > num2 then
    begin
        temp := num1;
        num1 := num2;
        num2 := temp;
     end;
  
  if num1 > num3 then
    begin
        temp := num1;
        num1 := num3;
        num3 := temp;
    end;
  
  if num2 > num3 then
    begin
        temp := num2;
        num2 := num3;
        num3 := temp;
    end;
  
  writeLn('Numbers in ascending order : ', num1, ' ', num2, ' ', num3);
  
end.
```
>>### 3. Даны координаты центра и радиус круга. Определите, лежит ли точка с заданными координатами внутри круга (все значения вещественные).
```pascal
program PointInCircleOrNo;
var
    cx, cy, x, y, radius, hypotenuse : Real;
begin
  write('Enter the Coordinates of the Centre of the Circle as (CX CY): ');
  readln(cx, cy);
  write('Enter the Radius of the Circle: ');
  readln(radius);
  write('Enter the Coordinates of the Point as (X Y): ');
  readln(x, y);
  
  hypotenuse := Sqrt(Sqr(x - cx) + Sqr(y - cy));
  
  if hypotenuse < radius then
    writeln('The point exists inside the circle.')
  else if hypotenuse = radius then
    writeln('The point lies on the circumference of the circle.')
  else
    writeln('The point is outside the circle.');
  
end.
```
>## III. Циклы.
>>### 4. Без деления найдите целую часть частного и остаток от деления двух заданных целых чисел.
```pascal
program IntegerQuotientAndRemainder;

var
  dividend, divisor, quotient, remainder: Integer;

begin
  write('Enter the dividend : ');
  readLn(dividend);
  
  write('Enter the divisor : ');
  readln(divisor);
  
  quotient := 0;
  remainder := dividend;
  
  while remainder >= divisor do
  begin
    remainder := remainder - divisor;
    quotient := quotient + 1;
  end;
  
  writeln('Integer quotient : ', quotient);
  writeln('Remainder : ', remainder);
end.
```
>## IV. Массивы.
>>### 5.  Поменяйте местами последний максимальный и первый минимальный элемент массива и выведите весь массив.
```pascal
program SwapMinMax;
const
  N = 10; // Размер массива
var
  arr: array[1..N] of integer;
  i, minIndex, maxIndex, minValue, maxValue, temp: integer;
begin
  // Ввод элементов массива
  writeln('Введите элементы массива:');
  for i := 1 to N do
  begin
    write('arr[', i, '] = ');
    readln(arr[i]);
  end;

  // Ищем индексы минимального и максимального элементов
  minIndex := 1;
  maxIndex := 1;
  minValue := arr[1];
  maxValue := arr[1];

  for i := 2 to N do
  begin
    if arr[i] < minValue then
    begin
      minValue := arr[i];
      minIndex := i;
    end
    else if arr[i] > maxValue then
    begin
      maxValue := arr[i];
      maxIndex := i;
    end;
  end;

  // Меняем местами минимальный и максимальный элементы
  temp := arr[minIndex];
  arr[minIndex] := arr[maxIndex];
  arr[maxIndex] := temp;

  // Выводим массив после замены
  writeln('Массив после замены:');
  for i := 1 to N do
    write(arr[i], ' ');
  readln;
end.
```

