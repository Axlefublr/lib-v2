Notes_Vim := [

	"vim ranges", "
	(
		.`tcurrent line
		%`twhole file
		15,30`trange
		$`tlast line
		.,.+5`tfrom the current line to the line 5 lines down
	)",

	"vim special arguments to remaps", "
	(
		<buffer>
		<nowait>
		<silent>
		<special>
		<script>
		<expr>
		<unique>
	)",

	"vim remap modes", "
	(
		With no specification: Normal, Visual, Select, Operator pending
		n Normal
		v Visual and Select
		s Select
		x Visual
		o Operator pending
		! Insert and Command-Line (after the keyword instead of before)
		i Insert
		l Insert, Command-Line and Lang-Arg
		c Command-Line
		t Terminal-Job
	)",

	"vim settings variables", "
	(
		vim.o`tgeneral setttings
		vim.wo`twindow scoped settings
		vim.bo`tbuffer scoped settings
		vim.g`tglobal settings
		vim.env`tenvironment settings
		vim.opt`tworks for setting pretty much anything
		vim.fn`tcalls a vim function
		vim.call same thing, but you provide the name of the function as a string
	)",

	"vim search offset",
	":help search-offset",

	"vim search regex magic",
	":help magic",

]