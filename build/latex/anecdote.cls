% Aruno Anecdote Class
%
% Maintained by:
% Gambhiro Bhikkhu <gambhiro@ratanagiri.org.uk>
%
% LPPL LaTeX Pubic Project Licence
%

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aruno-anecdote}[2013/04/13 v0.3 A document class for books with a lighter content.]

% ========================
% Preliminary Declarations
% ========================

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /ANEC/.cd,
  pagePreset/.default=largepage,% "largepage": 6x9in, "smallpage": 5.25x8in
  pagePreset/.store in=\ANEC@pagePreset,
  babelLanguage/.default=british,
  babelLanguage/.store in=\ANEC@babelLanguage,
  % TODO: implement to apply these policies
  %leftmarkPolicy/.default=chapter,
  %leftmarkPolicy/.store in=\ANEC@leftmark,
  %rightmarkPolicy/.default=sectionOrAuthor,
  %rightmarkPolicy/.store in=\ANEC@rightmark,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/ANEC}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

% Load packages here, unless there it makes more sense to load it
% later.

\LoadClass[11pt,twoside]{memoir}

\RequirePackage[\ANEC@babelLanguage]{babel}

\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage{textcomp}
\RequirePackage[cmyk]{xcolor}

\RequirePackage{graphicx}
\graphicspath{{../../images/}}
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}

\RequirePackage{tikz}
% load tikz libraries here
% ...

% === Define colors ===

\definecolor{textbody}{gray}{0.15}
\definecolor{footnoterule}{gray}{0.5}
\definecolor{chapternum}{gray}{0.8}
\definecolor{chaptertitle}{gray}{0.3}
\definecolor{chapterauthor}{gray}{0.3}
\definecolor{chapternote}{gray}{0.3}
\definecolor{section}{gray}{0.3}
\definecolor{tocleftside}{gray}{0.5}
\definecolor{tocleftsidepart}{gray}{0.2}
\definecolor{partname}{gray}{0.5}
\definecolor{parttitle}{gray}{0.5}

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures={TeX}}

% If -- dashes don't work for your font, try
% Renderer = Basic
% http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

\setmainfont[
  SmallCapsFont = Crimson Roman,
  SmallCapsFeatures= { Ligatures = TeX, Letters = SmallCaps },
  BoldFont = Gentium Book Basic Bold,
]{Gentium}

\newfontfamily\crimsonRomanFont[
  BoldFont = Crimson Semibold,
  ItalicFont = Crimson Italic,
]{Crimson Roman}
\newfontfamily\crimsonRomanFontOldNum[
  Numbers = OldStyle,
]{Crimson Roman}
\newfontfamily\gentiumFont{Gentium}

% header and footer

\newfontfamily\footFont[Renderer = Basic]{Shaker Pali}

\newcommand{\footSize}
  {\@setfontsize\footSize{9}{9}}

% chapter

\newfontfamily\partTitleFont[
  ItalicFont = Shaker 2 Light Italic,
  BoldFont = Shaker 2 Bold,
  Renderer = Basic,
]{Shaker 2 Light}

\newfontfamily\chapterNameFont{Crimson Roman}
\newfontfamily\chapterTitleFont{Crimson Roman}
\newfontfamily\chapterNumberFont{Crimson Roman}
\newfontfamily\chapterAuthorFont{Crimson Roman}
\newfontfamily\chapterNoteFont[
  BoldFont = Crimson Semibold,
  ItalicFont = Crimson Italic,
]{Crimson Roman}

\newcommand{\chapterNameSize}
  {\@setfontsize\chapterNameSize{22}{24}}
\newcommand{\chapterNumberSize}
  {\@setfontsize\chapterNumberSize{22}{24}}
\newcommand{\chapterTitleSize}
  {\@setfontsize\chapterTitleSize{13}{16.5}}
\newcommand{\chapterAuthorSize}
  {\@setfontsize\chapterAuthorSize{12}{14}}
\newcommand{\chapterNoteSize}
  {\@setfontsize\chapterNoteSize{10}{13}}

% section

