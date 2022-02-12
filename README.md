# MumHotDi - MumbleHotkeyDisabler
Когда Mumble переключился на другое API по определению горячих клавиш (v1.4), то некоторые пользователи столкнулись с [проблемой](https://github.com/mumble-voip/mumble/issues/5472), что нажатая горячая клавиша выполняет действие в системе, которое за ней закреплено.  
У меня например PTT кнопка, это "Back" на мышке, и теперь, когда я что-то говорю, браузер постоянно переходит "Назад", бесит.

Так и появился этот скрипт на [AutoHotkey](https://github.com/AutoHotkey/AutoHotkey).  
Логика его работы довольно проста, он монопольно занимает горячую клавишу пустым действием, в итоге системное действие она уже не отрабатывает, но Mumble нажатие определяет. То, что надо!

## Как запускать
**Так:**  
**`MumHotDi.exe <ahk идентификатор клавиши> [mumble exe]`**  
Список клавиш (`<ahk идентификатор клавиши>`) можно взять [здесь](https://www.autohotkey.com/docs/KeyList.htm)  
Также можно использовать `KeyHistoryViewer` для прросмотра кодов клавиш.  
*Запускаете его, жмете нужную клавишу, потом жмете `F5` и смотрите код клавиши в столбце `Key`*

Удобнее всего создать ярлык и в  его свойствах, в поле `Объект`, после `MumHotDi.exe`*(может быть в кавычках)* дописать ` <ahk идентификатор клавиши>`  
* **Пример**  
  Вот пример строки `Объект` из моего ярлыка:  
  `B:\Dev\AutoHotkey\MumHotDi\MumHotDi.exe XButton1` 

Если вторым аргументом указать путь к исполняемому файлу (`[mumble exe]`), то при запуске скрипта сначала будет запущен сторонний exe, и после 5 секунд ожидания, скрипт продолжит работу. Удобно запускать сразу и Mumble + MumHotDi.

* **Пример**  
  Чтобы автоматом запустить Mumble можно указать полный путь к `mumble.exe` во втором аргументе.  
  `B:\Dev\AutoHotkey\MumHotDi\MumHotDi.exe XButton1 "C:\Program Files\Mumble\client\mumble.exe"`

## Особенности
* Для удобства скрипт проверяет наличие запущенного клиента Mumble каждые 30 секунд и автоматически "освобождает" горячую клавишу. 
  Если Mumble не найден, то клавиша освобождается и выполняет свою системную функцию.
* Можно 2 раза кликнуть на иконке в трее, и проверка на запущенный Mumble отработает без ожидания 30 сек.
  Если Mumble уже найден, то отобразится его окно. 
* Если вдруг нужна горячая клавиша, когда она отключена *(или наборот)*, то ее можно Включить/Выключить через меню в трее `Force enable/disable hotkey`
* Текущая блокируемая клавиша отображается в подсказке на иконке в трее.

## English
Guys, I'm tired to write this README in Russian. Please use an online translator (e.g. [DeepL](https://www.deepl.com/translator), which I used to write this text for you 🙂)

## Thx
* AutoHotkey (https://www.autohotkey.com/)
* Иконки от Mumble (https://www.mumble.info/) + famfamfam(http://famfamfam.com/)

---
(с) prog4food 2o22
