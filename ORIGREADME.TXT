ÉÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍ»
ºSimpleºSpreadsheetº
ÌÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍ¹
º    VersÆo 0.9    º
ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
(Se aparecerem caracteres estranhos experimente abrir no Turbo Pascal ou no
EDIT.COM)

ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºÖndice                º
ÌÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º1ºIntrodu‡Æo          º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º2ºUtiliza‡Æo b sica   º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º3ºLista de comandos   º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º4ºEstructura do c¢digoº
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º5ºTradu‡Æo            º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º6ºSobre as fun‡äes    º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º7ºSobre a mem¢ria     º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º8ºSobre os gr ficos   º
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
º9ºSobre os coment riosº
ÌÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºAºDistribui‡Æo        º
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

ÉÍËÍÍÍÍÍÍÍÍÍÍ»
º1ºIntrodu‡Æoº
ÈÍÊÍÍÍÍÍÍÍÍÍÍ¼
 O programa Simple Spreadsheet (SS) ‚, como o nome indica, um programa de
cria‡Æo de folhas de c lculo b sicas. Tem suporte para v rias linguas,
c lculos aritm‚ticos e l¢gicos b sicos, cores, gr ficos e impressÆo.

 Foi criado com recurso ao Borland Turbo Pascal 7.0 e ‚ suposto correr em PCs
IBM ou compativeis com sistema operativo DOS.

 Este programa ‚ software livre e pode ser distribuido e modificado sob a
licen‡a GPL (ver COPYING.TXT para mais informa‡äes).

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º2ºUtiliza‡Æo b sicaº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Use os cursores para mudar de c‚lula.
 Use a tecla ENTER para introduzir um valor na c‚lula e prima ENTER de novo
para terminar a inser‡Æo. Use o s¡mbolo '=' se quiser usar uma expressÆo.
 Para usar um comando carregue na tecla ESCAPE e digite o comando seguido de
ENTER (ver sec‡Æo 3. Lista de comandos).

 Use as teclas . e - para copiar e colar, respectivamente, uma celula a
outra (se for uma formula, ela ser  modificada relativamente … posi‡Æo da
primeira celula em rela‡Æo … segunda).

 Use as teclas Z, X e C para mudar o alinhamento do texto na c‚lula.
 Use as teclas W e E para aumentar ou diminuir a dimensÆo da coluna e as
teclas S e D para aumentar ou diminuir a dimensÆo da linha.
 Use as teclas Q e A para mudar a cor de fundo ou do texto, respectivamente,
para as cores actualmente seleccionadas (ver o comando 'select' em baixo).

 Use as teclas O e P para mudar a cor de fundo actualmente seleccionada.
 Use as teclas L e € para mudar a cor do texto actualmente seleccionada.
 Use a tecla K para reverter as cores originais (cinzento claro para o texto,
preto para o fundo).

 As c‚lulas sÆo identificadas atrav‚s do nome da coluna e o n£mero da linha
(por exemplo: A12 ou D4).

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º3ºLista de comandosº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 New                 Cria um novo documento.
 Load                Abre um documento j  existente.
  <NOME DO DOCUMENTO>
 Save                Salva o documento actual.
  <NOME DO DOCUMENTO>
 Select              Muda as cores usadas pelas teclas Q e A.
  Ì Textcolor <NOME DA COR>
  È Backgroundcolor <NOME DA COR>
 Change              Muda as propriedades de uma celula.
  Ì Textcolor <NOME DA COR> <NOME DA CELULA>
  Ì Backgroundcolor <NOME DA COR> <NOME DA CELULA>
  Ì Width <NOME DA CELULA> <NOVO TAMANHO>
  Ì Height <NOME DA CELULA> <NOVO TAMANHO>
  È Alignment <NOME DA CELULA> <NOVO ALINHAMENTO>
 Graph               Cria um gr fico (ver sec‡Æo 8. Sobre os gr ficos).
  <PRIMEIRA CELULA DA LEGENDA> <ULTIMA CELULA DA LEGENDA>
  <PRIMEIRA CELULA DOS VALORES> <ULTIMA CELULA DOS VALORES>
  [TIPO DE GRµFICO]
 Help                Abre o documento de ajuda.
 Print               Imprime o documento actual.
 Translate           Abre o menu com as v rias l¡nguas suportadas.
 Quit                Sai do programa.

