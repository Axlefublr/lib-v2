Notes_Code := [

	"clickthrough gui",
	"+E0x20`nWinSetTransparent(255, guiWinTitle)",

	"invisible dynosaur",
	"Runner.instance_.gameOver = () => {}",

	"iframe website inside of website",
	'<iframe src="URL" width="200" height="200"></iframe>',

	"bash if statements", "
	(
		if [ $name == "Alisa" ]; then
			echo "Your name is $name"
		elif [ $name == "AnotherName" ]; then
		echo "Your name is $name"
		else
			echo "Your name is not Alisa"
		fi
	)",

	"C# console encoding", "
	(
		Console.OutputEncoding = Encoding.Unicode;
		Console.InputEncoding  = Encoding.Unicode;
	)",

	"html subscript underscript",
	"<sub>subscript</sub>",

	"html superscript",
	"<sup>superscript</sup>",

	"css set background image",
	"background-image: url('yourSite.com');",

	"css attribute matching", "
	(
		exact: a[href="#Food"]
		inStr: a[href *= "ou"]
			   a[href *= ou]
		end:   a[href $= "ouse"]
		start: a[href ^= "Hou"]
	)",

	"css combined selectors", "
	(
		div, p
		selects div and p
		div p
		selects p that's inside of a div
		(any level)
		div > p
		selects only p directly inside of div
		div ~ p
		selects p if it goes after a sister div
		div + p
		selects *all* p that go after a sister div
	)",

	"css pseudoclasses", "
	(
		:hover (наведение на объект, чаще всего кнопку или ссылку).
		:visited (посещённая ранее ссылка).
		:focus (элемент с фокусом на нём, например, элемент формы).
		:first-child и :last-child (первый и последний подобный встречающийся элемент, например, li:first-child первый элемент списка).
		:nth-child(число) (касается конкретного элемента, например, li:nth-child(2) — второй элемент <li>).
		:nth-child(odd) (все нечётные элементы).
		:nth-child(even) (все чётные элементы).
		:first-of-type и :nth-of-type (первый и n-ный элемент какого-либо типа).
		:disabled (недоступный элемент, например, button:disabled — кнопка, на которую невозможно нажать).
	)",

	"css selector weight", "
	(
		style=""     1000
		#id          100
		.class       10
		[attr=value] 10
		li           1
		*            0
	)",

    "js redirect",
    "window.location.href = 'https://www.google.com'",

]