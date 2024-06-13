---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[00 Алгоритмы]]"
  - "[[00 Java разработка]]"
parents:
  - "[[Бинарный поиск]]"
linked: 
link: https://struchkov.dev/blog/ru/java-binary-search/
---
### Без рекурсии
```java
public class Binary {

    public static void main(String[] args) {
        int[] values = {1, 1, 2, 3, 4, 10};
        int valueToFind = 3;

        System.out.printf("Index = %d%n", binarySearch(values, valueToFind, 0, values.length - 1));
    }

    private static int binarySearch(int[] sortedArray, int valueToFind, int low, int high) {
        int index = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (sortedArray[mid] < valueToFind) {
                low = mid + 1;
            } else if (sortedArray[mid] > valueToFind) {
                high = mid - 1;
            } else if (sortedArray[mid] == valueToFind) {
                index = mid;
                break;
            }
        }
        return index;
    }

}
```

### С использованием рекурсии
```java
public class Binary {

    public static void main(String[] args) {
        int[] values = {1, 1, 2, 3, 4, 10};
        int valueToFind = 3;

        System.out.printf("Index = %d%n", binarySearch(values, valueToFind, 0, values.length - 1));
    }

    private static int binarySearch(int[] values, int valueToFind, int l, int r) {
        if (l == r) {
            return (values[l] == valueToFind) ? l : -1;
        }

        int m = l + (r - l) / 2;

        if (valueToFind > values[m]) {
            return binarySearch(values, valueToFind, m + 1, r);
        } else if (values[m] > valueToFind) {
            return binarySearch(values, valueToFind, l, m - 1);
        }
        return m;
    }

}
```

Если элемент не найден, то вернется `-1`.

> [!WARNING] m = l + (r - l) / 2;
> Во многих примерах в интернете можно встретить запись `int m = (l + r) / 2;`, вместо `int mid = l + (r - l) / 2;`. И у меня в заметке тоже была такая запись, пока один из читателей не обратил на это внимание.
> 
> Но использование второго варианта является лучшей практикой, так как это помогает избежать переполнения, когда размер массива велик.
> 
> Например, если `l = 2147483647` и `r = 2147483647`, сумма `l` и `r` будет равна 4294967294, что превышает максимальное значение, которое может удерживать `int`, вызывая переполнение.
> 
> С другой стороны, если вы используете `mid = l + (r - l) / 2;` это будет работать, как и ожидалось, потому что вычитание будет сделано первым, а результат будет равен нулю, поэтому деление будет равно нулю, а сложение вернет значение `l`.