Os alinhamentos podem ser:
 Center              Centrado
 Left                Esquerda
 Right               Direita

As cores podem ser:
 Black               Preto
 Blue                Azul
 Green               Verde
 Cyan                Cyan
 Red                 Vermelho
 Magenta             Magenta
 Brown               Castanho
 LightGray           Cinzento claro
 DarkGray            Cinzento escuro
 LightBlue           Azul claro
 LightGreen          Verde claro
 LightCyan           Cyan claro
 LightRed            Vermelho claro
 LightMagenta        Magenta claro
 Yellow              Amarelo
 White               Branco

Os tipos de gr ficos podem ser:
 Bars                Barras
 Lines               Linhas

 Os nomes dos comandos, sub-comandos, cores e alinhamentos podem variar
consoante a tradu‡Æo usada.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º4ºEstructura do c¢digoº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Este programa est  organizado por unidades. O conceito de unidade favorece
uma maior organiza‡Æo, facilidade de leitura e reutiliza‡Æo do c¢digo e foi
por isso que foi adoptado; As unidades que compäem este programa sÆo as
seguintes:
 * SS.PAS
  O programa principal.
 * SSCONV.PAS
  Contem todas as fun‡äes que auxiliam na conversÆo entre tipos de dados ou
vari veis.
 * SSDRAW.PAS
  Contem todas as fun‡äes que sÆo respons veis pelo output (desenhar tabelas,
mostrar valores, etc.) do programa.
 * SSFILE.PAS
  Contem todas as fun‡äes que se encarregam de guardar e abrir documentos.
 * SSINIT.PAS
  Contem todas as fun‡äes que inicializam os diversos dados do programa.
 * SSINT.PAS
  Contem todas as fun‡äes que sÆo respons veis pela interpreta‡Æo dos
calculos aritm‚ticos.
 * SSLOGIC.PAS
  Contem todas as fun‡äes que sÆo respons veis pelo input (leitura de teclas
e comandos, etc.) do programa.
 * SSGRAPH.PAS
  Contem fun‡äes de cria‡Æo de gr ficos.
 * SSTRANS.PAS
  Contem todas as fun‡äes que sÆo usadas na tradu‡Æo de frases e comandos do
programa.
 * SSTYPE.PAS
  Contem todas as declara‡äes de tipos de dados universais a todas as
unidades do programa.
 * GeneralD.PAS
  Esta ‚ uma unidade mais abrangente que contem fun‡äes que auxiliam o output
de programas de linha de comandos.

ÉÍËÍÍÍÍÍÍÍÍ»
º5ºTradu‡Æoº
ÈÍÊÍÍÍÍÍÍÍÍ¼
 Como j  foi referido na introdu‡Æo o SS possu¡ suporte para diferentes
linguagens. Os ficheiros de tradu‡Æo sÆo meros ficheiros de texto e devem ter
a extensÆo .TRL, para que possam ser reconhecidos pelo programa. Para
seleccionar outra l¡ngua pode usar o comando 'translate' (ou equivalente, se
nÆo estiver a usar a l¡ngua original).
 Os ficheiros .TRL contˆm linhas de texto com as v rias frases em inglˆs
usadas no programa (e sujeitas a tradu‡Æo) alternadas com linhas de texto com
essas mesmas frases traduzidas para uma nova l¡ngua, sendo que a primeira
frase de todas dever  conter o nome da l¡ngua a que o ficheiro de tradu‡Æo se
dispäe a traduzir.
 Todas as frases, usadas no programa e sujeitas a tradu‡Æo, que nÆo forem
indicadas no ficheiro de tradu‡Æo permanecerÆo na l¡ngua original.
 Exemplo de um ficheiro de tradu‡Æo:
  Portuguˆs
  File not found.
  O ficheiro nÆo existe.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º6ºSobre as fun‡äesº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 O SS suporta c lculos aritm‚ticos e l¢gicos b sicos. SÆo suportados os
