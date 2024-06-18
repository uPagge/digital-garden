## Cache miss
По формуле можно расчитать как часто мы будем промахиваться мимо кэша

AverageTime = CacheAccessTime + DbAccessTime \* CacheMissRate
- AverageTime - среднее время жизни кэша
- CacheAccessTime - время доступа к кэшу
- DbAccessTime - время доступа к БД
- CacheMissRate - количество промахов мимо кэша

Пусть
- DbAccessTime = 100ms
- CacheAccessTime = 20ms
- Тогда при CacheMissRate > 0.8 - кэш вреден.