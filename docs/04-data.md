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

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> id </th>
   <th style="text-align:left;"> group </th>
   <th style="text-align:right;"> pre </th>
   <th style="text-align:right;"> post </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> S01 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 98.46606 </td>
   <td style="text-align:right;"> 106.70508 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S02 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 104.39774 </td>
   <td style="text-align:right;"> 89.09030 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S03 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 105.13377 </td>
   <td style="text-align:right;"> 123.67230 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S04 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 92.42574 </td>
   <td style="text-align:right;"> 70.70178 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S05 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 123.53268 </td>
   <td style="text-align:right;"> 124.95526 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S06 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 97.48676 </td>
   <td style="text-align:right;"> 101.61697 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S07 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 87.75594 </td>
   <td style="text-align:right;"> 126.30077 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S08 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 77.15375 </td>
   <td style="text-align:right;"> 72.31229 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S09 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 97.00283 </td>
   <td style="text-align:right;"> 108.80713 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S10 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 102.32338 </td>
   <td style="text-align:right;"> 113.74732 </td>
  </tr>
</tbody>
</table>

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

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> id </th>
   <th style="text-align:left;"> group </th>
   <th style="text-align:right;"> pre </th>
   <th style="text-align:right;"> post </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> S01 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 98.46606 </td>
   <td style="text-align:right;"> 106.70508 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S02 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 104.39774 </td>
   <td style="text-align:right;"> 89.09030 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S03 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 105.13377 </td>
   <td style="text-align:right;"> 123.67230 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S04 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 92.42574 </td>
   <td style="text-align:right;"> 70.70178 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S05 </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 123.53268 </td>
   <td style="text-align:right;"> 124.95526 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S06 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 97.48676 </td>
   <td style="text-align:right;"> 101.61697 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S07 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 87.75594 </td>
   <td style="text-align:right;"> 126.30077 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S08 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 77.15375 </td>
   <td style="text-align:right;"> 72.31229 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S09 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 97.00283 </td>
   <td style="text-align:right;"> 108.80713 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S10 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 102.32338 </td>
   <td style="text-align:right;"> 113.74732 </td>
  </tr>
</tbody>
</table>

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
## Rows: 6 Columns: 5
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (2): character, date
## dbl (2): integer, double
## lgl (1): logical
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
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

url <- "https://docs.google.com/spreadsheets/d/16dkq0YL0J7fyAwT1pdgj1bNNrheckAU_2-DKuuM6aGI/"

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

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> character </th>
   <th style="text-align:right;"> integer </th>
   <th style="text-align:right;"> double </th>
   <th style="text-align:left;"> logical </th>
   <th style="text-align:left;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 05-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 04-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3.5 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 03-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> D </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4.5 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 02-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.5 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 01-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 31-Aug-21 </td>
  </tr>
</tbody>
</table>

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

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> bends </th>
   <th style="text-align:left;"> friendly </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Katara </td>
   <td style="text-align:left;"> water </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toph </td>
   <td style="text-align:left;"> earth </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sokka </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
</tbody>
</table>

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





::: {.try data-latex=""}
What data types are these:

* `100` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value='answer'>double</option><option value=''>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `100L` <select class='webex-select'><option value='blank'></option><option value='answer'>integer</option><option value=''>double</option><option value=''>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `"100"` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value='answer'>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `100.0` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value='answer'>double</option><option value=''>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `-100L` <select class='webex-select'><option value='blank'></option><option value='answer'>integer</option><option value=''>double</option><option value=''>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `factor(100)` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value=''>character</option><option value=''>logical</option><option value='answer'>factor</option></select>
* `TRUE` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value=''>character</option><option value='answer'>logical</option><option value=''>factor</option></select>
* `"TRUE"` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value='answer'>character</option><option value=''>logical</option><option value=''>factor</option></select>
* `FALSE` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value=''>character</option><option value='answer'>logical</option><option value=''>factor</option></select>
* `1 == 2` <select class='webex-select'><option value='blank'></option><option value=''>integer</option><option value=''>double</option><option value=''>character</option><option value='answer'>logical</option><option value=''>factor</option></select>

