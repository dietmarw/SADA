%%****************************************
%%*                                      *
%%* TU Berlin                            *
%%* MDT                                  *
%%*                                      *
%%****************************************
%%
%% LaTeX-Vorlage fuer
%% MDT
%%**************************************************************
%% Version: filename    rev date       time     last modified by
%%     $Id$ 
%%**************************************************************
%% (The "Id" tag above is update automatically if 
%% 	svn propset svn:keywords "Id" <filename>
%% was set.)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MDT-SADA}[21/07/2006 Vorlage fuer TU Berlin MDT Studien- und Diplomarbeiten]
\LoadClass[halfparskip,DIV13,BCOR2cm]{scrbook}

%Auswertung der Paketoptionen
%Behandlung der pdf-Option. Dies wird eingeführt, um Übersetzungszeit
%zu sparen, wenn nur ein .ps erzeugt werden soll.

\ifpdfoutput{
	\RequirePackage[pdftex]{graphicx}
}{%\else
	\RequirePackage[dvips]{graphicx}
}%\fi
\graphicspath{{logos/}{bilder/}}

%nologo-Option
\newcommand{\MDTlogo}{\includegraphics[height=2cm]{MDT-logo}}
\newcommand{\TUlogo}{\includegraphics[height=2cm]{TU-logo_gruen}}
\ifpdfoutput{}{%
	\IfFileExists{logos/MDT-logo.eps}%
		{}%
		{\renewcommand{\MDTlogo}{\fbox{\parbox[b][2cm][c]{2cm}{Logo\\MDT}}}}%
	\IfFileExists{logos/TU-logo_gruen.eps}%
		{}%
		{\renewcommand{\TUlogo}{\fbox{\parbox[b][2cm][c]{2cm}{Logo\\TU Berlin}}}}%
}

\newif\if@nologo
\@nologofalse
\DeclareOption{nologo} {%
  \@nologotrue%
  \renewcommand{\MDTlogo}{}%
  \renewcommand{\TUlogo}{}%
}%
	
\newif\if@onlytoc
\@onlytocfalse
\DeclareOption{onlytoc}{\@onlytoctrue}

