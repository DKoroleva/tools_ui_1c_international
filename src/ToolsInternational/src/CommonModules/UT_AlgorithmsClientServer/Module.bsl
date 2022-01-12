#Область СлужебныеПроцедуры

Функция НормализоватьТекст(Текст, МеткаEndOfText = Истина, СтрокаСлов = "") Экспорт
	КодАлгоритма = СтрЗаменить(Текст, Символы.Таб, " ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, Символы.ПС, " ^ ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "=", " = ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "+", " + ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "<", " < ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, ">", " > ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, ";", " ; ");

	Для А = 0 По Окр(Sqrt(СтрЧислоВхождений(КодАлгоритма, "  ")), 0) Цикл
		КодАлгоритма = СтрЗаменить(КодАлгоритма, "  ", " ");
	КонецЦикла;
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "< =", "<=");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "> =", ">=");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "< >", "<>");
	МассивСлов = СтрРазделить(КодАлгоритма, " ");
	СтрокаСловПоумолчанию = "Возврат,И,Или,Не,Если,Тогда,КонецЕсли,Для,Каждого,Из,Пока,Цикл,КонецЦикла";
	МассивСлужебныхСлов = СтрРазделить(?(ПустаяСтрока(СтрокаСлов), СтрокаСловПоумолчанию, СтрокаСлов), ",");
	Для Слово = 0 По МассивСлов.ВГраница() Цикл
		Для Каждого СлужебноеСлово Из МассивСлужебныхСлов Цикл
			Если НРег(СокрЛП(МассивСлов[Слово])) = НРег(СлужебноеСлово) Тогда
				МассивСлов[Слово] = СлужебноеСлово;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	КодАлгоритма = СтрСоединить(МассивСлов, " ");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "^", Символы.ПС);
	Если МеткаEndOfText И Найти(КодАлгоритма, "~EndOfText:") = 0 Тогда
		КодАлгоритма = КодАлгоритма + Символы.ПС + "~EndOfText:";
	КонецЕсли;
	Возврат КодАлгоритма;
КонецФункции