:::


## Basic container types {#containers}

Individual data values can be grouped together into containers. The main types of containers we'll work with are vectors, lists, and data tables.

### Vectors {#vectors}

A <a class='glossary' target='_blank' title='A type of data structure that collects values with the same data type, like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vector</a> in R is like a vector in mathematics: a set of ordered elements.  All of the elements in a vector must be of the same <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a> (<a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a>, <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a>, <a class='glossary' target='_blank' title='A data type representing TRUE or FALSE values.' href='https://psyteachr.github.io/glossary/l#logical'>logical</a>). You can create a vector by enclosing the elements in the function `c()`.


```r
## put information into a vector using c(...)
c(1, 2, 3, 4)
c("this", "is", "cool")
1:6 # shortcut to make a vector of all integers x:y
```

```
## [1] 1 2 3 4
## [1] "this" "is"   "cool"
## [1] 1 2 3 4 5 6
```

::: {.try data-latex=""}
What happens when you mix types? What class is the variable `mixed`?

```r
mixed <- c(2, "good", 2L, "b", TRUE)
```
:::

::: {.warning data-latex=""}
You can't mix data types in a vector; all elements of the vector must be the same data type. If you mix them, R will "coerce" them so that they are all the same. If you mix doubles and integers, the integers will be changed to doubles. If you mix characters and numeric types, the numbers will be <a class='glossary' target='_blank' title='Changing the data type of values in a vector to a single compatible type.' href='https://psyteachr.github.io/glossary/c#coercion'>coerced</a> to characters, so `10` would turn into "10".
:::

#### Selecting values from a vector

If we wanted to pick specific values out of a vector by position, we can use square brackets (an <a class='glossary' target='_blank' title='A symbol used to get values from a container object, such as [, [[, or $' href='https://psyteachr.github.io/glossary/e#extract-operator'>extract operator</a>, or `[]`) after the vector.


```r
values <- c(10, 20, 30, 40, 50)
values[2] # selects the second value
```

```
## [1] 20
```

You can select more than one value from the vector by putting a vector of numbers inside the square brackets. For example, you can select the 18th, 19th, 20th, 21st, 4th, 9th and 15th letter from the built-in vector `LETTERS` (which gives all the uppercase letters in the Latin alphabet).


```r
word <- c(18, 19, 20, 21, 4, 9, 15)
LETTERS[word]
```

```
## [1] "R" "S" "T" "U" "D" "I" "O"
```

::: {.try data-latex=""}

Can you decode the secret message?

```r
secret <- c(14, 5, 22, 5, 18, 7, 15, 14, 14, 1, 7, 9, 22, 5, 25, 15, 21, 21, 16)
```

:::

You can also create 'named' vectors, where each element has a name. For example:


```r
vec <- c(first = 77.9, second = -13.2, third = 100.1)
vec
```

```
##  first second  third 
##   77.9  -13.2  100.1
```

We can then access elements by name using a character vector within the square brackets. We can put them in any order we want, and we can repeat elements:


```r
vec[c("third", "second", "second")]
```

```
##  third second second 
##  100.1  -13.2  -13.2
```

::: {.info data-latex=""}
We can get the vector of names using the `names()` function, and we can set or change them using something like `names(vec2) <- c("n1", "n2", "n3")`.
:::

Another way to access elements is by using a logical vector within the square brackets. This will pull out the elements of the vector for which the corresponding element of the logical vector is `TRUE`. If the logical vector doesn't have the same length as the original, it will repeat. You can find out how long a vector is using the `length()` function.


```r
length(LETTERS)
LETTERS[c(TRUE, FALSE)]
```

```
## [1] 26
##  [1] "A" "C" "E" "G" "I" "K" "M" "O" "Q" "S" "U" "W" "Y"
```

#### Repeating Sequences {#rep_seq}

Here are some useful tricks to save typing when creating vectors.

In the command `x:y` the `:` operator would give you the sequence of number starting at `x`, and going to `y` in increments of 1. 