\newcommand{\extraBookmark}[2]{\ifpdfoutput{\pdfbookmark[1]{#1}{#2}}{}}
\newif\if@print
\@printfalse
\DeclareOption{print}{%
	\@printtrue%
	\renewcommand{\extraBookmark}[2]{}%
}%

\newcommand{\RequireIndex}{}
\newif\if@index
\@indexfalse
\DeclareOption{index} {%
  \@nologotrue%
  \renewcommand{\RequireIndex}{\RequirePackage{makeidx}\makeindex}%
}%


%Alle uebrigen Optionen werden an scrbook weitergereicht
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package scrbook!}
    \PassOptionsToPackage{\CurrentOption}{scrbook}
}%
\ProcessOptions\relax

%%%
%Die allgemein benötigten packages
\ifpdfoutput{
	\RequirePackage[T1]{fontenc}
	\RequirePackage{ae}
	\RequirePackage[latin1]{inputenc}
	\if@print
		% nothing
	\else
		\RequirePackage[pdftex,colorlinks=true,linkcolor=blue,urlcolor=blue,plainpages=false,pdfpagelabels]{hyperref}
	\fi
}{%\else
	\RequirePackage[T1]{fontenc}
	\RequirePackage[latin1]{inputenc}
	\RequirePackage[dvips]{hyperref}
}%\fi
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage[automark]{scrpage2}
\RequirePackage[ngerman]{babel}
%\RequirePackage{lastpage}
%\RequirePackage[ngerman,num]{isodate}
\RequirePackage{longtable}
\RequirePackage{caption} % fuer mehr Caption-Optionen
%Umbruch auch an Unterstrichen
%\lccode`\_=`\_
\RequireIndex

\addtolength{\voffset}{0.7cm}

%Redefinitionen---------------------------------
%Literaturverzeichnis statt nur Literatur
%\renewcommand{\refname}{Literaturverzeichnis}
 \AtBeginDocument{\renewcommand*\figurename{Bild}} 
%\renewcommand{\figurename}{Bild}

%Umgebungen------------------------------------
\newcommand{\includeBild}[3]%
{\ifthenelse%
		{\equal{#1}{}}%
		{\mbox{\parbox[b][5cm][c]{0.7\textwidth}{\begin{center}no picture\end{center}}}}%
		{\ifpdfoutput%
			{\mbox{\includegraphics[#3]{#1}}}%
			{\IfFileExists%
				{bilder/#1.eps}%
				{\mbox{\includegraphics[#3]{#1}}}%
				{\mbox{\parbox[b][5cm][c]{0.7\textwidth}{%
					\begin{center}%
						\path{#1.{pdf,png,jpg}}\bigskip\\{\footnotesize(nicht in \jobname.dvi)}%
					\end{center}%
						}%
				}%
			}%
		}%
}%
	\captionsetup{indent=0pt,width=.9\textwidth}%
	\caption{#2}%
      	\ifthenelse%
		{\equal{#1}{}}%
		{}%
		{\label{fig:#1}}%
}

\newcommand{\bild}[3]{%
\begin{figure}[htb]%
	\centering%
	\includeBild{#1}{#2}{#3}
\end{figure}%
}


\newcommand{\bildhier}[3]{%
\begin{figure}[!ht]%
	\centering%
	\includeBild{#1}{#2}{#3}
\end{figure}%
}


 \newcommand{\doppelbild}[6]{%
\begin{figure}%
\begin{minipage}[t]{.45\textwidth}%
\centering%
  \includeBild{#1}{#2}{#3}%
\end{minipage}%
~\hfill~%
\begin{minipage}[t]{.45\textwidth}%
  \includeBild{#4}{#5}{#6}%
\end{minipage}%
\end{figure}%
}



%\newcommand{\maxHight}{0.925\textheight}
%\newcommand{\maxWidth}{0.5\textheight}


%\newcommand{\var}[1]{'\texttt{#1}'}
%\newcommand{\myitem}[1]{\item \textbf{#1}}


% Zähler für Zeilennnummerierungen in Tablellen
\newcounter{internal_tbl_cnt}[table]
\newcommand{\tblrow}{\refstepcounter{internal_tbl_cnt}\arabic{internal_tbl_cnt}.}

% #1 Autor
% #2 Matrikelnummer
% #3 Titel
% #4 Untertitel
% #5 Abgabedatum
% #6 Betreuer
\newcommand{\titelseite}[6]{%
	\extraBookmark{Titelseite}{titleanc}%
	\thispagestyle{empty}%
	\begin{titlepage}%
        \MDTlogo\hfill\TUlogo\\%
	\vfill%
	\begin{center}%
	  %Titel und Untertitel%
	  {\textbf{{\Huge #3}\ifthenelse{\equal{#4}{}}{}{\\{\vspace*{3ex}\LARGE #4}}}}%
          \\[6ex]%
            {\Large #1\\ \# #2}\\%
	    \vfill%
	    \vfill%
	        {\LARGE #5}\\%
		\vfill%
		\begin{minipage}[t]{0.25\textwidth}%
			\flushright\Large%
			Betreuer:~%
		\end{minipage}%
		\vspace{0pt}~%
		\begin{minipage}[t]{0.45\textwidth}%
			\flushleft\Large%
			#6%
		\end{minipage}%
                \vfill%
                    {\Large%
                      Technische Universität Berlin\\%
                      Fakultät IV -- Elektrotechnik und Informatik\\%
                      Institut für Energie- und Automatisierungstechnik\\%
	              Fachgebiet Elektronische Mess- und Diagnosetechnik\\%
                    }%
        \end{center}%
%
        \end{titlepage}%
	%\newpage
	\makeHead{#1, \#\,#2}%
}


\newcommand{\inhaltsverzeichnis}
{%
	\tableofcontents%
	\extraBookmark{Inhaltsverzeichnis}{tocanc}%
	\if@onlytoc\clearmydoublepage\else\fi%
}

\newcommand{\makeHead}[1]
{%
	\clearscrheadfoot%
	%\renewcommand{\headfont}{\normalfont\sffamily\bfseries}%
	\lehead{\leftmark}%
        \rohead{\rightmark}%
        \ifoot{#1}
	\ofoot{\pagemark}%
	%\setheadsepline{.4pt}%
	%\automark{subsection}%
	\pagestyle{scrheadings}%
	\deftripstyle{myChapterStyle}{}{}{}{#1}{}{\pagemark}
	\renewcommand*{\chapterpagestyle}{myChapterStyle}
}

\newcommand{\clearmydoublepage}{\newpage{\pagestyle{myChapterStyle}\cleardoublepage}}

\newlength{\FormelTabellenWeite}
\newenvironment{formelzeichen}[1][0.1]
{%
	\@openrightfalse%
	\setlength{\FormelTabellenWeite}{\textwidth}%
	\addtolength{\FormelTabellenWeite}{-#1\textwidth}%
	\chapter*{Formelzeichen}%
	\extraBookmark{Formelzeichen}{formulaanc}%
	\begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
	\end{longtable}%
	\@openrighttrue%
	\clearmydoublepage
}%

\newenvironment{abkuerzungen}[1][0.2]
{%
	\@openrightfalse%
	\setlength{\FormelTabellenWeite}{\textwidth}%
	\addtolength{\FormelTabellenWeite}{-#1\textwidth}%
	\chapter*{Glossar}%
	\extraBookmark{Glossar}{abranc}%
	\begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
	\end{longtable}%
	\@openrighttrue%
	\clearmydoublepage
}%

\newenvironment{literaturverzeichnis}
{\begin{thebibliography}{99}%
	\addcontentsline{toc}{chapter}{Literatur}%
%	\extraBookmark{Literatur}{litanc}
}
{\end{thebibliography}}

\newcommand{\indexverzeichnis}{%
	%\ifthenelse{\equal{\RequireIndex}{}}
		%{Fehler erzeugen, oder nix}
		%{untenstehende Befehle}
	\cleardoublepage%
	\phantomsection%
	\addcontentsline{toc}{chapter}{Index}%
	\printindex%
}
	
% Abstand der Paragraphen
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5mm }

%erste Version (abgeleitet von wise/ TU Dresden).
%