\newfontfamily\sectionFont[
  BoldFont = Crimson Semibold,
  ItalicFont = Crimson Italic,
]{Crimson Roman}

\newcommand{\sectionSize}
  {\@setfontsize\sectionSize{13}{15}}

% other sizes

\newcommand{\smaller}
  {\@setfontsize\smaller{9}{11}}

% === Page geometry and layout ===

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\ifthenelse{\equal{\ANEC@pagePreset}{largepage}}{

  % Large page
  %
  % 6in x 9in page
  % P = 1.5 (fifth)
  % T = 1.732 (sqrt(3)), Hexagon

  % For 11pt / 16pt font size, Gentium font, 5pt parskip, no parindent.

  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{11}{16}
    \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  \setlength{\parskip}{5pt}
  \setlength{\parindent}{0pt}

  % === setup page layout ===

  \setstocksize{9in}{6in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
  % It won't be exactly 33 lines because of the parskip numbers,
  % but close enough for our purpose.
  \settypeblocksize{32\baselineskip + \topskip}{*}{0.577}% 1/1.732 (sqrt(3)), Hexagon
  \setlrmargins{*}{*}{1.125}% 1/0.889 major 2nd, 25.6mm | 22.77mm
  \setulmargins{*}{*}{1.701}% Tall Pentagon, 17.9mm | 30.52mm
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{
\ifthenelse{\equal{\ANEC@pagePreset}{smallpage}}{

  % Small page
  %
  % 5.25in x 8in page
  % P = 1.523 (~Pentagon (1.539), b/w fifth (1.5) and minor 6th (1.6))
  % T = 1.618 (Golden Section, ~minor 6th (1.6))

  % For 11pt / 16pt font size, 27 lines, Gentium font, no parskip, 17pt parindent.
  % Small book binding swallows more space in the center, hence the 0.889 L-R margin ratio, instead of the 1.125 of the larger page size.


  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{11}{16}
    \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  % === setup page layout ===

  \setlength{\parskip}{0pt}
  \setlength{\parindent}{17pt}

  \setstocksize{8in}{5.25in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
  \settypeblocksize{27\baselineskip + \topskip}{*}{0.618}% 1/1.618 Golden section
  %\setlrmargins{*}{*}{0.889}% major 2nd 15:16, gives: 19.24mm | 17.1mm
  % FIXED: inner margin too close to the spine. Increased it a bit.
  \setlrmargins{*}{*}{0.63}% gives: 22.30mm | 14.04mm
  \setulmargins{*}{*}{1.701}% Tall Pentagon
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{

  % other page sizes?

}}

% === hyperref ===

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  unicode=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody
}
\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% === penalties and hyphenation ===

% memoir's more allowing penalties
\midsloppy

\renewcommand\britishhyphenmins{{3}{3}}

% The lastparline or the parfillskip solution is overkill in many
% places. It is optimal for larger paragraphs, but creates too much
% strech in every other case, particulary not in the main text, such as
% the TOC and so on.
%
% It can be useful with a limited scope, but for general application it
% becomes more of a problem to check where it has gone too far in
% adjusting line breaks.

% lastparline:
%   ``Ensures that the last line of a paragraph is at least as long as the
%   double value of \parindent. When LuaTEX is used, the solution provided
%   by Patrick Gundlach is used. With other rendering engines, it is the
%   native solution provided by Enrico Gregorio that serves as an
%   implementation.''
% http://tex.stackexchange.com/questions/28357/ensure-minimal-length-of-last-line/

% Load with draft option to visualize inserted nobreaks.
% \RequirePackage[lastparline]{impnattypo}

% Alternatively, egreg's native solution:
% http://tex.stackexchange.com/a/28358/831
%\setlength{\parfillskip}{0pt plus\dimexpr\textwidth-2\parindent}

% Last line at least 20% of textwidth
%\parfillskip 0pt plus 0.8\textwidth

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
\brokenpenalty=990

\RequirePackage[defaultlines=2,all]{nowidow}

% === common hyphenation exceptions and corrections ===

\hyphenation{season wisdom develop-ment respon-sible pheno-mena
philo-sophical munindo amaravati thai-land}

%\hyphenation{accur-ately argu-men-ta-tive attach Ayu-dhaya becomes
%ben-e-fi-cial capa-bil-ity car-ry car-ry-ing cere-monies cere-mony
%ces-sa-tion chal-lenge chal-leng-ing clas-si-fi-ca-tion
%clas-si-fi-ca-tions clas-si-fied com-mu-nity con-di-tion
%con-di-tioned con-struc-tions con-tem-plate con-tem-plat-ing
%con-tem-pla-tion cul-ti-vate cul-ti-vates cul-ti-vat-ing
%cul-ti-vation def-i-ni-tion de-ter-mine de-ter-mined dhamma dhammas
%dis-cern-ment dis-con-tent dis-cur-sive dying em-pha-size
%enlight-ened equa-nim-ity es-pe-cial-ly estab-lish exist-ence
%ex-pe-ri-ence hap-pen-ing having ig-no-rance immedi-ately
%im-per-ma-nent in-nu-mer-a-ble in-se-cu-ri-ty in-spir-ing
%in-struct-ed in-ves-ti-gate in-ves-ti-ga-tion iso-late iso-lat-ed
%Keuan lay-peo-ple ma-te-ri-al mat-u-ra-tion medi-tate medi-ta-tion
%medi-ta-tive mental mon-as-teries mon-as-tery Nana-chat or-dain
%or-dain-ed or-di-na-tion orig-inate oth-er-wise pene-trat-ing
%per-son-al per-son-al-ity phe-nom-e-na phe-nom-e-non po-si-tion
%pow-er pow-ers pre-vi-ous pro-lif-er-ate pro-lif-er-ating
%pro-lif-er-a-tions puthu-jjana quest-ion rec-i-ta-tion
%sat-is-fac-tory sen-sa-tion sen-sa-tions sim-i-lar suf-fer-ing
%sup-po-si-tion syn-on-y-mous tem-per-a-ment tem-per-a-ments tong-rat
%tran-scend tran-scend-ent tran-scends un-con-di-tioned under-stand
%under-stood un-hap-pi-ness un-sat-is-fac-tori-ness un-sat-is-fac-tory
%ven-er-able wea-ri-ness what-ev-er when-ever wher-ever whole-hearted
%whole-heart-edly wrong-do-ing}

% === soul settings ===

\sodef\soTocChapter{}{.1em}{.5em plus.1em}{.1em plus.1em minus.1em}
\sodef\soSection{}{.07em}{.4em plus.1em}{.1em plus.1em minus.1em}
\sodef\soChapter{}{.06em}{.4em plus.1em}{.1em plus.1em minus.1em}

% === Custom commands and environments ===

\newcommand\dividerRule{%
{\centering\bigskip
{\color[gray]{0.6}\rule{0.6\linewidth}{0.2pt}}
\par\bigskip}%
}

\newcommand\emptysheet{%
  \cleardoublepage
  \thispagestyle{empty}\mbox{}\newpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand\emptydoublepage\emptysheet

\newcommand\emptypage{%
  \clearpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\printedByInfo}[1]{\def\@thePrintedByInfo{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\thePrintedByInfo{\@thePrintedByInfo}
\newcommand\theISBN{\@theISBN}

\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

\newenvironment{packeditemize}%
{\begin{itemize}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=2pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{itemize}}

\newlength\qw
%\setlength\qw{\widthof{\normalsize\normalfont\itshape Q:\space}}
\setlength\qw{17pt}% same as parindent for smallpage

\newcommand{\question}[1]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \ifthenelse{\equal{#1}{}}{\textit{Q:}\space}{\textit{#1:}\space}%
}

\newcommand{\questionBi}[2]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #1}
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #2}
}

\newcommand{\answer}[1]{%
  \smallskip%
  \par\noindent%
  \ifthenelse{\equal{#1}{}}{\textit{A:}\space}{\textit{#1:}\space}%
}

% === Renewing package macros ===

\let\mainmatterOrig=\mainmatter
\renewcommand{\mainmatter}{%
  \mainmatterOrig%
  \addtocontents{toc}{\addvspace{10pt}}%
}

\let\backmatterOrig=\backmatter
\renewcommand{\backmatter}{%
  \backmatterOrig%
  \addtocontents{toc}{\addvspace{15pt}}%
}

\renewenvironment{quote}%
{\small
\list{}{\rightmargin\leftmargin}%
\item[]}%
{\endlist}

\newcommand\quoteref[1]{%
\par
{\footnotesize #1}
\par
}

\renewcommand\footnoterule{%
  \vspace*{\baselineskip}%
  \kern-3\p@
  {\color{footnoterule}\hrule height 0.25pt width \columnwidth}
  \kern2.6\p@}

% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newcommand{\sepline}{%
  \hspace{6pt}%
  \raisebox{-0.3\baselineskip}{\rule{0.2pt}{1.2\baselineskip}}%
  \hspace{6pt}%
}

\makepagestyle{bottomcorner}
\makeevenhead{bottomcorner}{}{}{}
\makeevenfoot{bottomcorner}{%
  \footFont\footSize%
  \thepage \sepline \leftmark%
}{}{}
\makeoddhead{bottomcorner}{}{}{}
\makeoddfoot{bottomcorner}{}{}{%
  \footFont\footSize%
  \rightmark \sepline \thepage%
}

\makepagestyle{bottomcenter}
\makeevenhead{bottomcenter}{}{}{}
\makeevenfoot{bottomcenter}{}{%
  \footFont\footSize%
  \thepage%
}{}
\makeoddhead{bottomcenter}{}{}{}
\makeoddfoot{bottomcenter}{}{%
  \footFont\footSize%
  \thepage%
}{}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{bottomcorner}
\aliaspagestyle{chapter}{bottomcenter}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

% === TOC settings ===

\maxtocdepth{section}

% Fixes Undefined control sequence error for \@chapapp@head
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

% Fixes Missing number error when chapter number is not numeric, as in
% Appendix A
\let\ttll@appendix\ttll@chapter

\newcommand*\l@chapternote{\@nodottedtocline{0}{6pc}{1pc}{1pc}}

\def\@nodottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth \else
    %\vskip \z@ \@plus.2\p@
    \vspace*{-3pt}
    {\footnotesize\itshape\crimsonRomanFont
     \leftskip #2\relax
     \rightskip \@tocrmarg
     \advance\rightskip #3\relax
     \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #4\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#5}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{\,}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalsize\normalfont}%
     \par}%
  \fi}

\def\tocChapterNote#1{%
    \addcontentsline{toc}{chapternote}{%
    \noexpand\numberline{}#1}%
}

% the right TOC margin
\contentsmargin{0pt}

\newlength\tocLeftWidth
\setlength\tocLeftWidth{6pc}

% FIXME: the first Part heading in the TOC will also add that 20pt
% vspace. How to add it only before a Part that follows a Chapter?

\titlecontents{part}[\tocLeftWidth]
{\addvspace{20pt}%
\normalsize\crimsonRomanFont}%
{%
  \contentsmargin{0pt}%
  \makebox[0pt][r]{%
  {\color{tocleftsidepart}\partname~\thecontentslabel}%
  \hspace*{0.5em}$\cdot$\hspace*{0.5em}}%
}
{\contentsmargin{0pt}}
{\hfill\normalsize\crimsonRomanFont\thecontentspage}
[\addvspace{5pt}]

\titlecontents{chapter}[\tocLeftWidth]
{\normalsize\crimsonRomanFont}%
{%
  \contentsmargin{0pt}%
  \makebox[0pt][r]{%
    {\color{tocleftside}%
    \chaptername~{\crimsonRomanFontOldNum\thecontentslabel}}%
    \hspace*{0.5em}$\cdot$\hspace*{0.5em}%
  }%
}
{\contentsmargin{0pt}%
\itshape}
{\hfill\normalsize\crimsonRomanFont\thecontentspage}

\titlecontents{appendix}[\tocLeftWidth]
{\normalsize\crimsonRomanFont}%
{%
  \contentsmargin{0pt}%
  \makebox[0pt][r]{%
    {\color{tocleftside}%
    \appendixname~{\crimsonRomanFontOldNum\thecontentslabel}}%
    \hspace*{0.5em}$\cdot$\hspace*{0.5em}%
  }%
}
{\contentsmargin{0pt}%
\itshape}
{\hfill\normalsize\crimsonRomanFont\thecontentspage}

\titlecontents{section}[\tocLeftWidth]
{\addvspace{-2pt}%
\small\crimsonRomanFont}
{\contentslabel[\thecontentslabel]{\tocLeftWidth}}
{}
{\hfill\normalsize\crimsonRomanFont\thecontentspage}

\titlecontents*{subsection}[\tocLeftWidth]
{\addvspace{-1pt}%
\small\crimsonRomanFont}
{}
{}
{\ --- \thecontentspage}
[ \textbullet\ ][]

\renewcommand{\tableofcontents}{%
\chapterstyle{hightitle}
\chapter*{\contentsname}
\markboth{\contentsname}{\contentsname}
\chapterstyle{lowtitle}
\@starttoc{toc}
}

% === Book styles ===

% === Part styles ===

\newif\ifthisparthastitle
\thisparthastitletrue

\newif\ifthisparthasnote
\thisparthasnotefalse

\newcommand*{\thePartNote}{}
\newcommand*{\partNote}[1]{%
  \thisparthasnotetrue%
  \renewcommand*\thePartNote{#1}%
}

\renewcommand{\partnamefont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\partnumfont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\parttitlefont}{\large\partTitleFont\color{parttitle}\MakeUppercase}
\renewcommand*{\midpartskip}{\par\vskip 10pt}%

% FIXME: Currently, if there isn't a part title, we have to do
% \part{\space} to still create the part line in the TOC and the
% bookmark index.
%
% It would be better if the index had ``Part One'', and the TOC would
% handle it better too.

\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \phantomsection
  \ifnum \c@secnumdepth >-2\relax
  \refstepcounter{part}%
  \addcontentsline{toc}{part}%
  {\protect\partnumberline{\thepart}#1}%
  \mempartinfo{\thepart}{#1}{#2}%
  \else
  \addcontentsline{toc}{part}{#1}%
  \mempartinfo{}{#1}{#2}%
  \fi
  \partmark{#1}%
  {%
    \raggedright
    \hspace*{\chapterTitleLeftSkip}%
    \begin{minipage}{\linewidth - \chapterTitleLeftSkip}
      \raggedright
      \interlinepenalty \@M
      \parskip\z@
      \ifthisparthasnote
        \thePartNote
        \par
        \global\thisparthasnotefalse
        \midpartskip
      \fi
      \normalfont
      \ifnum \c@secnumdepth >-2\relax
        \resizebox{2.8cm}{!}{\printpartname \partnamenum \printpartnum}
        \par\vskip 20pt
      \fi
      \ifthisparthastitle
        \printparttitle{#2}
      \else
        \global\thisparthastitletrue
      \fi
      \par%
    \end{minipage}%
    \par%
  }%
\@endpart}

% === Chapter styles ===

\setsecnumdepth{chapter}

% define chapter styles with "fantasy" names

\newif\ifchapterauthor
\chapterauthorfalse

\newcommand*{\theChapterAuthor}{}
\newcommand*{\chapterAuthor}[1]{%
  \chapterauthortrue%
  \renewcommand*{\theChapterAuthor}{#1}%
}

\newcommand\chapterAuthorFmt[1]{%
  \chapterAuthorFont\chapterAuthorSize\color{chapterauthor}%
  #1%
}

\newif\ifchapternote
\chapternotefalse

\newcommand\chapterNoteFmt[1]{%
  \chapterNoteFont\chapterNoteSize\color{chapternote}%
  \itshape #1%
}

\newcommand*{\theChapterNote}{}
\newcommand*{\chapterNote}[1]{%
  \chapternotetrue%
  \renewcommand*\theChapterNote{#1}%
}

\newif\ifchapterfootnote
\chapterfootnotefalse

\newcommand*{\theChapterFootnoteMark}{}
\newcommand*{\theChapterFootnoteText}{}
\newcommand*{\chapterFootnote}[2][\footnotemark]{%
  \chapterfootnotetrue%
  \renewcommand*\theChapterFootnoteMark{#1}%
  \renewcommand*\theChapterFootnoteText{\footnotetext{#2}}%
}

\newlength\chapterTitleLeftSkip
\setlength{\chapterTitleLeftSkip}{17pt}

\makechapterstyle{lowtitle}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{30mm}
  \setlength{\chapterTitleLeftSkip}{17pt}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\chapnumfont{\chapterNumberFont\chapterNumberSize}
  \renewcommand\printchapternum{%
    \chapnumfont\color{chapternum}%
    \hspace*{\chapterTitleLeftSkip}\thechapter%
  }
  \setlength{\midchapskip}{2\onelineskip}
  \renewcommand\afterchapternum{\par\nobreak\vskip \midchapskip}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand*\printchaptertitle[1]{%
    \raggedright\hspace*{\chapterTitleLeftSkip}%
    \parbox{\linewidth - \chapterTitleLeftSkip}{%
      \raggedright\chaptitlefont\color{chaptertitle}%
      \MakeUppercase{\soChapter{##1}}%
      \ifchapterfootnote%
        \hspace*{2pt}\theChapterFootnoteMark%
      \fi%
      \ifchapterauthor%
        \vskip 0.5\onelineskip%
        \chapterAuthorFmt{\theChapterAuthor}%
        \global\chapterauthorfalse%
      \fi%
      \ifchapternote%
        \vskip 0.5\onelineskip%
        \chapterNoteFmt{\theChapterNote}%
        \global\chapternotefalse%
      \fi%
    }%
    \ifchapterfootnote%
      \theChapterFootnoteText%
      \global\chapterfootnotefalse%
    \fi%
  }
  \setlength{\afterchapskip}{2.5\onelineskip}
  \renewcommand\afterchaptertitle{\par\nobreak\vskip \afterchapskip}%
}

\makechapterstyle{hightitle}{
  \chapterstyle{lowtitle}
  \setlength{\beforechapskip}{0pt}
  \setlength{\chapterTitleLeftSkip}{6pc}
}

% alias the "fantasy" names into semantic chapter names

\chapterstyle{lowtitle}

% === Section styles ===

\raggedbottomsection

\setbeforesecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersecskip{2.3ex \@plus .2ex}

\newcommand\sectionFmt[1]{%
  \sectionFont\sectionSize\color{section}%
  \memRTLraggedright%
  \itshape #1%
}
\setsecheadstyle{\sectionFmt}

\setsubsecheadstyle{%
  \sectionFont\large\itshape\memRTLraggedright%
}
\setsubsubsecheadstyle{%
  \sectionFont\normalsize\itshape\memRTLraggedright%
}

% === Packages to be loaded LAST ===

\RequirePackage[perpage,multiple,stable]{footmisc}

\RequirePackage[final,babel=true]{microtype}

%% =================
%% PDF/X-3:2002 info
%% =================

% \pdfobjcompresslevel=0%
% \pdfminorversion=3%
% \pdfinfo{
%   /Title (Dhammapada)
%   /Author (Forizs Laszlo)
%   /Subject (buddhizmus)
%   /Keywords (buddhizmus)
%   /GTS_PDFXVersion (PDF/X-3:2002)
% }%
% \pdfpageattr{
% /MediaBox [0 0 369.00000 594.00000]
% /BleedBox [0.00000 0.00000 369.00000 594.00000]
% /CropBox [0 0 369.00000 594.00000]
% /TrimBox [0.00000 0.00000 369.00000 594.00000]
% }
% \pdfcatalog{
%   /PageMode /UseNone
%   /OutputIntents [ <<
%     /Info (none)
%     /Type /OutputIntent
%     /S /GTS_PDFX
%     /OutputConditionIdentifier (Blurb.com)
%     /RegistryName (http://www.color.org/)
%   >> ]
% }%

%% ==============

