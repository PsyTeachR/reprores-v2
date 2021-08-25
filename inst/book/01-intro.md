# Getting Started {#intro}

<div class="meme right"><img src="images/memes/rstudio.png" 
     alt="A line drawing of a person looking at a computer with a magnifying glass. The text reads 'I just installed RStudio. I'm a data scientist now.'" /></div>

## Learning Objectives {#ilo-intro}

1. Understand the components of the [RStudio IDE](#rstudio_ide) [(video)](https://youtu.be/CbA6ZVlJE78){class="video"}
2. Type commands into the [console](#console) [(video)](https://youtu.be/wbI4c_7y0kE){class="video"}
3. Understand [function syntax](#function_syx) [(video)](https://youtu.be/X5P038N5Q8I){class="video"}
4. Install a [package](#install-package) [(video)](https://youtu.be/u_pvHnqkVCE){class="video"}


## Resources {#resources-intro}

* [Chapter 1: Introduction](http://r4ds.had.co.nz/introduction.html) in *R for Data Science*
* [RStudio IDE Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf)
* [Introduction to R Markdown](https://rmarkdown.rstudio.com/lesson-1.html)
* [R Markdown Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown-2.0.pdf)
* [R Markdown Reference](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)
* [RStudio Cloud](https://rstudio.cloud/){target="_blank"}


## What is R?

<div class="meme left"><img src="images/01/new_R_logo.png" /></div>

R is a programming environment for data processing and statistical analysis. We use R in Psychology at the University of Glasgow to promote <a class='glossary' target='_blank' title='Research that documents all of the steps between raw data and results in a way that can be verified.' href='https://psyteachr.github.io/glossary/r#reproducible-research'>reproducible research</a>. This refers to being able to document and reproduce all of the steps between raw data and results. R allows you to write <a class='glossary' target='_blank' title='A plain-text file that contains commands in a coding language, such as R.' href='https://psyteachr.github.io/glossary/s#script'>scripts</a> that combine data files, clean data, and run analyses. There are many other ways to do this, including writing SPSS syntax files, but we find R to be a useful tool that is free, open source, and commonly used by research psychologists.

::: {.info data-latex=""}
See Appendix \@ref(installingr) for more information on on how to install R and associated programs.
:::


### The Base R Console {#rconsole}

If you open up the application called R, you will see an "R Console" window that looks something like this.

<div class="figure" style="text-align: center">
<img src="images/01/r_console.png" alt="The R Console window." width="100%" />
<p class="caption">(\#fig:img-repl)The R Console window.</p>
</div>

You can close R and never open it again. We'll be working entirely in RStudio in this class.

::: {.warning data-latex=""}
ALWAYS REMEMBER: Launch R though the RStudio IDE

Launch <img src="images/01/rstudio_icon.png" style="height: 2em; vertical-align: middle;" alt="RStudio.app" /> (RStudio.app), not <img src="images/01/new_R_logo.png" style="height: 2em; vertical-align: middle;" alt="R.app" /> (R.app).
:::

### RStudio {#rstudio_ide}

[RStudio](http://www.rstudio.com) is an Integrated Development Environment (<a class='glossary' target='_blank' title='Integrated Development Environment: a program that serves as a text editor, file manager, and provides functions to help you read and write code. RStudio is an IDE for R.' href='https://psyteachr.github.io/glossary/i#ide'>IDE</a>). This is a program that serves as a text editor, file manager, and provides many functions to help you read and write R code.

<div class="figure" style="text-align: center">
<img src="images/01/rstudio.png" alt="The RStudio IDE" width="100%" />
<p class="caption">(\#fig:img-rstudio)The RStudio IDE</p>
</div>

RStudio is arranged with four window <a class='glossary' target='_blank' title='RStudio is arranged with four window “panes.”' href='https://psyteachr.github.io/glossary/p#panes'>panes</a>. By default, the upper left pane is the **source pane**, where you view and edit source code from files. The bottom left pane is usually the **console pane**, where you can type in commands and view output messages. The right panes have several different tabs that show you information about your code. You can change the location of panes and what tabs are shown under **`Preferences > Pane Layout`**.

### Configure RStudio

In this class, you will be learning how to do <a class='glossary' target='_blank' title='Research that documents all of the steps between raw data and results in a way that can be verified.' href='https://psyteachr.github.io/glossary/r#reproducible-research'>reproducible research</a>.  This involves writing scripts that completely and transparently perform some analysis from start to finish in a way that yields the same result for different people using the same software on different computers. Transparency is a key value of science, as embodied in the "trust but verify" motto. 

<div class="meme right"><img src="images/memes/forgetting.jpg" 
     alt="Fry from Futurama squinting; top text: Not sure if I have a bad memory; bottom text: Or a bad memory" /></div>

When you do things reproducibly, others can understand and check your work. This benefits science, but there is a selfish reason, too: the most important person who will benefit from a reproducible script is your future self. When you return to an analysis after two weeks of vacation, you will thank your earlier self for doing things in a transparent, reproducible way, as you can easily pick up right where you left off.

There are two tweaks that you should do to your RStudio installation to maximize reproducibility. Go to **`Global Options...`** under the **`Tools`** menu (Cmd-,), and uncheck the box that says **`Restore .RData into workspace at startup`**.  If you keep things around in your workspace, things will get messy, and unexpected things will happen. You should always start with a clear workspace. This also means that you never want to save your workspace when you exit, so set this to **`Never`**. The only thing you want to save are your scripts.

<div class="figure" style="text-align: center">
<img src="images/01/repro.png" alt="Alter these settings for increased reproducibility." width="66%" />
<p class="caption">(\#fig:img-repro)Alter these settings for increased reproducibility.</p>
</div>

::: {.try data-latex=""}
Your settings should have:

* Restore .RData into workspace at startup: <select class='webex-solveme' data-answer='["Not Checked"]'> <option></option> <option>Checked</option> <option>Not Checked</option></select>
* Save workspace to .RData on exit: <select class='webex-solveme' data-answer='["Never"]'> <option></option> <option>Always</option> <option>Never</option> <option>Ask</option></select>
:::

## Getting Started

### Console commands {#console}

We are first going to learn about how to interact with the <a class='glossary' target='_blank' title='The pane in RStudio where you can type in commands and view output messages.' href='https://psyteachr.github.io/glossary/c#console'>console</a>. In general, you will be developing R <a class='glossary' target='_blank' title='A plain-text file that contains commands in a coding language, such as R.' href='https://psyteachr.github.io/glossary/s#script'>scripts</a> or <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> files, rather than working directly in the console window. However, you can consider the console a kind of "sandbox" where you can try out lines of code and adapt them until you get them to do what you want. Then you can copy them back into the script editor.

Mostly, however, you will be typing into the script editor window (either into an R script or an R Markdown file) and then sending the commands to the console by placing the cursor on the line and holding down the Ctrl key while you press Enter. The Ctrl+Enter key sequence sends the command in the script to the console.

<div class="meme right"><img src="images/memes/typos.jpg"
     alt="Morpehus from The Matrix; top text: What if I told you; bottom text: Typos are accidents nd accidents happon" /></div>

One simple way to learn about the R console is to use it as a calculator. Enter the lines of code below and see if your results match. Be prepared to make lots of typos (at first).


```r
1 + 1
```

```
## [1] 2
```

The R console remembers a history of the commands you typed in the past. Use the up and down arrow keys on your keyboard to scroll backwards and forwards through your history. It's a lot faster than re-typing.


```r
1 + 1 + 3
```

```
## [1] 5
```

You can break up mathematical expressions over multiple lines; R waits for a complete expression before processing it.


```r
## here comes a long expression
## let's break it over multiple lines
1 + 2 + 3 + 4 + 5 + 6 +
    7 + 8 + 9 +
    10
```

```
## [1] 55
```

Text inside quotes is called a <a class='glossary' target='_blank' title='A piece of text inside of quotes.' href='https://psyteachr.github.io/glossary/s#string'>string</a>.


```r
"Good afternoon"
```

```
## [1] "Good afternoon"
```

You can break up text over multiple lines; R waits for a close quote before processing it. If you want to include a double quote inside this quoted string, <a class='glossary' target='_blank' title='Include special characters like " inside of a string by prefacing them with a backslash.' href='https://psyteachr.github.io/glossary/e#escape'>escape</a> it with a backslash.


```r
africa <- "I hear the drums echoing tonight  
But she hears only whispers of some quiet conversation  
She's coming in, 12:30 flight  
The moonlit wings reflect the stars that guide me towards salvation  
I stopped an old man along the way  
Hoping to find some old forgotten words or ancient melodies  
He turned to me as if to say, \"Hurry boy, it's waiting there for you\"

- Toto"

cat(africa) # cat() prints the string
```

```
## I hear the drums echoing tonight  
## But she hears only whispers of some quiet conversation  
## She's coming in, 12:30 flight  
## The moonlit wings reflect the stars that guide me towards salvation  
## I stopped an old man along the way  
## Hoping to find some old forgotten words or ancient melodies  
## He turned to me as if to say, "Hurry boy, it's waiting there for you"
## 
## - Toto
```


### Objects {#vars}

Often you want to store the result of some computation for later use.  You can store it in an <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/o#object'>object</a> (also sometimes called a <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/v#variable'>variable</a>). An object in R:

* contains only letters, numbers, full stops, and underscores
* starts with a letter or a full stop and a letter
* distinguishes uppercase and lowercase letters (`rickastley` is not the same as `RickAstley`)

The following are valid and different objects:

* `songdata`
* `SongData`
* `song_data`
* `song.data`
* `.song.data`
* `never_gonna_give_you_up_never_gonna_let_you_down`

The following are not valid objects:

* `_song_data`
* `1song`
* `.1song`
* `song data`
* `song-data`

Use the <a class='glossary' target='_blank' title='The symbol <-, which functions like = and assigns the value on the right to the object on the left' href='https://psyteachr.github.io/glossary/a#assignment-operator'>assignment operator</a><-` to assign the value on the right to the object named on the left.


```r
## use the assignment operator '<-'
## R stores the number in the object
x <- 5
```

Now that we have set `x` to a value, we can do something with it:


```r
x * 2

## R evaluates the expression and stores the result in the object boring_calculation
boring_calculation <- 2 + 2
```

```
## [1] 10
```

Note that it doesn't print the result back at you when it's stored. To view the result, just type the object name on a blank line.


```r
boring_calculation
```

```
## [1] 4
```

Once an object is assigned a value, its value doesn't change unless you reassign the object, even if the objects you used to calculate it change. Predict what the code below does and test yourself:


```r
this_year <- 2019
my_birth_year <- 1976
my_age <- this_year - my_birth_year
this_year <- 2020
```

::: {.try data-latex=""}
After all the code above is run:

* `this_year` = <select class='webex-solveme' data-answer='["2020"]'> <option></option> <option>43</option> <option>44</option> <option>1976</option> <option>2019</option> <option>2020</option></select>
* `my_birth_year` = <select class='webex-solveme' data-answer='["1976"]'> <option></option> <option>43</option> <option>44</option> <option>1976</option> <option>2019</option> <option>2020</option></select>
* `my_age` = <select class='webex-solveme' data-answer='["43"]'> <option></option> <option>43</option> <option>44</option> <option>1976</option> <option>2019</option> <option>2020</option></select>
:::


### The environment

Anytime you assign something to a new object, R creates a new entry in the <a class='glossary' target='_blank' title='The interactive workspace where your script runs' href='https://psyteachr.github.io/glossary/g#global-environment'>global environment</a>. Objects in the global environment exist until you end your session; then they disappear forever (unless you save them).

Look at the **Environment** tab in the upper right pane. It lists all of the objects you have created. Click the broom icon to clear all of the objects and start fresh. You can also use the following functions in the console to view all objects, remove one object, or remove all objects.


```r
ls()            # print the objects in the global environment
rm("x")         # remove the object named x from the global environment
rm(list = ls()) # clear out the global environment
```

::: {.info data-latex=""}
In the upper right corner of the Environment tab, change **`List`** to **`Grid`**. Now you can see the type, length, and size of your objects, and reorder the list by any of these attributes.
:::

### Whitespace

R mostly ignores <a class='glossary' target='_blank' title='Spaces, tabs and line breaks' href='https://psyteachr.github.io/glossary/w#whitespace'>whitespace</a>: spaces, tabs, and line breaks. This means that you can use whitespace to help you organise your code.


```r
# a and b are identical
a <- list(ctl = "Control Condition", exp1 = "Experimental Condition 1", exp2 = "Experimental Condition 2")

# but b is much easier to read
b <- list(ctl  = "Control Condition", 
          exp1 = "Experimental Condition 1", 
          exp2 = "Experimental Condition 2")
```

When you see `>` at the beginning of a line, that means R is waiting for you to start a new command.  However, if you see a `+` instead of `>` at the start of the line, that means R is waiting for you to finish a command you started on a previous line.  If you want to cancel whatever command you started, just press the Esc key in the console window and you'll get back to the `>` command prompt.


```r
# R waits until next line for evaluation
(3 + 2) *
     5
```

```
## [1] 25
```

It is often useful to break up long functions onto several lines.


```r
cat("3, 6, 9, the goose drank wine",
    "The monkey chewed tobacco on the streetcar line",
    "The line broke, the monkey got choked",
    "And they all went to heaven in a little rowboat",
    sep = "  \n")
```

```
## 3, 6, 9, the goose drank wine  
## The monkey chewed tobacco on the streetcar line  
## The line broke, the monkey got choked  
## And they all went to heaven in a little rowboat
```


### Function syntax {#function_syx}

A lot of what you do in R involves calling a <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> and storing the results. A function is a named section of code that can be reused. 

For example, `sd` is a function that returns the <a class='glossary' target='_blank' title='A descriptive statistic that measures how spread out data are relative to the mean.' href='https://psyteachr.github.io/glossary/s#standard-deviation'>standard deviation</a> of the <a class='glossary' target='_blank' title='A type of data structure that is basically a list of things like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vector</a> of numbers that you provide as the input <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>argument</a>. Functions are set up like this: 


```r
function_name(argument1, argument2 = "value")
```

The arguments in parentheses can be named (e.g., `argument1 = 10`) or you can skip the names if you put them in the exact same order that they're defined in the function. You can check this by typing `?sd` (or whatever function name you're looking up) into the console and the Help pane will show you the default order under **Usage**. You can skip arguments that have a default value specified.

Most functions return a value, but may also produce side effects like printing to the console.

To illustrate, the function `rnorm()` generates random numbers from the standard <a class='glossary' target='_blank' title='A symmetric distribution of data where values near the centre are most probable.' href='https://psyteachr.github.io/glossary/n#normal-distribution'>normal distribution</a>. The help page for `rnorm()` (accessed by typing `?rnorm` in the console) shows that it has the syntax 


```r
rnorm(n, mean = 0, sd = 1)
```

where `n` is the number of randomly generated numbers you want, `mean` is the mean of the distribution, and `sd` is the standard deviation. The default mean is 0, and the default standard deviation is 1. There is no default for `n`, which means you'll get an error if you don't specify it:


```r
rnorm()
```

```
## Error in rnorm(): argument "n" is missing, with no default
```

If you want 10 random numbers from a normal distribution with mean of 0 and standard deviation, you can just use the defaults.


```r
rnorm(10)
```

```
##  [1] -0.58271936  0.18232597  0.41196235  1.01678274 -0.73662871  0.11082357
##  [7]  0.76760754 -0.74795063 -0.02873406  0.13160397
```

If you want 10 numbers from a normal distribution with a mean of 100:


```r
rnorm(10, 100)
```

```
##  [1] 100.84860 100.12447 101.00873 100.40368 100.16177 100.31968 101.23065
##  [8] 100.66941 100.58128  99.51903
```

This would be an equivalent but less efficient way of calling the function:


```r
rnorm(n = 10, mean = 100)
```

```
##  [1]  99.36136  99.95029  98.82020  99.82439  98.99081  97.66862 102.46461
##  [8]  98.70060 100.66240 101.59724
```

We don't need to name the arguments because R will recognize that we intended to fill in the first and second arguments by their position in the function call. However, if we want to change the default for an argument coming later in the list, then we need to name it. For instance, if we wanted to keep the default `mean = 0` but change the standard deviation to 100, we would do it this way:


```r
rnorm(10, sd = 100)
```

```
##  [1]  125.918834    4.861139  -16.663780 -135.005408  -17.209119  -32.867555
##  [7]  -26.522804 -144.441317   74.673824  105.186483
```

Some functions give a list of options after an argument; this means the default value is the first option. The usage entry for the `power.t.test()` function looks like this:


```r
power.t.test(n = NULL, delta = NULL, sd = 1, sig.level = 0.05,
             power = NULL,
             type = c("two.sample", "one.sample", "paired"),
             alternative = c("two.sided", "one.sided"),
             strict = FALSE, tol = .Machine$double.eps^0.25)
```

::: {.try data-latex=""}

* What is the default value for `sd`? <select class='webex-solveme' data-answer='["1"]'> <option></option> <option>NULL</option> <option>1</option> <option>0.05</option> <option>two.sample</option></select>
* What is the default value for `type`? <select class='webex-solveme' data-answer='["two.sample"]'> <option></option> <option>NULL</option> <option>two.sample</option> <option>one.sample</option> <option>paired</option></select>
* Which is equivalent to `power.t.test(100, 0.5)`? <select class='webex-solveme' data-answer='["power.t.test(delta = 0.5, n = 100)"]'> <option></option> <option>power.t.test(100, 0.5, sig.level = 1, sd = 0.05)</option> <option>power.t.test()</option> <option>power.t.test(n = 100)</option> <option>power.t.test(delta = 0.5, n = 100)</option></select>

:::

### Getting help {#help}

Start up help in a browser using the function `help.start()`.

If a function is in <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> or a loaded <a class='glossary' target='_blank' title='A group of R functions.' href='https://psyteachr.github.io/glossary/p#package'>package</a>, you can use the `help("function_name")` function or the `?function_name` shortcut to access the help file. If the package isn't loaded, specify the package name as the second argument to the help function.


```r
# these methods are all equivalent ways of getting help
help("rnorm")
?rnorm
help("rnorm", package="stats") 
```

When the package isn't loaded or you aren't sure what package the function is in, use the shortcut `??function_name`.

::: {.try data-latex=""}

* What is the first argument to the `mean` function? <select class='webex-solveme' data-answer='["x"]'> <option></option> <option>trim</option> <option>na.rm</option> <option>mean</option> <option>x</option></select>
* What package is `read_excel` in? <select class='webex-solveme' data-answer='["readxl"]'> <option></option> <option>readr</option> <option>readxl</option> <option>base</option> <option>stats</option></select>
:::

## Add-on packages {#install-package}

One of the great things about R is that it is **user extensible**: anyone can create a new add-on software package that extends its functionality. There are currently thousands of add-on packages that R users have created to solve many different kinds of problems, or just simply to have fun. There are packages for data visualisation, machine learning, neuroimaging, eyetracking, web scraping, and playing games such as Sudoku.

Add-on packages are not distributed with base R, but have to be downloaded and installed from an archive, in the same way that you would, for instance, download and install a fitness app on your smartphone.

The main repository where packages reside is called CRAN, the Comprehensive R Archive Network. A package has to pass strict tests devised by the R core team to be allowed to be part of the CRAN archive. You can install from the CRAN archive through R using the `install.packages()` function.

There is an important distinction between **installing** a package and **loading** a package.

### Installing a package 

<div class="meme right"><img src="images/memes/pokemon.gif" /></div>

This is done using `install.packages()`. This is like installing an app on your phone: you only have to do it once and the app will remain installed until you remove it. For instance, if you want to use PokemonGo on your phone, you install it once from the App Store or Play Store, and you don't have to re-install it each time you want to use it. Once you launch the app, it will run in the background until you close it or restart your phone. Likewise, when you install a package, the package will be available (but not *loaded*) every time you open up R.

::: {.warning data-latex=""}
You may only be able to permanently install packages if you are using R on your own system; you may not be able to do this on public workstations if you lack the appropriate privileges.
:::

Install the `ggExtra` package on your system. This package lets you create plots with marginal histograms.


```r
install.packages("ggExtra")
```

If you don't already have packages like ggplot2 and shiny installed, it will also install these **dependencies** for you. If you don't get an error message at the end, the installation was successful. 

### Loading a package

This is done using `library(packagename)`. This is like **launching** an app on your phone: the functionality is only there where the app is launched and remains there until you close the app or restart. Likewise, when you run `library(packagename)` within a session, the functionality of the package referred to by `packagename` will be made available for your R session. The next time you start R, you will need to run the `library()` function again if you want to access its functionality.

You can load the functions in `ggExtra` for your current R session as follows:


```r
library(ggExtra)
```

You might get some red text when you load a package, this is normal. It is usually warning you that this package has functions that have the same name as other packages you've already loaded.

::: {.info data-latex=""}
You can use the convention `package::function()` to indicate in which add-on package a function resides. For instance, if you see `readr::read_csv()`, that refers to the function `read_csv()` in the `readr` add-on package.
:::

Now you can run the function `ggExtra::runExample()`, which runs an interactive example of marginal plots using shiny.


```r
ggExtra::runExample()
```



### Install from GitHub

Many R packages are not yet on <a class='glossary' target='_blank' title='The Comprehensive R Archive Network: a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R.' href='https://psyteachr.github.io/glossary/c#cran'>CRAN</a> because they are still in development. Increasingly, datasets and code for papers are available as packages you can download from github. You'll need to install the devtools package to be able to install packages from github. Check if you have a package installed by trying to load it (e.g., if you don't have devtools installed, `library("devtools")` will display an error message) or by searching for it in the packages tab in the lower right pane. All listed packages are installed; all checked packages are currently loaded.

<div class="figure" style="text-align: center">
<img src="images/01/packages.png" alt="Check installed and loaded packages in the packages tab in the lower right pane." width="100%" />
<p class="caption">(\#fig:img-packages)Check installed and loaded packages in the packages tab in the lower right pane.</p>
</div>


```r
# install devtools if you get
# Error in loadNamespace(name) : there is no package called ‘devtools’
# install.packages("devtools")
devtools::install_github("psyteachr/reprores-v2")
```

After you install the reprores package, load it using the `library()` function. You can then try out some of the functions below.


```r
library(reprores)

# opens a local copy of this book in your web browser
book()

# opens a shiny app that lets you see how simulated data would look in different plot styles
app("plotdemo")

# creates and opens a file containing the exercises for this chapter
exercise(1)
```


::: {.try data-latex=""}
How many different ways can you find to discover what functions are available in the reprores package?
:::

Reprores contains datasets that we will be using in future lessons. `getdata()` creates a directory called "data" with all of the class datasets.


```r
# loads the disgust dataset
data("disgust")

# shows the documentation for the built-in dataset `disgust`
?disgust

# saves datasets into a "data" folder in your working directory
getdata("data")
```




## Glossary  {#glossaryintro}

Each chapter ends with a glossary table defining the jargon introduced in this chapter. The links below take you to the [glossary book](https://psyteachr.github.io/glossary), which you can also download for offline use with `devtools::install_github("psyteachr/glossary")` and access the glossary offline with `glossary::book()`.



|term                                                                                                                         |definition                                                                                                                                                                 |
|:----------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|[argument](https://psyteachr.github.io/glossary/a.html#argument){class="glossary" target="_blank"}                           |A variable that provides input to a function.                                                                                                                              |
|[assignment operator](https://psyteachr.github.io/glossary/a.html#assignment-operator){class="glossary" target="_blank"}     |The symbol <-, which functions like = and assigns the value on the right to the object on the left                                                                         |
|[base r](https://psyteachr.github.io/glossary/b.html#base-r){class="glossary" target="_blank"}                               |The set of R functions that come with a basic installation of R, before you add external packages                                                                          |
|[console](https://psyteachr.github.io/glossary/c.html#console){class="glossary" target="_blank"}                             |The pane in RStudio where you can type in commands and view output messages.                                                                                               |
|[cran](https://psyteachr.github.io/glossary/c.html#cran){class="glossary" target="_blank"}                                   |The Comprehensive R Archive Network: a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R.         |
|[escape](https://psyteachr.github.io/glossary/e.html#escape){class="glossary" target="_blank"}                               |Include special characters like " inside of a string by prefacing them with a backslash.                                                                                   |
|[function](https://psyteachr.github.io/glossary/f.html#function){class="glossary" target="_blank"}                           |A named section of code that can be reused.                                                                                                                                |
|[global environment](https://psyteachr.github.io/glossary/g.html#global-environment){class="glossary" target="_blank"}       |The interactive workspace where your script runs                                                                                                                           |
|[ide](https://psyteachr.github.io/glossary/i.html#ide){class="glossary" target="_blank"}                                     |Integrated Development Environment: a program that serves as a text editor, file manager, and provides functions to help you read and write code. RStudio is an IDE for R. |
|[normal distribution](https://psyteachr.github.io/glossary/n.html#normal-distribution){class="glossary" target="_blank"}     |A symmetric distribution of data where values near the centre are most probable.                                                                                           |
|[object](https://psyteachr.github.io/glossary/o.html#object){class="glossary" target="_blank"}                               |A word that identifies and stores the value of some data for later use.                                                                                                    |
|[package](https://psyteachr.github.io/glossary/p.html#package){class="glossary" target="_blank"}                             |A group of R functions.                                                                                                                                                    |
|[panes](https://psyteachr.github.io/glossary/p.html#panes){class="glossary" target="_blank"}                                 |RStudio is arranged with four window “panes.”                                                                                                                              |
|[r markdown](https://psyteachr.github.io/glossary/r.html#r-markdown){class="glossary" target="_blank"}                       |The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.           |
|[reproducible research](https://psyteachr.github.io/glossary/r.html#reproducible-research){class="glossary" target="_blank"} |Research that documents all of the steps between raw data and results in a way that can be verified.                                                                       |
|[script](https://psyteachr.github.io/glossary/s.html#script){class="glossary" target="_blank"}                               |A plain-text file that contains commands in a coding language, such as R.                                                                                                  |
|[standard deviation](https://psyteachr.github.io/glossary/s.html#standard-deviation){class="glossary" target="_blank"}       |A descriptive statistic that measures how spread out data are relative to the mean.                                                                                        |
|[string](https://psyteachr.github.io/glossary/s.html#string){class="glossary" target="_blank"}                               |A piece of text inside of quotes.                                                                                                                                          |
|[variable](https://psyteachr.github.io/glossary/v.html#variable){class="glossary" target="_blank"}                           |A word that identifies and stores the value of some data for later use.                                                                                                    |
|[vector](https://psyteachr.github.io/glossary/v.html#vector){class="glossary" target="_blank"}                               |A type of data structure that is basically a list of things like T/F values, numbers, or strings.                                                                          |
|[whitespace](https://psyteachr.github.io/glossary/w.html#whitespace){class="glossary" target="_blank"}                       |Spaces, tabs and line breaks                                                                                                                                               |



## Exercises {#exercises-intro}

Download the first set of [exercises](exercises/01_intro_exercise.Rmd). See the [answers](exercises/01_intro_answers.Rmd) only after you've attempted all the questions.


```r
# run this to access the exercise
reprores::exercise(1)

# run this to access the answers
reprores::exercise(1, answers = TRUE)
```
