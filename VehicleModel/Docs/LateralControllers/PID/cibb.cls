%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cibb class for LaTeX files               v1.2 March 20 2023    %%
%% edited by Massimo Bellato and Giacomo Baruzzo 		  %%
%% email: massimo.bellato@unipd.it , giacomo.baruzzo@unipd.it     %%
%% original v1.1 from Francesco Masulli masulli@disi.unige.it     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cibb}[2023/03/20 cibb paper class]

\DeclareOption{10pt}{\OptionNotUsed}
%\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

\LoadClass[12pt,a4paper]{article}

\RequirePackage{calc}
\RequirePackage{indentfirst}

\usepackage{times}

%% Title
\renewcommand{\@maketitle}{%
 %\newpage
 \thispagestyle{plain}
 \begin{flushleft}%
  {%3
   \fontsize{14}{14}\selectfont
   %\bfseries
   \@title
   %\MakeUppercase{\@title}
   \par
  }%3
  \vspace{12pt}%
  {%4
   \@author
   \par
  }%4
  %\vspace{14pt}%
  {%5
   \def\and{\\\vspace{14pt}}
   \normalfont\@address
   \par
  }%5
 \end{flushleft}
 \vspace{5pt}%
% \noindent\textbf{Key words:\space}\@keywords
% \par
% \vspace{18pt}%
 \noindent {{\em Keywords}:\space }{\@abstract}
 %\par
 %\vfill
}% End of \@maketitle

\def\author{\@ifnextchar[{\@getshortauthor}{\@getauthor}}
\def\@getauthor#1{\gdef\@author{#1}\gdef\@shortauthor{#1}}
\def\@getshortauthor[#1]#2{\gdef\@shortauthor{#1}\gdef\@author{#2}}

\newcommand{\address}[1]{\gdef\@address{#1}}

\newcommand{\keywords}[1]{\gdef\@keywords{#1}}

\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}

\newcommand{\heading}[1]{\gdef\@heading{#1}}

%\def\ps@myheadings{%
 %   \def\@oddfoot{\normalfont\hfil\thepage\hfil}
  %  \let\@evenfoot\@oddfoot
   % \def\@evenhead{%
    %    \parbox[t][11.5pt][t]{\textwidth}{%
     %   \centering
      %  \normalfont
       % \fontsize{10}{10}\selectfont
    %    \@heading\\[0.3pt]
%        \rule{\textwidth}{1pt}%
   %  }
   % }%%
  %  \let\@oddhead\@evenhead
  %  \let\@mkboth\@gobbletwo
  %  \let\sectionmark\@gobble
  %  \let\subsectionmark\@gobble
%}

\def\sectionLevel{1}
\def\sectionIndent{6mm}
\def\sectionSpaceBefore{12pt}
\def\sectionSpaceAfter{1pt}
\def\sectionStyle{\normalsize\bfseries}

\renewcommand{\section}{%
  \@startsection{section}{\sectionLevel}{\sectionIndent}{\sectionSpaceBefore}%
                {\sectionSpaceAfter}{\sectionStyle}}%


\def\sectionLevelsub{2}
\def\sectionIndentsub{6mm}
\def\sectionSpaceBeforesub{12pt}
\def\sectionSpaceAftersub{1pt}
\def\sectionStylesub{\normalsize}

\renewcommand{\subsection}{%
  \@startsection{subsection}{\sectionLevelsub}{\sectionIndentsub}{\sectionSpaceBeforesub}%
                {\sectionSpaceAftersub}{\sectionStylesub}}%


\renewcommand{\@makecaption}[2]{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\normalsize\fontsize{10}{12}\selectfont #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    \normalsize\fontsize{10}{12}\selectfont #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}


\setlength{\oddsidemargin}{-5mm}%{7.6mm}
\setlength{\evensidemargin}{-5mm}%{7.6mm}
\setlength{\voffset}{0mm}
\setlength{\topmargin}{-10mm}%{0mm}
\setlength{\headheight}{24.6mm}
\setlength{\headsep}{0mm}
\setlength{\textheight}{250mm} %{197mm}
\setlength{\textwidth}{165mm} %{140mm}
\setlength{\textfloatsep}{12pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\parindent}{5mm}
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{6pt}
\setlength{\itemsep}{0pt}



\usepackage[paperheight=29.7cm, paperwidth=21cm,nomarginpar,textwidth=16cm,headheight=2.5cm,top=2.5cm,bottom=2.5cm]{geometry}
\headsep=10pt


\AtBeginDocument{%
%  \pagestyle{myheadings}
  \pagestyle{plain}
  \maketitle
  %\newpage
  \let\maketitle\relax
}

\endinput
