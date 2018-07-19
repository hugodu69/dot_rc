"directory indique a vim où mettre les swap files a la place du dossier courrant
"le double slash demande a vim de donner au swap file un nom avec son chemin d'acces pour eviter que deux fichiers du meme noms posent un probleme
set directory=~/.vim/swapfiles//

colo torte	"utilise la coloration 'torte'
set tabstop=2	"regle une tabulation egale a deux espaces
set autoindent	"indent chaque nouvelle ligne comme la precedente
set number	"ajout les numeros de ligne
"set mouse=a	"permet d'utiliser la souris

"pour mettre en gras ce qui est écrit entre asterisks
set concealcursor=n
set conceallevel=3
"les trois lignes suivantes sont lancees par des auto commands pour declancher leur action malgre que les hilighting groups soient nettoyes par la commande 'hi clear' du fichier $VIMRUNTIME/color/default.vim
"autocmd ColorScheme *
hi AsteriskBold ctermfg=Green cterm=bold
autocmd BufEnter * syn match Asterisks contained "**" conceal
autocmd BufEnter * syn match AsteriskBold "\*\*[^*]\+\*\*" contains=Asterisks


"remplis les elements de base d'un fichier html
command! Html 0s/^/<!DOCTYPE html>\r<html>\r\t<head>\r\t\t<meta charset="UTF-8">\r\t\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\r\t\t<title><\/title>\r\t\t<link href=".\/style.css" type="text\/css" rel="stylesheet">\r\t\t<script type="text\/javascript" src="script.js" defer><\/script>\r\t<\/head>\r\r\t<body>\r\t<\/body>\r<\/html>



"----------------------------------------------------------------
"pour transformer un text html et/ou css en sa version affichable
"----------------------------------------------------------------
"remplace < et > par &lt; et &gt;
command! Compare %s/</\&lt;/g <bar> %s/>/\&gt;/g
"remplir les lignes vides avec des <br>
command! Ligne %s/^\n/<br>\r
"ajoute <p> et </p> en debut et fin de lignes
command! Paragraph %s/^/<p>/g <bar> %s/$/<\/p>/g
"remplace les indentations par deux espaces &nbsp
command! Indenta %s/\t/\&nbsp\&nbsp\&nbsp/g
"remplace les &lt; et &gt; autour des commentaires par CS et CE
command! Savecomment %s/&lt;!--/CS/g <bar> %s/--&gt;/CE/g
"entoure les tag apres < ou </ par <span id="tag"></span>
command! Tag %s#&lt[;/]*\zs[a-z0-9]*\ze#<span id=\"tag\">\0</span>#g
"entoure les signes < et > et / et { et } par <span id="sign"></span>
command! Sign %s#&lt;\zs/\ze#<span id=\"sign\">\0</span>#g <bar> %s#&[lg]t;#<span id=\"sign\">\0</span>#g <bar> %s#[{}]#<span id=\"sign\">\0</span>#g
"entoure les pseudos elements
command! Pseudo %s#:\zs[a-z]*\ze.<span id="sign">{#<span id=\"pseudo\">\0</span>#g
"entoure les selecteurs css avant les { par <span id="selec"></span>
command! Selec %s#<p>\zs[^:{]*\ze.*<span id="sign">{#<span id=\"selec\">\0</span>#g
"entoure les actions css avant les : par <span id="action"></span>
command! Action %s#&nbsp\zs[-a-zA-Z0-9]*\ze:#<span id=\"action\">\0</span>#g
"entoure toutes les specifications des tags html par <span id="special"><span>
command! Special %s#</span>\zs[^>]*\ze<span id="sign">&gt;#<span id=\"special\">\0</span>#g
"entoure les commentaires par <span id="comment"></span>
command! Comment %s#\(CS\)\(.*\)\(CE\)#<span id=\"comment\">\&lt;!--\2--\&gt;</span>#g <bar> %s#/\*.*\*/#<span id=\"comment\">\0</span>#g


function! Editax()
	Compare
	Ligne
	Paragraph
	Indenta
	Savecomment
	Tag
	Sign
	Pseudo
	Selec
	Action
	Special
	Comment
	Start
	End
endfunction


"ajoute toutes les lignes du debut
command! Start 0s/^/<!DOCTYPE html>\r<html>\r<head>\r<style>\r#cadre {\r	position: fixed;\r	top: 10vh;\r	left: calc(50% - 250px);\r	width: 500px;\r	max-width: 80vw;\r	height: 80vh;\r	padding: 10px;\r	overflow: hidden;\r	border-radius: 10px;\r	background-color: rgba(50, 50, 50, 0.9);\r}\r#scroll {\r	height: 100%;\r	width: calc(100% + 25px);\r	box-sizing: border-box;\r	padding-right: 10px;\r	overflow-y: scroll;\r}\r#scroll p {\r	margin: 0;\r	padding: 0;\r	color: #d3d3d3;\r}\r#tag {\r	color: #669999;\r}\r#sign {\r	color: white;\r}\r#action {\r	color: #cc66cc;\r}\r#selec {\r	color: #ff6633;\r}\r#pseudo {\r	color: yellow;\r}\r#special {\r	color: #8585ad;\r}\r#comment {\r	color: #909090;\r}\r<\/style>\r<\/head>\r<body>\r<div id=\"cadre">\r<div id=\"scroll">\r\r<p>\&lt;!DOCTYPE html\&gt;<\/p>\r
"ajoute toutes les lignes de la fin
command! End $s/$/\r\r<\/div>\r<\/div>\r<\/body>\r<\/html>
"----------------------------------------------------------------
"----------------------------------------------------------------
