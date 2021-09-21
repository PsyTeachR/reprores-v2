# Working with Data {#data}

<div class="right meme"><img src="images/memes/read_csv.png"
     alt = "Top left: Pooh Bear in a red shirt looking sad; Top right: read.csv() in outline font; Bottom left: Pooh Bear in a tuxedo looking smug; Bottom right: read_csv() in handwritten font" /></div>

## Learning Objectives {#ilo-data}

1. Load [built-in datasets](#builtin) [(video)](https://youtu.be/Z5fK5VGmzlY){class="video"}
2. [Import data](#import_data) from CSV and Excel files [(video)](https://youtu.be/a7Ra-hnB8l8){class="video"}
3. Create a [data table](#tables-data) [(video)](https://youtu.be/k-aqhurepb4){class="video"}
4. Understand the use the [basic data types](#data_types) [(video)](https://youtu.be/jXQrF18Jaac){class="video"}
5. Understand and use the [basic container types](#containers) (list, vector) [(video)](https://youtu.be/4xU7uKNdoig){class="video"}
6. Use [vectorized operations](#vectorized_ops) [(video)](https://youtu.be/9I5MdS7UWmI){class="video"}
7. Be able to [troubleshoot](#Troubleshooting) common data import problems [(video)](https://youtu.be/gcxn4LJ_vAI){class="video"}



## Setup {#setup-data}


```r
# libraries needed for these examples
library(tidyverse)
library(reprores)
```

## Data tables

### Built-in data {#builtin}

R comes with built-in datasets. Some packages, like tidyr and reprores, also contain data. The `data()` function lists the datasets available in a package.


```r
# lists datasets in reprores
data(package = "reprores")
```

Type the name of a dataset into the console to see the data. Type `?smalldata` into the console to see the dataset description.


```r
smalldata
```

<div class="kable-table">

|id  |group   |       pre|      post|
|:---|:-------|---------:|---------:|
|S01 |control |  98.46606| 106.70508|
|S02 |control | 104.39774|  89.09030|
|S03 |control | 105.13377| 123.67230|
|S04 |control |  92.42574|  70.70178|
|S05 |control | 123.53268| 124.95526|
|S06 |exp     |  97.48676| 101.61697|
|S07 |exp     |  87.75594| 126.30077|
|S08 |exp     |  77.15375|  72.31229|
|S09 |exp     |  97.00283| 108.80713|
|S10 |exp     | 102.32338| 113.74732|

</div>

You can also use the `data()` function to load a dataset into your <a class='glossary' target='_blank' title='The interactive workspace where your script runs' href='https://psyteachr.github.io/glossary/g#global-environment'>global environment</a>.


```r
# loads smalldata into the environment
data("smalldata")
```


Always, always, always, look at your data once you've created or loaded a table. Also look at it after each step that transforms your table. There are three main ways to look at your tibble: `print()`, `glimpse()`, and `View()`. 

The `print()` method can be run explicitly, but is more commonly called by just typing the variable name on the blank line. The default is not to print the entire table, but just the first 10 rows. It's rare to print your data in a script; that is something you usually are doing for a sanity check, and you should just do it in the console.  

Let's look at the `smalldata` table that we made above. 


```r
smalldata
```

<div class="kable-table">

|id  |group   |       pre|      post|
|:---|:-------|---------:|---------:|
|S01 |control |  98.46606| 106.70508|
|S02 |control | 104.39774|  89.09030|
|S03 |control | 105.13377| 123.67230|
|S04 |control |  92.42574|  70.70178|
|S05 |control | 123.53268| 124.95526|
|S06 |exp     |  97.48676| 101.61697|
|S07 |exp     |  87.75594| 126.30077|
|S08 |exp     |  77.15375|  72.31229|
|S09 |exp     |  97.00283| 108.80713|
|S10 |exp     | 102.32338| 113.74732|

</div>

The function `glimpse()` gives a sideways version of the tibble. This is useful if the table is very wide and you can't see all of the columns. It also tells you the data type of each column in angled brackets after each column name. We'll learn about [data types](#data_types) below.


```r
glimpse(smalldata)
```

```
## Rows: 10
## Columns: 4
## $ id    <chr> "S01", "S02", "S03", "S04", "S05", "S06", "S07", "S08", "S09", "…
## $ group <chr> "control", "control", "control", "control", "control", "exp", "e…
## $ pre   <dbl> 98.46606, 104.39774, 105.13377, 92.42574, 123.53268, 97.48676, 8…
## $ post  <dbl> 106.70508, 89.09030, 123.67230, 70.70178, 124.95526, 101.61697, …
```

The other way to look at the table is a more graphical spreadsheet-like version given by `View()` (capital 'V').  It can be useful in the console, but don't ever put this one in a script because it will create an annoying pop-up window when the user runs it.
Now you can click on `smalldata` in the environment pane to open it up in a viewer that looks a bit like Excel.

You can get a quick summary of a dataset with the `summary()` function.


```r
summary(smalldata)
```

```
##       id               group                pre              post       
##  Length:10          Length:10          Min.   : 77.15   Min.   : 70.70  
##  Class :character   Class :character   1st Qu.: 93.57   1st Qu.: 92.22  
##  Mode  :character   Mode  :character   Median : 97.98   Median :107.76  
##                                        Mean   : 98.57   Mean   :103.79  
##                                        3rd Qu.:103.88   3rd Qu.:121.19  
##                                        Max.   :123.53   Max.   :126.30
```

You can even do things like calculate the difference between the means of two columns.


```r
pre_mean <- mean(smalldata$pre)
post_mean <- mean(smalldata$post)
post_mean - pre_mean
```

```
## [1] 5.223055
```


### Importing data {#import_data}

Built-in data are nice for examples, but you're probably more interested in your own data. There are many different types of files that you might work with when doing data analysis. These different file types are usually distinguished by the three letter <a class='glossary' target='_blank' title='The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd).' href='https://psyteachr.github.io/glossary/e#extension'>extension</a> following a period at the end of the file name. Here are some examples of different types of files and the functions you would use to read them in or write them out.

| Extension   | File Type              | Reading                | Writing              |
|-------------|------------------------|------------------------|----------------------|
| .csv        | Comma-separated values | `readr::read_csv()`    | `readr::write_csv()` |
| .tsv, .txt  | Tab-separated values   | `readr::read_tsv()`    | `readr::write_tsv()` |
| .xls, .xlsx | Excel workbook         | `readxl::read_excel()` | `rio::export()`      |
| .sav        | SPSS files             | `haven::read_sav()`    | `haven::write_sav()` |
| .json       | JSON files        | `jsonlite::read_json()` | `jsonlite::write_json()` |
| .mat, ...   | Multiple types         | `rio::import()`        | `rio::export()`      |

The double colon means that the function on the right comes from the package on the left, so `readr::read_csv()` refers to the `read_csv()` function in the <code class='package'>readr</code> package, and `readxl::read_excel()` refers to the function `read_excel()` in the <code class='package'>readxl</code> package. The function `rio::import()` from the <code class='package'>rio</code> package will read almost any type of data file, including SPSS and Matlab. Check the help with `?rio::import` to see a full list.

You can get a directory of data files used in this class for tutorials and exercises with the following code, which will create a directory called "data" in your project directory. Alternatively, you can download a [zip file of the datasets](data/data.zip).


```r
psyteachr::getdata()
```

#### CSV Files

The most common file type you will encounter in this class is <a class='glossary' target='_blank' title='Comma-separated variable: a file type for representing data where each variable is separated from the next by a comma.' href='https://psyteachr.github.io/glossary/c#csv'>.csv</a> (comma-separated values).  As the name suggests, a CSV file distinguishes which values go with which variable by separating them with commas, and text values are sometimes enclosed in double quotes. The first line of a file usually provides the names of the variables. 

For example, here is a small CSV containing demo data:

    ```
    character,integer,double,logical,date
    A,1,1.5,TRUE,05-Sep-21
    B,2,2.5,TRUE,04-Sep-21
    C,3,3.5,FALSE,03-Sep-21
    D,4,4.5,FALSE,02-Sep-21
    E,5,5.5,,01-Sep-21
    F,6,6.5,TRUE,31-Aug-21
    ```

There are five variables in this dataset, and their names are given in the first line of the file: `character`, `integer`, `double` ,``logical`, and `date`. You can see that the values for each of these variables are given in order, separated by commas, on each subsequent line of the file.

Use `readr::read_csv()` to read in the data as assign it to an <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/o#object'>object</a> called `demo_csv`.



```r
demo_csv  <- readr::read_csv("data/demo.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   character = col_character(),
##   integer = col_double(),
##   double = col_double(),
##   logical = col_logical(),
##   date = col_character()
## )
```

This function will give you some information about the data you just read in so you can check the column names and [data types](#data_types). If it makes a mistake, such as reading the "date" column as a <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a>, you can manually set the column data types. Just copy the "Column specification" that was printed when you first imported the data, and make any changes you need.


```r
ct <- cols(
  character = col_character(),
  integer = col_double(),
  double = col_double(),
  logical = col_logical(),
  date = col_date(format = "%d-%b-%y")
)

demo  <- readr::read_csv("data/demo.csv", col_types = ct)
```

::: {.info data-latex=""}
For dates, you might need to set the format. See `?strptime` for a list of the codes used to represent different date formats. Above, <code><span class='st'>"%d-%b-%y"</span></code> means that the dates are formatted like `{day number}-{month abbreviation}-{2-digit year}`. 
:::

We'll learn more about how to fix data import problems in the [troubleshooting](#troubleshooting) section below.

#### Other File Types

Use the functions below to read in other file types.


```r
demo_tsv  <- readr::read_tsv("data/demo.tsv")
demo_xls  <- readxl::read_excel("data/demo.xlsx")
demo_sav  <- haven::read_sav("data/demo.sav")
demo_json <- jsonlite::read_json("data/demo.json")
```

You can access Google Sheets directly from R using <code class='package'><a href='https://googlesheets4.tidyverse.org/' target='_blank'>googlesheets4</a></code>.


```r
library(googlesheets4)

gs4_deauth() # skip authorisation for public data

url <- "https://docs.google.com/spreadsheets/d/1yhAPP0hk6fNssL9UdpJ7m_vx00VY5PQKHspx6DNQNSY/"

demo_goo  <- googlesheets4::read_sheet(url)
```

::: {.try data-latex=""}
Try loading in all five of the `5factor` datasets in the data directory.


<div class='webex-solution'><button>Solution</button>

```r
ocean_csv  <- readr::read_csv("data/5factor.csv")
ocean_tsv  <- readr::read_tsv("data/5factor.txt")
ocean_xls  <- readxl::read_excel("data/5factor.xls")
ocean_xlsx <- readxl::read_excel("data/5factor.xlsx")
ocean_sav  <- haven::read_sav("data/5factor.sav")
```


</div>
:::


### Looking at data

Now that you've loaded some data, look the upper right hand window of RStudio, under the Environment tab. You will see the objects listed, along with their number of observations (rows) and variables (columns). This is your first check that everything went OK.

Always, always, always, look at your data once you've created or loaded a table. Also look at it after each step that transforms your table. There are three main ways to look at your table: <code><span class='fu'><a href='https://rdrr.io/r/utils/View.html'>View</a></span><span class='op'>(</span><span class='op'>)</span></code>, <code><span class='fu'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='op'>(</span><span class='op'>)</span></code>, <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a href='https://pillar.r-lib.org/reference/glimpse.html'>glimpse</a></span><span class='op'>(</span><span class='op'>)</span></code>. 

#### View() 

A familiar way to look at the table is given by <code><span class='fu'><a href='https://rdrr.io/r/utils/View.html'>View</a></span><span class='op'>(</span><span class='op'>)</span></code> (uppercase 'V'). This command can be useful in the console, but don't ever put this one in a script because it will create an annoying pop-up window when the user runs it. Or you can click on an objects in the  <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>environment pane</a> to open it up in a viewer that looks a bit like Excel. You can close the tab when you're done looking at it; it won't remove the object.

#### print() 

The <code><span class='fu'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='op'>(</span><span class='op'>)</span></code> method can be run explicitly, but is more commonly called by just typing the variable name on the blank line. The default is not to print the entire table, but just the first 10 rows. 

Let's look at the `demo_tsv` table that we loaded above. Depending on how wide your screen is, you might need to click on an arrow at the right of the table to see the last column. 


```r
demo_tsv
```

<div class="kable-table">

|character | integer| double|logical |date      |
|:---------|-------:|------:|:-------|:---------|
|A         |       1|    1.5|TRUE    |05-Sep-21 |
|B         |       2|    2.5|TRUE    |04-Sep-21 |
|C         |       3|    3.5|FALSE   |03-Sep-21 |
|D         |       4|    4.5|FALSE   |02-Sep-21 |
|E         |       5|    5.5|NA      |01-Sep-21 |
|F         |       6|    6.5|TRUE    |31-Aug-21 |

</div>

#### glimpse() 

The function <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a href='https://pillar.r-lib.org/reference/glimpse.html'>glimpse</a></span><span class='op'>(</span><span class='op'>)</span></code> gives a sideways version of the table. This is useful if the table is very wide and you can't see all of the columns. It also tells you the <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a> of each column in angled brackets after each column name. 


```r
glimpse(demo_xls)
```

```
## Rows: 6
## Columns: 5
## $ character <chr> "A", "B", "C", "D", "E", "F"
## $ integer   <dbl> 1, 2, 3, 4, 5, 6
## $ double    <dbl> 1.5, 2.5, 3.5, 4.5, 5.5, 6.5
## $ logical   <lgl> TRUE, TRUE, FALSE, FALSE, NA, TRUE
## $ date      <chr> "05-Sep-21", "04-Sep-21", "03-Sep-21", "02-Sep-21", "01-Sep-…
```

#### summary() {#summary-function}

You can get a quick summary of a dataset with the <code><span class='fu'><a href='https://rdrr.io/r/base/summary.html'>summary</a></span><span class='op'>(</span><span class='op'>)</span></code> function.


```r
summary(demo_sav)
```

```
##   character            integer         double        logical   
##  Length:6           Min.   :1.00   Min.   :1.50   Min.   :0.0  
##  Class :character   1st Qu.:2.25   1st Qu.:2.75   1st Qu.:0.0  
##  Mode  :character   Median :3.50   Median :4.00   Median :1.0  
##                     Mean   :3.50   Mean   :4.00   Mean   :0.6  
##                     3rd Qu.:4.75   3rd Qu.:5.25   3rd Qu.:1.0  
##                     Max.   :6.00   Max.   :6.50   Max.   :1.0  
##                                                   NA's   :1    
##      date          
##  Length:6          
##  Class :character  
##  Mode  :character  
##                    
##                    
##                    
## 
```

### Creating data 

If we are creating a data table from scratch, we can use the `tibble::tibble()` function, and type the data right in. The <code class='package'>tibble</code> package is part of the <a class='glossary' target='_blank' title='A set of R packages that help you create and work with tidy data' href='https://psyteachr.github.io/glossary/t#tidyverse'>tidyverse</a> package that we loaded at the start of this chapter. 

Let's create a small table with the names of three Avatar characters and their bending type. The `tibble()` function takes arguments with the names that you want your columns to have. The values are vectors that list the column values in order.

If you don't know the value for one of the cells, you can enter `NA`, which we have to do for Sokka because he doesn't have any bending ability. If all the values in the column are the same, you can just enter one value and it will be copied for each row.


```r
avatar <- tibble(
  name = c("Katara", "Toph", "Sokka"),
  bends = c("water", "earth", NA),
  friendly = TRUE
)

# print it
avatar
```

<div class="kable-table">

|name   |bends |friendly |
|:------|:-----|:--------|
|Katara |water |TRUE     |
|Toph   |earth |TRUE     |
|Sokka  |NA    |TRUE     |

</div>


### Writing Data

If you have data that you want to save to a CSV file, use `readr::write_csv()`, as follows.


```r
write_csv(avatar, "avatar.csv")
```

This will save the data in CSV format to your working directory.

Writing to Google Sheets is a little trickier. Even if a Google Sheet is publicly editable, you can't add data to it without authorising your account. 

You can authorise interactively using the following code (and your own email), which will prompt you to authorise "Tidyverse API Packages" the first time you do this.


```r
gs4_auth(email = "debruine@gmail.com")
sheet_id <- gs4_create("demo-file", sheets = demo)

new_data <- tibble(
  character = "Z",
  integer = 0L,
  double = 0.5,
  logical = FALSE,
  date = "01-Jan-00"
)

sheet_append(sheet_id, new_data)
demo <- read_sheet(sheet_id)
```


::: {.try data-latex=""}
* Create a new table called `family` with the first name, last name, and age of your family members. 
* Save it to a CSV file called <code class='path'>family.csv</code>. 
* Clear the object from your environment by restarting R or with the code <code><span class='fu'><a href='https://rdrr.io/r/base/rm.html'>remove</a></span><span class='op'>(</span><span class='va'>family</span><span class='op'>)</span></code>.
* Load the data back in and view it.
:::


<div class='webex-solution'><button>Solution</button>

```r
# create the table
family <- tribble(
  ~first_name, ~last_name, ~age,
  "Lisa", "DeBruine", 45,
  "Robbie", "Jones", 14
)

# save the data to CSV
export(family, "data/family.csv")

# remove the object from the environment
remove(family)

# load the data
family <- import("data/family.csv")
```


</div>
:::

We'll be working with <a class='glossary' target='_blank' title='Data in a rectangular table format, where each row has an entry for each column.' href='https://psyteachr.github.io/glossary/t#tabular-data'>tabular data</a> a lot in this class, but tabular data is made up of <a class='glossary' target='_blank' title='A type of data structure that collects values with the same data type, like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vectors</a>, which group together data with the same basic <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a>. The following sections explain some of this terminology to help you understand the functions we'll be learning to process and analyse data.

## Basic data types {#data_types}

Data can be numbers, words, true/false values or combinations of these. In order to understand some later concepts, it's useful to have a basic understanding of <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data types</a> in R: <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a>, <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a>, and <a class='glossary' target='_blank' title='A data type representing TRUE or FALSE values.' href='https://psyteachr.github.io/glossary/l#logical'>logical</a> 

### Numeric data

All of the real numbers are <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a> data types (imaginary numbers are "complex"). There are two types of numeric data, <a class='glossary' target='_blank' title='A data type representing whole numbers.' href='https://psyteachr.github.io/glossary/i#integer'>integer</a> and <a class='glossary' target='_blank' title='A data type representing a real decimal number' href='https://psyteachr.github.io/glossary/d#double'>double</a>. Integers are the whole numbers, like <code><span class='op'>-</span><span class='fl'>1</span></code>, <code><span class='fl'>0</span></code> and <code><span class='fl'>1</span></code>. Doubles are numbers that can have fractional amounts. If you just type a plain number such as <code><span class='fl'>10</span></code>, it is stored as a double, even if it doesn't have a decimal point. If you want it to be an exact integer, use the `L` suffix (<code><span class='fl'>10L</span></code>).

If you ever want to know the data type of something, use the `typeof()` function.


```r
typeof(10)   # double
typeof(10.0) # double
typeof(10L)  # integer
typeof(10i)  # complex
```

```
## [1] "double"
## [1] "double"
## [1] "integer"
## [1] "complex"
```

If you want to know if something is numeric (a double or an integer), you can use the function `is.numeric()` and it will tell you if it is numeric (`TRUE`) or not (`FALSE`).


```r
is.numeric(10L)
is.numeric(10.0)
is.numeric("Not a number")
```

```
## [1] TRUE
## [1] TRUE
## [1] FALSE
```

### Character data

<a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>Character</a> strings are any text between quotation marks. 


```r
typeof("This is a character string")
typeof('You can use double or single quotes')
```

```
## [1] "character"
## [1] "character"
```

This can include quotes, but you have to <a class='glossary' target='_blank' title='Include special characters like " inside of a string by prefacing them with a backslash.' href='https://psyteachr.github.io/glossary/e#escape'>escape</a> it using a backslash to signal the the quote isn't meant to be the end of the string.


```r
my_string <- "The instructor said, \"R is cool,\" and the class agreed."
cat(my_string) # cat() prints the arguments
```

```
## The instructor said, "R is cool," and the class agreed.
```

### Logical Data

<a class='glossary' target='_blank' title='A data type representing TRUE or FALSE values.' href='https://psyteachr.github.io/glossary/l#logical'>Logical</a> data (also sometimes called "boolean" values) is one of two values: true or false. In R, we always write them in uppercase: `TRUE` and `FALSE`.


```r
class(TRUE)
class(FALSE)
```

```
## [1] "logical"
## [1] "logical"
```

When you compare two values with an <a class='glossary' target='_blank' title='A symbol that performs a mathematical operation, such as +, -, *, /' href='https://psyteachr.github.io/glossary/o#operator'>operator</a>, such as checking to see if 10 is greater than 5, the resulting value is logical.


```r
is.logical(10 > 5)
```

```
## [1] TRUE
```

::: {.info data-latex=""}
You might also see logical values abbreviated as `T` and `F`, or `0` and `1`. This can cause some problems down the road, so we will always spell out the whole thing.
:::

### Factors

A <a class='glossary' target='_blank' title='A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter' href='https://psyteachr.github.io/glossary/f#factor'>factor</a> is a specific type of integer that lets you specify the categories and their order. This is useful in data tables to make plots display with categories in the correct order.


```r
myfactor <- factor("B", levels = c("A", "B","C"))
myfactor
```

```
## [1] B
## Levels: A B C
```

Factors are a type of integer, but you can tell that they are factors by checking their `class()`.


```r
typeof(myfactor)
class(myfactor)
```

```
## [1] "integer"
## [1] "factor"
```

### Dates and Times

Dates and times are represented by doubles with special classes. Dates and times are very hard to work with, but the <code class='package'><a href='https://lubridate.tidyverse.org/' target='_blank'>lubridate</a></code> package provides functions to help you with this.


```r
today <- lubridate::today()
now <- lubridate::now(tzone = "GMT")
```

Date and datetimes are a type of double, but you can tell that they are dates by checking their `class()`. Datetimes can have one or more of a few classes that start with `POSIX`.


```r
typeof(today)
typeof(now)
class(today)
class(now)
```

```
## [1] "double"
## [1] "double"
## [1] "Date"
## [1] "POSIXct" "POSIXt"
```

























































