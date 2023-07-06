% Documentclass seismica.cls
% for Seismica, a community-driven, Diamond Open Access journal publishing peer-reviewed research in seismology and earthquake science.
% Current version with inputs from:
% Théa Ragon, Hannah Mark, Wasja Bloch, Thomas Lecocq

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seismica}[2022 LaTeX2e document class]

\newif\if@onecolumn
\@onecolumnfalse
\DeclareOption{onecolumn}{\@onecolumntrue}

\newif\if@report
\@reportfalse
\DeclareOption{report}{\@reporttrue}

\newif\if@opinion
\@opinionfalse
\DeclareOption{opinion}{\@opiniontrue}

\newif\if@invited
\@invitedfalse
\DeclareOption{invited}{\@invitedtrue}

\newif\if@breakmath
\@breakmathfalse
\DeclareOption{breakmath}{\@breakmathtrue}

\newif\if@proof
\@prooffalse
\DeclareOption{proof}{\@prooftrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\if@onecolumn
\LoadClass[10pt,twoside,a4paper,onecolumn]{article}
\else
\LoadClass[10pt,twoside,a4paper,twocolumn]{article}
\fi

\RequirePackage[headsep=0.7cm,top=2cm,bottom=1.5cm,left=1.5cm,right=1.5cm,footskip=0.7cm]{geometry}
\setlength{\columnsep}{0.8cm}
\RequirePackage[table]{xcolor}
\definecolor{seismicacolor1light}{RGB}{38,81,143}
\definecolor{seismicacolor1}{RGB}{18,52,103}
\definecolor{seismicacolor2}{RGB}{77,185,123}
\definecolor{seismicacolor3}{RGB}{222,60,75}
\definecolor{seismicacolor4}{RGB}{205,204,36}
\definecolor{codebackcolor}{RGB}{243,243,243}
\RequirePackage[unicode,
bookmarks=true,
linkcolor=seismicacolor1light,
citecolor=seismicacolor1light,
hidelinks,
hyperfootnotes=false]{hyperref}
\hypersetup{colorlinks,linkcolor=seismicacolor1light}
\hypersetup{colorlinks,citecolor=seismicacolor1light}
\hypersetup{colorlinks,urlcolor=gray}
\RequirePackage{url}
\def\UrlBreaks{\do\/\do-\do_}

\RequirePackage{polyglossia}
\RequirePackage{fontspec}
\setmainlanguage[]{english}
%% extra options for Arabic (not supported by polyglossia)
\newfontfamily\arabicfont[Script=Arabic]{Arial} %{Noto Naskh Arabic}
\newcommand{\textarabic}[1]{\bgroup\textdir TRT\arabicfont #1\egroup} % Arabic inside LTR
\newcommand{\n}[1]{\bgroup\textdir TLT #1\egroup} % for digits inside Arabic text
\newenvironment{Arabic}{\textdir TRT\pardir TRT\arabicfont}{\hfill} % Arabic paragraph

\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage{abstract}
\RequirePackage{fancyhdr}
\RequirePackage{bookmark}
\RequirePackage{caption} 
%\RequirePackage[natbibapa,sectionbib,doi]{apacite}   ### TO DO!! Conflict with... ???
%\bibliographystyle{apacite}
\RequirePackage[round]{natbib}
\bibliographystyle{abbrvnat_seismica_upcasetitle}
%\bibliographystyle{abbrvnat_seismica}
\RequirePackage{doi}
\RequirePackage{academicons}
\RequirePackage[noblocks]{authblk}
\setcounter{Maxaffil}{0}
\RequirePackage{changepage}
\RequirePackage[savepos]{zref}
\RequirePackage{datatool}
\RequirePackage{etoolbox}
\RequirePackage{physics}
\RequirePackage{comment}
\RequirePackage{listings}
\RequirePackage[autostyle=false, style=english]{csquotes}
\RequirePackage{newunicodechar}

% fonts and math
\RequirePackage{amsmath}
\RequirePackage{lmodern}
\if@breakmath
\RequirePackage{breqn}
%% patches \eq@setnumber to use \refstepcounter instead of \stepcounter, from https://tex.stackexchange.com/questions/241118/autoref-to-dmath-from-breqn-package-generates-wrong-link-text
\patchcmd\eq@setnumber{\stepcounter}{\refstepcounter}{}{%
	\errmessage{Patching \noexpand\eq@setnumber failed}%
}
% break equations
\renewenvironment{equation}{%
	\begin{dmath}}{%
\end{dmath}}
\fi
\newcommand{\mathbfup}[1]{\mathord{\textnormal{\textbf{#1}}}}

\RequirePackage[autostyle=false, style=english]{csquotes}
\RequirePackage[opentype,default,tabular,lining]{sourcesanspro}
\RequirePackage[opentype,default,tabular,lining]{sourceserifpro}
\RequirePackage[opentype,lining]{sourcecodepro}

\newcommand{\sff}{\sourcesanspro}
\newcommand{\rmf}{\sourceserifpro}
\newcommand{\sflight}{\sourcesansprolight}
\newcommand{\rmlight}{\sourceserifprolight}
\urlstyle{sf}

% source sans pro does not handle +2010
\newunicodechar{^^^^2010}{-}

% Redefine thanks symbol for compatibility with fonts
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or
		\mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger
		\or \ddagger\ddagger \else\@ctrerr\fi}}

% proof watermark
\if@proof
\RequirePackage{draftwatermark}
\SetWatermarkText{PROOF}
\SetWatermarkScale{1}
\SetWatermarkColor[gray]{0.85}
\fi


%-------------------------------------------------------------------------------
%              Checking ORCIDS, by Tom Lecocq
%                NOT WORKING !!!!!!
%-------------------------------------------------------------------------------
%\RequirePackage{xstring}
%\RequirePackage{xintexpr}
%
%\newcommand\GOODORCID[1]{test}
%\newcommand\BADORCID[1]{\textcolor{red}{ORCID #1 is invalid}}
%%\newcommand\BADORCIDLEN[1]{ORCID #1 does not have 16 digits}
%
%%\def\tempstring{}
%\newcommand\repStr[1]{%
%	\StrSubstitute{#1}{-}{}}
%
%\newcommand\checkORCID[1]{
%%\StrDel{#1}{-}[\tempstring]
%%\StrDel{\tempstring}{X}[\tempstring]
%%\expandafter\StrLen\expandafter{\tempstring}[\tempstring@length]
%%\def\x{\xintListWithSep{,}{\tempstring }}
%tempstring is \repStr{#1}
%% Received information: #1 \\
%% Sanitized information: \tempstring \\
%% Length: \tempstring@length\\
%% Input ORCID: \x \\
%}
%\def \checksum{\xinttheiiexpr iter(0; @ * 2 + i, i=\x) \relax}
%
%\ifnum \tempstring@length=15
%\def\bubu{\xinttheiiexpr \checksum * 2 + 10 \relax}
%\else 
%\def\bubu{\checksum}
%\fi
%\def \finalcheck{\xinttheiiexpr \bubu 'mod' 11 \relax}
%\ifnum \finalcheck=1 
%\GOODORCID{#1} 
%\else 
%\BADORCID{#1} 
%\fi
%}

%-------------------------------------------------------------------------------
%                Configuration for authors
%-------------------------------------------------------------------------------

% package authblk
\renewcommand*{\Authsep}{, }
\renewcommand*{\Authand}{, }
\renewcommand*{\Authands}{, }
\renewcommand*{\Authfont}{\bfseries\sff}    % make author names boldface    
\setlength{\affilsep}{0.2cm}   % set the space between author and affiliation
\renewcommand*{\Affilfont}{\normalfont\sflight\small}
\renewcommand\AB@affilsepx{, \protect\Affilfont}

% package academicons
\if@opinion
\newcommand{\orcid}[1]{
\href{https://orcid.org/#1}{\textcolor{seismicacolor4}{\aiOrcid}}}
\else
\newcommand{\orcid}[1]{
	\href{https://orcid.org/#1}{\textcolor[HTML]{A6CE39}{\aiOrcid}}}
\fi

% Credit
\DTLgnewdb{credits}
\newcommand*{\credit}[2]{%
	\DTLnewrow{credits}%
	\DTLnewdbentry{credits}{credrole}{#1}%
	\DTLnewdbentry{credits}{credauthor}{#2}%
}

%-------------------------------------------------------------------------------
%                information box
%-------------------------------------------------------------------------------
\RequirePackage[absolute]{textpos}
\RequirePackage{longtable,booktabs,tabularx,colortbl}

% Article info
\def\receiveddate#1{\def\@receiveddate{#1}}
\def\accepteddate#1{\def\@accepteddate{#1}}
\def\publisheddate#1{\def\@publisheddate{#1}}
\def\thevolume#1{\def\@thevolume{#1}}
\def\thenumber#1{\def\@thenumber{#1}}
\thenumber{}
\def\theyear#1{\def\@theyear{#1}}

% Volunteers names
\def\prodedname#1{\def\@prodedname{#1}}
\prodedname{}
\def\handedname#1{\def\@handedname{#1}}
\handedname{}
\def\copyedname#1{\def\@copyedname{#1}}
\copyedname{}
\def\translatorname#1{\def\@translatorname{#1}}
\translatorname{}
\def\reviewername#1{\def\@reviewername{#1}}
\reviewername{}
\def\suppmat#1{\def\@suppmat{#1}}
\suppmat{}

\newcommand{\@insert@metadata}{%
	\begin{textblock*}{3cm}[1,0](\dimexpr\textwidth-\oddsidemargin\relax,\dimexpr\pageheight-\zposy{loc:beg_abstract}sp\relax)
		\footnotesize\raggedright%
		\setlength{\parskip}{\baselineskip}%
		\setlength{\parindent}{\z@}%
		\more@metadata\par
	\end{textblock*}
}

\newcommand{\printifnotempty}[4]{%
	\sbox0{#3}%
	\ifdim\wd0=0pt
	{}% if #3 is empty
	\else
	%	\begin{flushright}
		{\raggedleft\sflight \textcolor{gray}{#1: }{#2}\sff \textcolor{gray}{#3}#4}% if #2 is not empty
		%	\end{flushright}
	\fi
}

\newcommand{\more@metadata}{%
	\printifnotempty{Production Editor}{\\}{\@prodedname}{\\}
	\printifnotempty{Handling Editor}{\\}{\@handedname}{\\}
	\printifnotempty{Copy \& Layout Editor}{\\}{\@copyedname}{\par}
	\printifnotempty{Signed reviewer(s)}{\\}{\@reviewername}{\par}
	\printifnotempty{Translated by}{\\}{\@translatorname}{\par}
	\printifnotempty{Received}{\\}{\@receiveddate}{\\}
	\printifnotempty{Accepted}{\\}{\@accepteddate}{\\}
	\printifnotempty{Published}{\\}{\@publisheddate}{\par}
}

%-------------------------------------------------------------------------------
%                Configuration for heading
%-------------------------------------------------------------------------------
% For credit
\newcommand{\printcreditifnotempty}{%
	\ifdim\DTLrowcount{credits}pt=0pt
	\else
	\vskip .5em
	\footnotesize\raggedright\sff\textcolor{seismicacolor1}{Author contributions:} \DTLforeach*{credits}{\Credrole=credrole, \Credauthor=credauthor}{\textcolor{seismicacolor1}{ \sflight\textit{ \Credrole}: \Credauthor.} }
	\fi
}

\pretitle{
	\begin{flushleft}
		\fontsize{21pt}{1em}\bfseries\sff
	}
	\posttitle{%
	\end{flushleft}%
	\vskip .2cm
}
\preauthor{%
	\lineskip 0.2cm%
	\begin{flushleft}
	}
	
	\postauthor{%
	\end{flushleft}%
	\vskip -.5em
	\printcreditifnotempty
	\par
		\zsavepos{loc:end_authors}
}
\predate{}
\postdate{
}
\date{}

\if@report
\newcommand{\banner}{banner_report}
\else
	\if@opinion
	\newcommand{\banner}{banner}
	\else
	\newcommand{\banner}{banner}
	\fi
\fi

\def\dois#1{\def\@dois{#1}}
\dois{}


\if@invited
\renewcommand\maketitlehooka{%
	\vspace{-1.5cm}
	\includegraphics[width=\textwidth]{\banner}
	
	{\vspace*{-1.75cm} \hspace{0.2cm} 
		\sff \color{white} \bfseries \textit{INVITED}}
	
	{\vspace*{0.03cm} \hspace{0.2cm} 
		\href{https://doi.org/\@dois}{\sff \color{white} \small doi:\@dois} }
	
	\vspace*{1.7cm}
}
\else
	\if@report
	\renewcommand\maketitlehooka{%
		\vspace{-1.5cm}
		\includegraphics[width=\textwidth]{\banner}
		
		{\vspace*{-1.75cm} \hspace{0.2cm} 
			\sff \color{white} \bfseries \textit{REPORT}}
		
		{\vspace*{0.03cm} \hspace{0.2cm} 
			\href{https://doi.org/\@dois}{\sff \color{white} \small doi:\@dois} }
		
		\vspace*{1.7cm}
	}
	\else
	\if@opinion
	\renewcommand\maketitlehooka{%
		\vspace{-1.5cm}
		\includegraphics[width=\textwidth]{\banner}
		
		{\vspace*{-1.75cm} \hspace{0.2cm} 
			\sff \color{white} \bfseries \textit{REVIEWED OPINION}}
		
		{\vspace*{0.03cm} \hspace{0.2cm} 
			\href{https://doi.org/\@dois}{\sff \color{white} \small doi:\@dois} }
		
		\vspace*{1.7cm}
	}
		\else
		\renewcommand\maketitlehooka{%
			\vspace{-1.5cm}
			\includegraphics[width=\textwidth]{\banner}
			
			{\vspace*{-1.3cm} \hspace{0.2cm} 
				\href{https://doi.org/\@dois}{\sff \color{white} \small doi:\@dois} }
			
			\vspace*{1.7cm}
		}
		\fi
	\fi
\fi

\renewcommand\maketitlehookd{%
	\pagestyle{fancy}
	\thispagestyle{plain}
	\@insert@metadata
}

%-------------------------------------------------------------------------------
%                Configuration for asbtract
%-------------------------------------------------------------------------------

\newcommand*{\abstracttitlestyle}[1]{{\sff \large \bfseries #1}}

\let\oldthanks\thanks
\renewcommand{\thanks}[1]{\oldthanks{\small \sflight #1}}

\newenvironment{summary}[1]
{
	\par
	\noindent \abstracttitlestyle{#1} \hspace{0.2cm}\sffamily
}{
	\vspace{0.3cm}}%

\newenvironment{abswidth}{\begin{adjustwidth}{}{0.18\paperwidth}}{\end{adjustwidth}}

%% abstract.sty specs, needed for saythanks
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\renewcommand{\abstractname}{}   
\renewcommand{\absnamepos}{empty} 
\addto\captionsenglish{\renewcommand{\abstractname}{}} % necessary to remove abstract title... don't know why

\if@onecolumn
\newcommand*{\makeseistitle}[1]{%
	\maketitle
	\begin{abswidth}
			\zsavepos{loc:beg_abstract}
		#1
	\end{abswidth}
	\thanks
	\vspace*{0.7cm}
}
\newcommand*{\addsummaries}[1]{%
	\begin{abswidth}
		#1
	\end{abswidth}

	\vspace*{0.7cm}
}
\else
\newcommand*{\makeseistitle}[1]{%
	\twocolumn[
	\maketitle
	\begin{abswidth}
	\begin{onecolabstract}
	\zsavepos{loc:beg_abstract}		
		#1
	\end{onecolabstract}
	\end{abswidth}
	\vspace*{0.7cm}
	]
	\saythanks
}
\newcommand*{\addsummaries}[1]{%
	\twocolumn[
	\begin{abswidth}
		#1
	\end{abswidth}

	\vspace*{0.7cm}
	]
}
\fi


%-------------------------------------------------------------------------------
%                Configuration for license
%-------------------------------------------------------------------------------

% get first authors, from https://tex.stackexchange.com/questions/371787/how-to-get-author-name-in-header-et-al
\ExplSyntaxOn\makeatletter
\seq_new:N\l__john_tmpa_seq
\cs_new_protected:Nn \john_getfirst_authblk:n
{
	\regex_extract_once:nnN 
	{ \c{Authfont}([^\c{protect}]+)}
	{#1}\l__john_tmpa_seq
	\seq_item:Nn \l__john_tmpa_seq {2}  
}
\newcommand\ABfirstauthor{%
	\exp_args:No \john_getfirst_authblk:n{\AB@authlist}
}
\ExplSyntaxOff

\AtEndDocument{\vspace*{.5cm} \fontsize{10pt}{1em}\sff \noindent The article \textit{\@title}~© \@theyear~by \ABfirstauthor is licensed under \href{http://creativecommons.org/licenses/by/4.0/}{CC BY 4.0}.}


%-------------------------------------------------------------------------------
%                Configuration for sections
%-------------------------------------------------------------------------------

\titleformat{\section}{\fontsize{14pt}{1em}\bfseries\sff}{\thesection}{1em}{}
%\titlespacing\section{0pt}{8pt plus 4pt minus 2pt}{6pt plus 2pt minus 2pt}
\titleformat{\subsection}{\fontsize{12pt}{0.3em}\bfseries\sff}{\thesubsection}{1em}{}
%\titlespacing\subsection{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\titleformat{\subsubsection}{\fontsize{11pt}{0.1em}\bfseries\sff}{\thesubsubsection}{1em}{}
%\titlespacing\subsubsection{0pt}{8pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

\if@report
\setcounter{secnumdepth}{0}
\else
\setcounter{secnumdepth}{3}
\fi

\newenvironment{acknowledgements}
{\section*{Acknowledgements}
}%
{}

%-------------------------------------------------------------------------------
%                Configuration for header and footer
%-------------------------------------------------------------------------------
\def\reportheader#1{\def\@reportheader{#1}}
\reportheader{}

\if@report
	\ifx\reportheader\prodedname %% check if reportheader empty
	\newcommand{\articletype}{\color{seismicacolor2}REPORT}
	\else
	\newcommand{\articletype}{{\color{seismicacolor2}\MakeUppercase{\@reportheader}}}
	\fi
\else 
	\if@invited
	\newcommand{\articletype}{INVITED RESEARCH ARTICLE}
	\else
		\if@opinion
		\newcommand{\articletype}{REVIEWED OPINION}
		\else
		\newcommand{\articletype}{RESEARCH ARTICLE}
		\fi
	\fi
\fi

\def\shorttitle@internal{}
\newcommand{\shorttitle}[1]{\gdef\shorttitle@internal{#1}}
\newcommand{\insertshorttitle}{\shorttitle@internal}

\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\fancyfoot[L]{\sff\bfseries\footnotesize \thepage}
\fancyfoot[R]{\sflight \footnotesize {\scshape \bfseries \color{seismicacolor1light} SEISMICA}~|~volume \@thevolume.\@thenumber~|~\@theyear}
\fancyhead[L]{\sflight \footnotesize {\scshape \bfseries \color{seismicacolor1light} SEISMICA} | {\scshape \bfseries \articletype} | \insertshorttitle}
%\fancyhead[R]{\footnotesize \@author[1]}
\renewcommand{\headrule}{}

\fancypagestyle{plain}{%
	\fancyhead{}
	\renewcommand{\headrule}{}
	\fancyfoot{}
	\fancyfoot[L]{\sff\bfseries\footnotesize \thepage}
	\fancyfoot[R]{\sflight \footnotesize {\scshape \bfseries \color{seismicacolor1light} SEISMICA}~|~ISSN 2816-9387~|~volume \@thevolume.\@thenumber~|~\@theyear}
}

%
%%-------------------------------------------------------------------------------
%%                Configuration for captions
%%-------------------------------------------------------------------------------

\captionsetup{font=sf, 
	labelfont=bf, 
	labelsep=quad, 
	justification=justified, 
	singlelinecheck=false, oneside}


% equations
\if@breakmath
\renewcommand{\eqnumcolor}{\color{gray}}
\renewcommand{\eqnumfont}{\sff}
\else
\renewcommand{\eqref}[1]{\textup{\eqreftagform@{\ref{#1}}}}
\let\eqreftagform@\tagform@
\def\tagform@#1{%
	\maketag@@@{\color{gray}\sff(\ignorespaces#1\unskip\@@italiccorr)}%
}
\fi

\renewcommand{\theequation}{\color{gray}\sff\arabic{equation}}


%
%%-------------------------------------------------------------------------------
%%                Configuration for tables
%%-------------------------------------------------------------------------------
\def\thickhline{%
	\noalign{\ifnum0=`}\fi\color{gray}\hrule \@height \thickarrayrulewidth \futurelet
	\reserved@a\@xthickhline}
\def\@xthickhline{\ifx\reserved@a\thickhline
	\vskip\doublerulesep
	\vskip-\thickarrayrulewidth
	\fi
	\ifnum0=`{\fi}}

\let\tableorig\table
\def\table@i[#1]{\tableorig[#1]
	\centering
	\sflight\small
	\setlength{\arrayrulewidth}{0.5pt}
	\newlength{\thickarrayrulewidth}
	\setlength{\thickarrayrulewidth}{1.5\arrayrulewidth}
	\arrayrulecolor{gray}}  % with optional argument
\def\table@ii{\tableorig
	\centering
	\sflight\small
	\setlength{\arrayrulewidth}{0.5pt}
	\newlength{\thickarrayrulewidth}
	\setlength{\thickarrayrulewidth}{1.5\arrayrulewidth}
	\arrayrulecolor{gray}}  % without optional argument
\def\table{\@ifnextchar[\table@i \table@ii}

\newenvironment{seistable}[1][*{50}{l}]{%
	\begin{center}
		\begin{tabular}{#1}\thickhline\rule{0pt}{2ex} }{%
			\thickhline\end{tabular}\end{center}\vspace*{-0.7cm}}

%%-------------------------------------------------------------------------------
%%                Configuration for footnotes
%%-------------------------------------------------------------------------------
\let\oldfootnote\footnote
\renewcommand{\footnote}[1]{\oldfootnote{\sflight #1}}
\renewcommand\footnoterule{{\color{lightgray}\rule{0.3\linewidth}{0.05pt}\vspace{0.15cm}}}

%%-------------------------------------------------------------------------------
%%                Configuration for references
%%-------------------------------------------------------------------------------

\setlength{\bibsep}{3pt} %espacement entre les references biblio
\renewcommand{\bibsection}{\section*{References}}
\def\bibfont{\small\sffamily}
\renewcommand*{\doi}[1]{doi: \href{http://doi.org/#1}{#1}}

%%-------------------------------------------------------------------------------
%%                Configuration for code
%%-------------------------------------------------------------------------------

% in-line code words
\def\code#1{\fontsize{9}{10}\colorbox{codebackcolor}{\texttt{#1}}}
\setlength{\fboxsep}{1pt}

\lstset{
	tabsize=4,
	captionpos=t,
	breaklines=true,
	showstringspaces=false,
	basicstyle=\fontsize{9}{10}\ttfamily,
	keywordstyle=\color{seismicacolor2},
	commentstyle=\color{gray},
	stringstyle=\color{seismicacolor1},
	emphstyle=\color{seismicacolor3},
	%	frameshape={RYR}{Y}{Y}{RYR},
	backgroundcolor=\color{codebackcolor},   
	rulecolor=\color{codebackcolor}
}

% end of seismica.cls 
