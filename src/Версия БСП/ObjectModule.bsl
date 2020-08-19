﻿
//ПОДГОТОВКА РЕГИСТРАЦИИ ОБРАБОТКИ

Функция СведенияОВнешнейОбработке() Экспорт
  
  ПараметрыРегистрации = Новый Структура;
  ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка"); //Варианты: "ДополнительнаяОбработка", "ДополнительныйОтчет", "ЗаполнениеОбъекта", "Отчет", "ПечатнаяФорма", "СозданиеСвязанныхОбъектов" 
  
  
  ПараметрыРегистрации.Вставить("Наименование", "<Наименование элемента Справочника дополнительных обработок>");
  ПараметрыРегистрации.Вставить("Версия", "1.0"); //"1.0"
  ПараметрыРегистрации.Вставить("БезопасныйРежим", Истина); //Варианты: Истина, Ложь
  ПараметрыРегистрации.Вставить("Информация", "<Краткое описание обработки>");
  ПараметрыРегистрации.Вставить("ВерсияБСП", "1.2.1.4");// не ниже какой версии БСП подерживается обработка

  ТаблицаКоманд = ПолучитьТаблицуКоманд();

  ДобавитьКоманду(ТаблицаКоманд,
          "<Имя команды>",
          "<ИдентификаторКоманды1>",
          "ОткрытиеФормы",  //Использование.  Варианты: "ОткрытиеФормы", "ВызовКлиентскогоМетода", "ВызовСерверногоМетода"   
          Истина,//Показывать оповещение. Варианты Истина, Ложь 
          "");//Модификатор 


  ДобавитьКоманду(ТаблицаКоманд,
          "<Имя команды> для автоматического исполнения",
          "<ИдентификаторКоманды2>",
          "ВызовСерверногоМетода",  //Использование.  Варианты: "ОткрытиеФормы", "ВызовКлиентскогоМетода", "ВызовСерверногоМетода"   
          Ложь,//Показывать оповещение. Варианты Истина, Ложь 
          "");//Модификатор 


  ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);

  Возврат ПараметрыРегистрации;

КонецФункции

Функция ПолучитьТаблицуКоманд()

  Команды = Новый ТаблицаЗначений;
  Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
  Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
  Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
  Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
  Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));

  Возврат Команды;

КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

  НоваяКоманда = ТаблицаКоманд.Добавить();
  НоваяКоманда.Представление = Представление;
  НоваяКоманда.Идентификатор = Идентификатор;
  НоваяКоманда.Использование = Использование;
  НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
  НоваяКоманда.Модификатор = Модификатор;

КонецПроцедуры




// ФУНКЦИОНАЛЬНАЯ ЧАСТЬ
Процедура  ВыполнитьКоманду(ИдентификаторКоманды, ПараметрыВыполненияКоманды) Экспорт
	
	ДополнительнаяОбработкаСсылка = ПараметрыВыполненияКоманды.ДополнительнаяОбработкаСсылка;
	ХранилищеНастроек = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДополнительнаяОбработкаСсылка,"ХранилищеНастроек");
	Настройки = ХранилищеНастроек.Получить();
	
	Если Настройки <> Неопределено Тогда
			Для каждого ЭлементНастроек Из Настройки Цикл
				ЭтотОбъект[ЭлементНастроек.Ключ] = ЭлементНастроек.Значение;
			КонецЦикла; 
	КонецЕсли;

	ВыполнитьФункционал(ИдентификаторКоманды); //там - сама обработка

КонецПроцедуры

Процедура ВыполнитьФункционал(ИдентификаторКоманды)  Экспорт
    
//<сама обработка>  


	   //Попытка
	   // 
	   // ТекстКомментария = "Выполнено <обработка> для объекта: "+ВыборкаДетальныеЗаписи.СсылкаПРЕДСТАВЛЕНИЕ;
	   // ЗаписьЖурналаРегистрации("Обработка:<НазваниеОбработки>", УровеньЖурналаРегистрации.Примечание,,ВыборкаДетальныеЗаписи.Ссылка,ТекстКомментария );
	   //
	   //Исключение
	   // ТекстКомментария = "Не удалось провести документ: "+ВыборкаДетальныеЗаписи.СсылкаПРЕДСТАВЛЕНИЕ;
	   // ЗаписьЖурналаРегистрации("Обработка:<НазваниеОбработки>", УровеньЖурналаРегистрации.Ошибка,,ВыборкаДетальныеЗаписи.Ссылка,ТекстКомментария );
	   //
	   //КонецПопытки; 


КонецПроцедуры
 
