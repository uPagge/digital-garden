# ConcurrentModificationException

Этот код отработает нормально без исключения. Метод, который генерирует исключение не будет вызван, так как исключение вызвает метод next() итератора, а без второго элемента он не будет вызван.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {

    public static void main(String[] args) {
        Map<String, String> map = new HashMap<>();
        map.put("a", "a");

        for (String key : map.keySet()) {
            map.remove(key);
        }
    }

}
```
