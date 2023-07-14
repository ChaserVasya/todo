# Список дел
<img src="https://github.com/ChaserVasya/todo/assets/74578917/f4f3f701-1eb9-4f4f-a9e1-13fd61c0bb57"  width="200" height="200">

- ссылка на apk: https://github.com/ChaserVasya/todo/releases/download/3.1/app-release.apk
- cсылка на реквест для проверки: https://github.com/ChaserVasya/todo/pull/1

# Проверка дз 3
диплинк добавления задания `adb shell 'am start -W -a android.intent.action.VIEW -d "todo://example.com/edit"'`

для запуска интеграционного теста раскоментьте тестовый `_Env` в `env.dart` и закоментьте `part 'env.g.dart';`
  
## Реализованные фичи
- есть иконка
- есть логгирование
- есть локализация с помощью intl + Flutter intl плагин для AS
- применяется flutter-lints
- встроены дип-линки
- есть синхронизация данных с бэком при старте приложения

## Слои
Слои сделаны по принципу layer-first.
- data-слой содержит 
  - локальные бд в `storages`
  - удалённые бд в `services`
  - вспомогательные утилиты в `services`
- domain-слой содержит абстракции
- application-слой содержит "точки связи", вроде, MaterialApp, di, globals.
- presentation-слой содержит содержит блоки и вёрстку.

## Реализованная логика
- удаление Todo
- создание Todo
- удаление и выполнение Todo по свайпу влево\вправо
- редактирование Todo
- фильтрация Todo по выполненности

## Реализованные тесты
- просто тесты
  - реализован тест репозитория ревизии
  - реализован тест репозитория для работы с бэком
  - реализован тест парсера дип-линков
- реализован интеграционный тест добавления задания.

## Скриншоты
![Screenshot_20230616_082027](https://github.com/ChaserVasya/todo/assets/74578917/e51898a1-4f77-41e5-980e-7d6724c65e38)
![Screenshot_20230616_082056](https://github.com/ChaserVasya/todo/assets/74578917/a3bc2473-a337-4fd5-9b70-e5e06c287df8)
![Screenshot_20230616_082213](https://github.com/ChaserVasya/todo/assets/74578917/e1e5cc67-d5de-49a7-9e54-a8122ff13ed7)
![Screenshot_20230616_082408](https://github.com/ChaserVasya/todo/assets/74578917/e510d9dd-3975-48f6-ad4d-d738d9b21874)
![Screenshot_20230616_082419](https://github.com/ChaserVasya/todo/assets/74578917/660f8d11-4c94-4c0c-add2-9baa5f1edbec)