```r
1:10
15.3:20.5
0:-10
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
## [1] 15.3 16.3 17.3 18.3 19.3 20.3
##  [1]   0  -1  -2  -3  -4  -5  -6  -7  -8  -9 -10
```

What if you want to create a sequence but with something other than integer steps? You can use the `seq()` function. Look at the examples below and work out what the arguments do.


```r
seq(from = -1, to = 1, by = 0.2)
seq(0, 100, length.out = 11)
seq(0, 10, along.with = LETTERS)
```

```
##  [1] -1.0 -0.8 -0.6 -0.4 -0.2  0.0  0.2  0.4  0.6  0.8  1.0
##  [1]   0  10  20  30  40  50  60  70  80  90 100
##  [1]  0.0  0.4  0.8  1.2  1.6  2.0  2.4  2.8  3.2  3.6  4.0  4.4  4.8  5.2  5.6
## [16]  6.0  6.4  6.8  7.2  7.6  8.0  8.4  8.8  9.2  9.6 10.0
```

What if you want to repeat a vector many times? You could either type it out (painful) or use the `rep()` function, which can repeat vectors in different ways.


```r
rep(0, 10)                      # ten zeroes
rep(c(1L, 3L), times = 7)       # alternating 1 and 3, 7 times
rep(c("A", "B", "C"), each = 2) # A to C, 2 times each
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0
##  [1] 1 3 1 3 1 3 1 3 1 3 1 3 1 3
## [1] "A" "A" "B" "B" "C" "C"
```

The `rep()` function is useful to create a vector of logical values (`TRUE`/`FALSE` or `1`/`0`) to select values from another vector.


```r
# Get subject IDs in the pattern Y Y N N ...
subject_ids <- 1:40
yynn <- rep(c(TRUE, FALSE), each = 2, 
            length.out = length(subject_ids))
subject_ids[yynn]
```

```
##  [1]  1  2  5  6  9 10 13 14 17 18 21 22 25 26 29 30 33 34 37 38
```


#### Vectorized Operations {#vectorized_ops}

R performs calculations on vectors in a special way. Let's look at an example using $z$-scores.  A $z$-score is a <a class='glossary' target='_blank' title='A score minus the mean' href='https://psyteachr.github.io/glossary/d#deviation-score'>deviation score</a>(a score minus a mean) divided by a standard deviation. Let's say we have a set of four IQ scores.


```r
## example IQ scores: mu = 100, sigma = 15
iq <- c(86, 101, 127, 99)
```

If we want to subtract the mean from these four scores, we just use the following code:


```r
iq - 100
```

```
## [1] -14   1  27  -1
```

This subtracts 100 from each element of the vector. R automatically assumes that this is what you wanted to do; it is called a <a class='glossary' target='_blank' title='An operator or function that acts on each element in a vector' href='https://psyteachr.github.io/glossary/v#vectorized'>vectorized</a> operation and it makes it possible to express operations more efficiently.

To calculate $z$-scores we use the formula:

$z = \frac{X - \mu}{\sigma}$

where X are the scores, $\mu$ is the mean, and $\sigma$ is the standard deviation. We can expression this formula in R as follows:


```r
## z-scores
(iq - 100) / 15
```

```
## [1] -0.93333333  0.06666667  1.80000000 -0.06666667
```

You can see that it computed all four $z$-scores with a single line of code. In later chapters, we'll use vectorised operations to process our data, such as reverse-scoring some questionnaire items.


### Lists

Recall that vectors can contain data of only one type. What if you want to store a collection of data of different data types? For that purpose you would use a <a class='glossary' target='_blank' title='A container data type that allows items with different data types to be grouped together.' href='https://psyteachr.github.io/glossary/l#list'>list</a>. Define a list using the `list()` function.


```r
data_types <- list(
  double = 10.0,
  integer = 10L,
  character = "10",
  logical = TRUE
)

str(data_types) # str() prints lists in a condensed format
```

```
## List of 4
##  $ double   : num 10
##  $ integer  : int 10
##  $ character: chr "10"
##  $ logical  : logi TRUE
```

You can refer to elements of a list using square brackets like a vector, but you can also use the dollar sign notation (`$`) if the list items have names.


