&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Заголовок") Тогда
		Заголовок  = Параметры.Заголовок;
	КонецЕсли;

	Текст=Параметры.Текст;
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	Закрыть(Текст);
КонецПроцедуры