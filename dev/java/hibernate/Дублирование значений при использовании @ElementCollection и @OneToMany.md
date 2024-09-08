---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-09-06
zero-link:
  - "[[../../../meta/zero/00 Hibernate|00 Hibernate]]"
parents: 
linked: 
---
Столкнулся с неочевидным поведением `@ElementCollection` в связке с `@OneToMany`. Может случиться так, что в `@OneToMany` будет дублирование значений из-за `@ElementCollection`. Проще объяснить на примере.

Допустим у нас есть три таблицы: `user`, `user_nickname`, `address`. Есть сущность `User`:

```java
@Entity
public class User {

    // ... ... ... ... ...

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private List<Address> stages = new ArrayList<>();

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "user_nickname",
            joinColumns = @JoinColumn(name = "user_id")
    )
    @Column(name = "nickname")
    private Set<String> nicknames = new HashSet<>();

    // ... ... ... ... ...

}
```

Допустим у нас одна запись про пользователя, у которого есть три адреса и один никнейм. В этом случае все хорошо, все придет корректно.

==Добавим этому пользователю еще один никнейм. Теперь мы получаем шесть адресов и два никнейма. Откуда взялись еще три лишних адреса, в базе данных их все еще три.== Это дубликаты. При этом, если вы воспользуетесь пагинацией JPA, то дублей уже не будет. It is magic 💫

Магии в программировании, как вы понимаете, нет. Они создаются при использовании `FetchType.EAGER` у `@OneToMany` в совокупности с `@ElementCollection(fetch = FetchType.EAGER)`. Hibernate генерирует запрос с двумя-тремя полными соединениями, отсюда и берутся дубли. При этом в пагинации Hibernate не генерирует джойны, а использует кучу селектов, отсюда и отсутствие дублей при пагинации.

Эта проблема решается несколькими способами:

- Переделайте `List` в `Set` у `@OneToMany`.
- Уберите `FetchType.EAGER` у `@OneToMany`.
- Добавьте `@Fetch(FetchMode.SUBSELECT)` у `@OneToMany`. это аннотация Hibernate, которая вместо JOIN использует подзапрос. О [подзапросах я писал в отдельной статье](https://struchkov.dev/blog/ru/select-subquery).