operadores aritm‚ticos: +, -, *, /; os operadores relaccionais: >, <, =, !; e
os operadores l¢gicos: & (E, AND), | (Ou, OR). Assim como expressäes
delimitadas por ( e ).
 Outros caract‚res especiais sÆo tamb‚m suportados.  o caso do : que soma
todas as celulas que estÆo dentro da matrix especificada (por exemplo,
'=a1:b2' seria igual a '=a1+a2+b1+b2') e do ~ que arredonda um valor at‚ …
casa especificada depois do caract‚r (por exemplo: '=1/3~2' daria o resultado
'0.33'). Para usar uma fun‡Æo basta apenas introduzir o s¡mbolo = antes da
expressÆo.

 ÉÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍ»
 ºOperadoresºPrecedˆnciaº
 ÌÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÍ¹
 º    :     º Primeiro  º
 º   * /    º  Segundo  º
 º   + -    º Terceiro  º
 º < > = !  º  Quarto   º
 º   & |    º  Quinto   º
 º    ~     º   Sexto   º
 ÈÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍ¼

 Como se percebe, as funda‡äes para uma pequena linguagem interpretativa
estÆo lan‡adas e de facto nÆo seria muito dif¡cil alargar as potencialidades
de interpreta‡Æo e adicionar ciclos de decisÆo e de controlo. O SSINT.PAS ‚
apenas um subset de uma linguagem maior que eu havia construindo, se bem que
em moldes um pouco diferentes. Inicialmente planeei construir a linguagem
usando conjuntos de pequenas fun‡äes que interpretavam cada uma delas uma
parte da linguagem e que usavam sofregamente a recursividade chamando-se a si
mesmas in£meras vezes para completarem a opera‡Æo que lhes era pedida. Por
exemplo para resolver a expressÆo 2+2*4+2, o programa usava uma fun‡Æo para
resolver o operador '+' resolvendo essa fun‡Æo apenas 2 operandos de cada vez
chamando-se logo de seguida de novo para resolver mais 2, at‚ que todos os
operadores '+' estivessem removidos da expressÆo - altura em que o resultado
era passado a outra fun‡Æo para resolver outros operadores de menor
precedˆncia ou outras opera‡äes.
 Esta ‚ uma abordagem que simplifica a programa‡Æo de novas instru‡äes mas
que, infelizmente, obriga o Pascal a usar mais mem¢ria. Sendo a mem¢ria um
recurso limitado no Turbo Pascal vi-me privado da utiliza‡Æo massiva da
recursividade, nÆo me restando mais que a possibilidade de resolver expressäes
de forma iteractiva. Ora, isto nÆo ‚ propriamente mais complexo, ‚ apenas um
paradigma diferente - por ventura, mais eficiente - de programar uma
linguagem, o problema ocorre quando se quer traduzir um leque de instru‡äes de
controlo e decisÆo de forma iteractiva: Isso obrigar-me-ia a fazer uma fun‡Æo
enorme com todas as palavras reservadas e seu comportamento, por forma a
limitar o uso da recursividade. Sendo eu um adepto incondicional da
modulariza‡Æo e simplifica‡Æo das instru‡äes, nÆo posso senÆo considerar essa
hip¢tese com tremenda frustra‡Æo, reservando uma poss¡vel amplia‡Æo do leque
interpretativo do SS para um futuro longiquo.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º7ºSobre a mem¢riaº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Como j  havia referido, o Turbo Pascal, pela sua natureza de programa de DOS,
dispäe de mem¢ria limitada. Tais limita‡äes obrigam a que se fa‡am certas
economias no uso de dados e mem¢ria dentro do programa. Isso reflecte-se
sobretudo no tamanho da folha de dados: 15x25 c‚lulas. Inicialmente pensei em
nÆo limitar o tamanho das folhas de dados, deixando o utilizador escolher
quantas colunas e linhas queria para trabalhar. Percebi, pouco depois, que
nÆo valeria a pena estar a complicar a programa‡Æo e optei por usar um mais
realista tamanho fixo de tabela. Outras economias na mem¢ria foram sendo
feitas, como o uso de apenas 80 caract‚res nos valores de cada c‚lula.
 Ainda assim problemas de stack podem ocorrer, eventualmente. O ficheiro