```r
data_types$logical
```

```
## [1] TRUE
```

::: {.try data-latex=""}

Explore the 5 ways shown below to extract a value from a list. What data type is each object? What is the difference between the single and double brackets? Which one is the same as the dollar sign?


```r
bracket1 <- data_types[1]
bracket2 <- data_types[[1]]
name1    <- data_types["double"]
name2    <- data_types[["double"]]
dollar   <- data_types$double
```

:::

### Tables {#tables-data}

The built-in, imported, and created data above are <a class='glossary' target='_blank' title='Data in a rectangular table format, where each row has an entry for each column.' href='https://psyteachr.github.io/glossary/t#tabular-data'>tabular data</a>, data arranged in the form of a table.

Tabular data structures allow for a collection of data of different types (characters, integers, logical, etc.) but subject to the constraint that each "column" of the table (element of the list) must have the same number of elements. The base R version of a table is called a `data.frame`, while the 'tidyverse' version is called a `tibble`.  Tibbles are far easier to work with, so we'll be using those. To learn more about differences between these two data structures, see `vignette("tibble")`.

Tabular data becomes especially important for when we talk about <a class='glossary' target='_blank' title='A format for data that maps the meaning onto the structure.' href='https://psyteachr.github.io/glossary/t#tidy-data'>tidy data</a> in [chapter 4](#tidyr), which consists of a set of simple principles for structuring data.

#### Creating a table

We learned how to create a table by importing a Excel or CSV file, and creating a table from scratch using the `tibble()` function. You can also use the `tibble::tribble()` function to create a table by row, rather than by column. You start by listing the column names, each preceded by a tilde (`~`), then you list the values for each column, row by row, separated by commas (don't forget a comma at the end of each row). This method can be easier for some data, but doesn't let you use shortcuts, like setting all of the values in a column to the same value or a [repeating sequence](#rep_seq).


```r
# by column using tibble
avatar_by_col <- tibble(
  name = c("Katara", "Toph", "Sokka", "Azula"),
  bends = c("water", "earth", NA, "fire"),
  friendly = rep(c(TRUE, FALSE), c(3, 1))
)

# by row using tribble
avatar_by_row <- tribble(
  ~name,    ~bends, ~friendly,
  "Katara", "water",       TRUE,
  "Toph",   "earth",       TRUE,
  "Sokka",  NA,            TRUE,
  "Azula",  "fire",        FALSE
)
```

#### Table info

We can get information about the table using the functions `ncol()` (number of columns), `nrow()` (number of rows), `dim()` (the number of rows and number of columns), and `name()` (the column names).


```r
nrow(avatar) # how many rows?
ncol(avatar) # how many columns?
dim(avatar)  # what are the table dimensions?
names(avatar) # what are the column names?
```

```
## [1] 3
## [1] 3
## [1] 3 3
## [1] "name"     "bends"    "friendly"
```

#### Accessing rows and columns {#row-col-access}

There are various ways of accessing specific columns or rows from a table. The ones below are from <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> and are useful to know about, but you'll be learning easier (and more readable) ways in Chapter\ \@ref(tidyr) and Chapter\ \@ref(dplyr). Examples of these base R accessing functions are provided here for reference, since you might see them in other people's scripts.


```r
katara     <- avatar[1, ] # first row
type       <- avatar[, 2] # second column (bends)
benders    <- avatar[c(1, 2), ] # selected rows (by number)
bends_name <- avatar[, c("bends", "name")] # selected columns (by name)
friendly   <- avatar$friendly  # by column name
```

## Troubleshooting

What if you import some data and it guesses the wrong column type? The most common reason is that a numeric column has some non-numbers in it somewhere. Maybe someone wrote a note in an otherwise numeric column. Columns have to be all one data type, so if there are any characters, the whole column is converted to character strings, and numbers like <code><span class='fl'>1.2</span></code> get represented as <code><span class='st'>"1.2"</span></code>, which will cause very weird errors like `"100" < "9" == TRUE`. You can catch this by using <code><span class='fu'>glimpse</span><span class='op'>(</span><span class='op'>)</span></code> to check your data.

The data directory you created with `reprores::getdata()` contains a file called "mess.csv". Let's try loading this dataset.


```r
# lazy = FALSE loads the data right away so you can see error messages
# this default changed in late 2021 and might change back soon
mess <- read_csv("data/mess.csv", lazy = FALSE)
```

```
## Warning: One or more parsing issues, see `problems()` for details
```

```
## Rows: 27 Columns: 1
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): This is my messy dataset
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

You'll get a warning with many parsing errors and the data table is just a single column. View the file `data/mess.csv` by clicking on it in the File pane, and choosing "View File". Here are the first 10 lines. What went wrong?

```
This is my messy dataset

junk,order,score,letter,good,min_max,date
junk,1,-1,a,1,1 - 2,2020-01-1

junk,missing,0.72,b,1,2 - 3,2020-01-2

junk,3,-0.62,c,FALSE,3 - 4,2020-01-3

junk,4,2.03,d,T,4 - 5,2020-01-4
```

First, the file starts with a note: "This is my messy dataset". We want to skip the first two lines. You can do this with the argument `skip` in `read_csv()`.


```r
mess <- read_csv("data/mess.csv", 
                 skip = 2, 
                 lazy = FALSE)
```

```
## Rows: 26 Columns: 7
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (6): junk, order, letter, good, min_max, date
## dbl (1): score
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
glimpse(mess)
```

```
## Rows: 26
## Columns: 7
## $ junk    <chr> "junk", "junk", "junk", "junk", "junk", "junk", "junk", "junk"…
## $ order   <chr> "1", "missing", "3", "4", "5", "6", "7", "8", "9", "10", "11",…
## $ score   <dbl> -1.00, 0.72, -0.62, 2.03, NA, 0.99, 0.03, 0.67, 0.57, 0.90, -1…
## $ letter  <chr> "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m…
## $ good    <chr> "1", "1", "FALSE", "T", "1", "0", "T", "TRUE", "1", "T", "F", …
## $ min_max <chr> "1 - 2", "2 - 3", "3 - 4", "4 - 5", "5 - 6", "6 - 7", "7 - 8",…
## $ date    <chr> "2020-01-1", "2020-01-2", "2020-01-3", "2020-01-4", "2020-01-5…
```

OK, that's a little better, but this table is still a serious mess in several ways:

* `junk` is a column that we don't need
* `order` should be an integer column
* `good` should be a logical column
* `good` uses all kinds of different ways to record TRUE and FALSE values
* `min_max` contains two pieces of numeric information, but is a character column
* `date` should be a date column

We'll learn how to deal with this mess in Chapters\ \@ref(tidyr) and \@ref(dplyr), but we can fix a few things by setting the `col_types` argument in <code><span class='fu'>read_csv</span><span class='op'>(</span><span class='op'>)</span></code> to specify the column types for our two columns that were guessed wrong and skip the "junk" column. The argument `col_types` takes a list where the name of each item in the list is a column name and the value is from the table below. You can use the function, like <code><span class='fu'>col_double</span><span class='op'>(</span><span class='op'>)</span></code> or the abbreviation, like <code><span class='st'>"l"</span></code>. Omitted column names are guessed.

| function | |abbreviation | type |
|:---------|:--------------|:-----|
| col_logical()   | l | logical values |
| col_integer()   | i | integer values |
| col_double()    | d | numeric values |
| col_character() | c | strings |
| col_factor(levels, ordered) | f | a fixed set of values |
| col_date(format = "")     | D | with the locale's date_format |
| col_time(format = "")     | t | with the locale's time_format |
| col_datetime(format = "") | T | ISO8601 date time |
| col_number()    | n | numbers containing the grouping_mark |
| col_skip()      | _, - | don't import this column |
| col_guess()     | ? | parse using the "best" type based on the input |


```r
# omitted values are guessed
# ?col_date for format options
ct <- list(
  junk = "-", # skip this column
  order = "i",
  good = "l",
  date = col_date(format = "%Y-%m-%d")
)

tidier <- read_csv("data/mess.csv", 
                   skip = 2,
                   col_types = ct, 
                   lazy = FALSE)
```

```
## Warning: One or more parsing issues, see `problems()` for details
```

```r
problems()
```

You will get a message about parsing issues when you run this that tells you to run the `problems()` function to see a table of the problems. Warnings look scary at first, but always start by reading the message. The table tells you what row (`3`) and column (`2`) the error was found in, what kind of data was expected (`an integer`), and what the actual value was (`missing`). If you specifically tell `read_csv()` to import a column as an integer, any characters in the column will produce a warning like this and then be recorded as `NA`. You can manually set what the missing values were recorded as with the `na` argument.


```r
tidiest <- read_csv("data/mess.csv", 
                   skip = 2,
                   na = "missing",
                   col_types = ct,
                   lazy = FALSE)
```

Now `order` is an integer where "missing" is now `NA`, `good` is a logical value, where <code><span class='fl'>0</span></code> and <code><span class='cn'>F</span></code> are converted to <code><span class='cn'>FALSE</span></code> and <code><span class='fl'>1</span></code> and <code><span class='cn'>T</span></code> are converted to <code><span class='cn'>TRUE</span></code>, and `date` is a date type (adding leading zeros to the day). We'll learn in later chapters how to fix other problems, such as the `min_max` column containing two different types of data.


```r
tidiest
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> order </th>
   <th style="text-align:left;"> score </th>
   <th style="text-align:left;"> letter </th>
   <th style="text-align:left;"> good </th>
   <th style="text-align:left;"> min_max </th>
   <th style="text-align:left;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> -1 </td>
   <td style="text-align:left;"> a </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 1 - 2 </td>
   <td style="text-align:left;"> 2020-01-01 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 0.72 </td>
   <td style="text-align:left;"> b </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 2 - 3 </td>
   <td style="text-align:left;"> 2020-01-02 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> -0.62 </td>
   <td style="text-align:left;"> c </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 3 - 4 </td>
   <td style="text-align:left;"> 2020-01-03 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 2.03 </td>
   <td style="text-align:left;"> d </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 4 - 5 </td>
   <td style="text-align:left;"> 2020-01-04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> e </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 5 - 6 </td>
   <td style="text-align:left;"> 2020-01-05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> 0.99 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 6 - 7 </td>
   <td style="text-align:left;"> 2020-01-06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> 0.03 </td>
   <td style="text-align:left;"> g </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 7 - 8 </td>
   <td style="text-align:left;"> 2020-01-07 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> 0.67 </td>
   <td style="text-align:left;"> h </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 8 - 9 </td>
   <td style="text-align:left;"> 2020-01-08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> 0.57 </td>
   <td style="text-align:left;"> i </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 9 - 10 </td>
   <td style="text-align:left;"> 2020-01-09 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> 0.9 </td>
   <td style="text-align:left;"> j </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 10 - 11 </td>
   <td style="text-align:left;"> 2020-01-10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> -1.55 </td>
   <td style="text-align:left;"> k </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 11 - 12 </td>
   <td style="text-align:left;"> 2020-01-11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> l </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 12 - 13 </td>
   <td style="text-align:left;"> 2020-01-12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> 0.15 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 13 - 14 </td>
   <td style="text-align:left;"> 2020-01-13 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> -0.66 </td>
   <td style="text-align:left;"> n </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 14 - 15 </td>
   <td style="text-align:left;"> 2020-01-14 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> -0.99 </td>
   <td style="text-align:left;"> o </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 15 - 16 </td>
   <td style="text-align:left;"> 2020-01-15 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> 1.97 </td>
   <td style="text-align:left;"> p </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 16 - 17 </td>
   <td style="text-align:left;"> 2020-01-16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> -0.44 </td>
   <td style="text-align:left;"> q </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 17 - 18 </td>
   <td style="text-align:left;"> 2020-01-17 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> -0.9 </td>
   <td style="text-align:left;"> r </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 18 - 19 </td>
   <td style="text-align:left;"> 2020-01-18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> -0.15 </td>
   <td style="text-align:left;"> s </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 19 - 20 </td>
   <td style="text-align:left;"> 2020-01-19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> -0.83 </td>
   <td style="text-align:left;"> t </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 20 - 21 </td>
   <td style="text-align:left;"> 2020-01-20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> 1.99 </td>
   <td style="text-align:left;"> u </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 21 - 22 </td>
   <td style="text-align:left;"> 2020-01-21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 0.04 </td>
   <td style="text-align:left;"> v </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 22 - 23 </td>
   <td style="text-align:left;"> 2020-01-22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> -0.4 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 23 - 24 </td>
   <td style="text-align:left;"> 2020-01-23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> -0.47 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 24 - 25 </td>
   <td style="text-align:left;"> 2020-01-24 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> -0.41 </td>
   <td style="text-align:left;"> y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 25 - 26 </td>
   <td style="text-align:left;"> 2020-01-25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> 0.68 </td>
   <td style="text-align:left;"> z </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 26 - 27 </td>
   <td style="text-align:left;"> 2020-01-26 </td>
  </tr>
</tbody>
</table>

</div>


## Glossary {#glossary-data}

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [base r](https://psyteachr.github.io/glossary/b.html#base-r){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The set of R functions that come with a basic installation of R, before you add external packages </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [character](https://psyteachr.github.io/glossary/c.html#character){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing strings of text. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [coercion](https://psyteachr.github.io/glossary/c.html#coercion){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Changing the data type of values in a vector to a single compatible type. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [csv](https://psyteachr.github.io/glossary/c.html#csv){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Comma-separated variable: a file type for representing data where each variable is separated from the next by a comma. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [data type](https://psyteachr.github.io/glossary/d.html#data-type){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The kind of data represented by an object. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [deviation score](https://psyteachr.github.io/glossary/d.html#deviation-score){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A score minus the mean </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [double](https://psyteachr.github.io/glossary/d.html#double){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing a real decimal number </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [escape](https://psyteachr.github.io/glossary/e.html#escape){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Include special characters like " inside of a string by prefacing them with a backslash. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [extension](https://psyteachr.github.io/glossary/e.html#extension){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd). </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [extract operator](https://psyteachr.github.io/glossary/e.html#extract-operator){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A symbol used to get values from a container object, such as [, [[, or $ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [factor](https://psyteachr.github.io/glossary/f.html#factor){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [global environment](https://psyteachr.github.io/glossary/g.html#global-environment){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The interactive workspace where your script runs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [integer](https://psyteachr.github.io/glossary/i.html#integer){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing whole numbers. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [list](https://psyteachr.github.io/glossary/l.html#list){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A container data type that allows items with different data types to be grouped together. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [logical](https://psyteachr.github.io/glossary/l.html#logical){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing TRUE or FALSE values. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [numeric](https://psyteachr.github.io/glossary/n.html#numeric){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing a real decimal number or integer. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [object](https://psyteachr.github.io/glossary/o.html#object){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A word that identifies and stores the value of some data for later use. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [operator](https://psyteachr.github.io/glossary/o.html#operator){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A symbol that performs a mathematical operation, such as +, -, *, / </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [panes](https://psyteachr.github.io/glossary/p.html#panes){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> RStudio is arranged with four window "panes". </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [tabular data](https://psyteachr.github.io/glossary/t.html#tabular-data){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Data in a rectangular table format, where each row has an entry for each column. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [tidy data](https://psyteachr.github.io/glossary/t.html#tidy-data){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A format for data that maps the meaning onto the structure. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [tidyverse](https://psyteachr.github.io/glossary/t.html#tidyverse){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A set of R packages that help you create and work with tidy data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [vector](https://psyteachr.github.io/glossary/v.html#vector){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A type of data structure that collects values with the same data type, like T/F values, numbers, or strings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [vectorized](https://psyteachr.github.io/glossary/v.html#vectorized){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> An operator or function that acts on each element in a vector </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-data}

* [Chapter 11: Data Import](http://r4ds.had.co.nz/data-import.html) in *R for Data Science*
* [RStudio Data Import Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf)