Функция МассивИсключаемыхСимволов() Экспорт
	мИсключая = СтрРазделить(";,+, = ,-,),(,.,[,],{,},|,/,\,>,<,$,@,#", ",");
	мИсключая.Добавить(Символы.ПС);
	мИсключая.Добавить(Символы.Таб);
	мИсключая.Добавить(Символ(32));
	мИсключая.Добавить(",");
	мИсключая.Добавить("""");
	Возврат мИсключая;
КонецФункции

Функция ПреобразоватьТекстВКодАлгоритма(Текст) Экспорт
	КодАлгоритма = НормализоватьТекст(Текст);
	мИсключая = МассивИсключаемыхСимволов();
	пЗаменаВставка(КодАлгоритма, "@ВычислитьФункцию", "_37583_АлгоритмыСервер.ВыполнитьФункцию", "[""""Результат""""]",
		мИсключая);
	пЗаменаВставка(КодАлгоритма, "@РезультатФункции", "_37583_АлгоритмыСервер.ВыполнитьФункцию", "[""Результат""]",
		мИсключая);
	пЗаменаВставка(КодАлгоритма, "@РезультатФункцииКлиент", "_37583_АлгоритмыКлиент.ВыполнитьФункцию",
		"[""Результат""]", мИсключая);
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@ПроцедураКлиент", "_37583_АлгоритмыКлиент.ВыполнитьПроцедуру");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@ПроцедураКлиентАсинхронно", "_37583_АлгоритмыКлиент.ВыполнитьПроцедуру");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@ФункцияКлиент", "_37583_АлгоритмыКлиент.ВыполнитьФункцию");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@Процедура", "_37583_АлгоритмыСервер.ВыполнитьПроцедуру");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@Функция", "_37583_АлгоритмыСервер.ВыполнитьФункцию");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@ПеременныеСреды", "_37583_АлгоритмыКэш.ПолучитьПараметры_37583()");
	пЗаменаВставка(КодАлгоритма, "#", "[""", """]", мИсключая);
	пЗаменаВставка(КодАлгоритма, "$$", "this[", "]", мИсключая);
	пЗаменаВставка(КодАлгоритма, "$'", "this[""""", """""]", мИсключая);
	пЗаменаВставка(КодАлгоритма, "$", "this[""", """]", мИсключая);
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "@", "Параметры.");
	КодАлгоритма = СтрЗаменить(КодАлгоритма, "Возврат ;", "Перейти ~EndOfText;");
	//КодАлгоритма = СтрЗаменить(КодАлгоритма,"Возврат ","this[""Результат""] = ");
	пЗаменаВставка(КодАлгоритма, "Возврат ", "this[""Результат""] = ", "; Перейти ~EndOfText", ";", " ");

	Возврат КодАлгоритма;
КонецФункции

Процедура пЗаменаВставка(КодАлг, Префикс, До = "", После = "", Исключая = "", Включая = "") Экспорт
	Пока Найти(КодАлг, Префикс) > 0 Цикл
		Слово = ПолучитьПервоеВхождениеСловоБезПрефикса(КодАлг, Префикс, Исключая, Включая);
		КодАлг = СтрЗаменить(КодАлг, Префикс + Слово, До + Слово + После);
	КонецЦикла;
КонецПроцедуры

Функция фЗаменаВставка(Знач КодАлг, Префикс, До = "", После = "", Исключая = "", Включая = "") Экспорт
	Пока Найти(КодАлг, Префикс) > 0 Цикл
		Слово = ПолучитьПервоеВхождениеСловоБезПрефикса(КодАлг, Префикс, Исключая, Включая);
		КодАлг = СтрЗаменить(КодАлг, Префикс + Слово, До + Слово + После);
	КонецЦикла;
	Возврат КодАлг;
КонецФункции

Функция ПолучитьПервоеВхождениеСловоБезПрефикса(Строка, Преф, Исключая = ";,+, = ,-,),(,.,[,],{,},|,/,\,>,<",
	Включая = "") Экспорт
	ДлинаПреф = СтрДлина(Преф);
	ПозПрефикс = СтрНайти(Строка, Преф) + ДлинаПреф;

	Если ТипЗнч(Включая) = Тип("Массив") Тогда
		мВключая = Включая;
	Иначе
		мВключая = СтрРазделить(Включая, ",");
	КонецЕсли;

	Если ТипЗнч(Исключая) = Тип("Массив") Тогда
		мИсключая = Исключая;
	Иначе
		мИсключая = СтрРазделить(Исключая, ",");
	КонецЕсли;

	мТерм = Новый Массив;
	Для Каждого СимволИсключая Из мИсключая Цикл
		Если мВключая.Найти(СимволИсключая) = Неопределено Тогда
			мТерм.Добавить(СтрНайти(Сред(Строка, ПозПрефикс), СимволИсключая));
		КонецЕсли;
	КонецЦикла;

	Терм = 1000000;
	Для Каждого Элемент Из мТерм Цикл
		Если Элемент > 0 И Элемент < Терм Тогда
			Терм = Элемент;
		КонецЕсли;
	КонецЦикла;

	Слово = ?(Терм < 1000000, Сред(Строка, Найти(Строка, Преф) + ДлинаПреф, Терм - 1), Сред(Строка, Найти(Строка, Преф)
		+ ДлинаПреф));
	Возврат Слово;
КонецФункции

#КонецОбласти

#Область ВыполнениеАлгоритмов

Функция ВыполнитьАлгоритм(Алгоритм, ВходящиеПараметры = Неопределено, ОшибкаВыполнения = Ложь, СообщениеОбОшибке = "") Экспорт
	АлгоритмСсылка = UT_CommonServerCall.GetRefCatalogAlgorithms(Алгоритм);
	Если АлгоритмСсылка = Неопределено Или Не ЗначениеЗаполнено(АлгоритмСсылка) Тогда
		СообщениеОбОшибке = "Алгоритмы : Ошибка выполнения функции(не определен сценарий " + Алгоритм + " )";
		Если ВходящиеПараметры = Неопределено Тогда
			ВходящиеПараметры = Новый Структура;
		КонецЕсли;
		ВходящиеПараметры.Вставить("Отказ", Истина);
		ВходящиеПараметры.Вставить("СообщениеОбОшибке", СообщениеОбОшибке);
		//        ЗаписатьВЖурналРегистрации(,СообщениеОбОшибке);
		Возврат Новый Соответствие;
	КонецЕсли;

	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура;
		this = Новый Соответствие;
	КонецЕсли;

	//	Для Каждого ХранимыйПараметр Из ХранимыеПараметры Цикл
	//		Если Не Параметры.Свойство(ХранимыйПараметр.Ключ) Тогда 
	//			Параметры.Вставить(ХранимыйПараметр.Ключ,ХранимыйПараметр.Значение);
	//		КонецЕсли;
	//	КонецЦикла;

	СвойстваДляРеквизитовАлгоритма = "Ссылка,ТекстАлгоритма,ВыбрасыватьИсключение,ЗаписыватьОшибкиВЖР,ВыполнятьВТранзакции";

	СвойстваАлгоритма = UT_CommonServerCall.ObjectAttributesValues(АлгоритмСсылка,
		СвойстваДляРеквизитовАлгоритма);

	ИсполняемыйКод = ПреобразоватьТекстВКодАлгоритма(СвойстваАлгоритма.ТекстАлгоритма);

#Если Сервер Тогда
	Если СвойстваАлгоритма.ВыполнятьВТранзакции Тогда
		НачатьТранзакцию();
	КонецЕсли;
#КонецЕсли
	Попытка
		Выполнить (ИсполняемыйКод);

#Если Сервер Тогда
		Если СвойстваАлгоритма.ВыполнятьВТранзакции Тогда
			ЗафиксироватьТранзакцию();
		КонецЕсли;
#КонецЕсли

	Исключение
#Если Сервер Тогда
		Если СвойстваАлгоритма.ВыполнятьВТранзакции Тогда
			Если ТранзакцияАктивна() Тогда
				ОтменитьТранзакцию();
			КонецЕсли;
		КонецЕсли;
#КонецЕсли

		СообщениеОбОшибке = СообщениеОбОшибке + " Ошибка: " + ОписаниеОшибки() + ";";
		ОшибкаВыполнения = Истина;
		Если СвойстваАлгоритма.ЗаписыватьОшибкиВЖР Тогда
//			ЗаписьЖурналаРегистрации("Выполнить процедуры "
//				+ АлгоритмСсылка,Параметры.СообщениеОбОшибке);
		КонецЕсли;
		Если СвойстваАлгоритма.ВыбрасыватьИсключение Тогда
			ВызватьИсключение ОписаниеОшибки();
		КонецЕсли;
	КонецПопытки
	;
///	Объект = Алгоритм.ПолучитьОбъект();
////	Возврат Объект.ВыполнитьФункцию(ДополнительныеПараметры);
КонецФункции

#КонецОбласти