exemplo, que exemplifica bem as potencialidades do SS, chamado 'factura.ssf'
costumava nÆo abrir devido ao tamanho da stack. Isso foi corrigido depois de
aumentar o tamanho da mesma com a directiva do compilador M$, e nÆo ocorreram
mais problemas at‚ ao momento.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º8ºSobre os gr ficosº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Nesta distribui‡Æo ‚ tamb‚m inclu¡da a unidade experimental de gr ficos
SSGraph.PAS, que permite ao utilizador criar gr ficos unidimensionais (isto
‚, que s¢ representam uma £nica serie de valores) de linhas ou barras usando
o modo gr fico.
 Esta unidade ainda est  em desenvolvimento e ‚ de momento muito limitada. No
entanto pode utiliza-la recorrendo ao comando 'graph' que recebe quatro nomes
de c‚lulas, formando as duas primeiras uma matrix com a legenda (eixo do X) e
as segundas uma matrix com os valores (eixo do Y).
 Esta distribui‡Æo inclu¡ dois ficheiros .SSF usados no teste desta unidade,
sÆo eles o func.ssf e o prod.ssf.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º9ºSobre os coment riosº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Observar  o leitor mais atento que o c¢digo possui escassos coment rios. A
razÆo ‚ de f cil compreensÆo: estamos a falar de c¢digo Pascal; A programa‡Æo
em Pascal, ao contr rio de outras linguagens de programa‡Æo (como C ou Perl),
‚ feita com recurso a in£meras constru‡äes sintacticas elaboradas (designadas
vulgarmente por "Syntactic Sugar"), tipicas das linguagens usadas na
aprendizagem da programa‡Æo. Estas constru‡äes sÆo usadas precisamente para
tornar o c¢digo mais facil de ler e compreender. Por exemplo, enquanto que
em Pascal o programador usa "Begin" para come‡ar um qualquer bloco de c¢digo,
em C o programador usaria simplesmente o caract‚r "{".
 Ora, estas constru‡äes sintacticas aliadas a uma correcta indenta‡Æo do
c¢digo, nomes de vari veis longos e explic¡tos e uma repetida divisÆo de
fun‡äes em sub-fun‡äes cada vez mais pequenas, elimina, na humilde opiniÆo do
autor, qualquer necessidade de coment rios explicativos alongados que s¢ iriam
aumentar a redundƒncia e acrescentar linhas de c¢digo desnecess rias.

ÉÍËÍÍÍÍÍÍÍÍÍÍÍÍ»
ºAºDistribui‡Æoº
ÈÍÊÍÍÍÍÍÍÍÍÍÍÍÍ¼
 Esta distribui‡Æo inclu¡ os seguintes ficheiros:

  GeneralD.PAS
  SS.PAS
  SSConv.PAS
  SSDraw.PAS
  SSFile.PAS
  SSGraph.PAS
  SSInit.PAS
  SSInt.PAS
  SSLogic.PAS
  SSTrans.PAS
  SSType.PAS

  ReadMe.TXT    Este ficheiro.
  Copying.TXT   Licen‡a de distribui‡Æo.

  Help.HLP      Ficheiro .SSF de ajuda interno.
  PTHelp.HLP    Ficheiro .SSF de ajuda interno em portuguˆs.

  PT.TRL        Ficheiro de tradu‡Æo para portuguˆs.
  ENGLISH.TRL   Ficheiro de tradu‡Æo para inglˆs.

  Curso.SSF     Ficheiro exemplo, com uma tabela de notas e m‚dias.
  Factura.SSF   Ficheiro exemplo, com uma factura de uma empresa ficticia.
  Func.SSF      Ficheiro exemplo, com v rios tipos de fun‡äes matem ticas.
