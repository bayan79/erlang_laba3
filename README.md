Лабораторная работа №3. Ход работы

Для начала изменил работу номер 2 `bayan79/erlang_laba2`:
теперь его можно использовать как плагин в `rebar` (см. `rebar.config`).

С n2o не получалось запускать даже начальное приложение `mad app nitro app1`, поэтому работа сделана на `nitrogen`.

## Установка/проверка:

1) Скачать nitrogen:

    git clone https://github.com/nitrogen/nitrogen.git

2) СОздать базовое приложение 

    make slim_cowboy PROJECT=$PROJECT_NAME PREFIX=$PROJECT_PATH

3) Скачать erlang_laba3:

    git clone https://github.com/bayan79/erlang_laba3.git

4) Скопировать erlang_laba3/rebar.config и erlang_laba3/site/* в $PROJECT_PATH/$PROJECT_NAME/rebar.config и $PROJECT_PATH/$PROJECT_NAME/site/* соответственно

5) Не забыть ввести куки-ключ в $PROJECT_PATH/$PROJECT_NAME/etc/vm.args для связи узлов кластера

6) Собрать проект
   
   make

## Запуск
1) Запустить узлы `host1@127.0.0.1` и `host2@127.0.0.1` c куки-ключом

2) Из папки $PROJECT_PATH/$PROJECT_NAME:

  bin/nitrogen console

3) Открыть http://localhost:8000/

## Демонстрация

- Добавление #person{name, age}

[!Добавление](adding.png)

-