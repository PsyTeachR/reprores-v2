# Data Wrangling {#dplyr}

<div class="right meme"><img src="images/memes/real_world_data.jpg"
     alt="A cute golden retriever labelled 'iris & mtcars' and a scary werewolf labelled 'Real world data'" /></div>

## Learning Objectives {#ilo-dplyr}

### Basic {-}

1. Be able to use the 6 main dplyr one-table verbs: [(video)](https://youtu.be/l12tNKClTR0){class="video"}
    + [`select()`](#select)
    + [`filter()`](#filter)
    + [`arrange()`](#arrange)
    + [`mutate()`](#mutate)
    + [`summarise()`](#summarise)
    + [`group_by()`](#group_by)
2. Be able to [wrangle data by chaining tidyr and dplyr functions](#all-together) [(video)](https://youtu.be/hzFFAkwrkqA){class="video"} 
3. Be able to use these additional one-table verbs: [(video)](https://youtu.be/GmfF162mq4g){class="video"}
    + [`rename()`](#rename)
    + [`distinct()`](#distinct)
    + [`count()`](#count)
    + [`slice()`](#slice)
    + [`pull()`](#pull)

### Intermediate {-}

4. Fine control of [`select()` operations](#select_helpers) [(video)](https://youtu.be/R1bi1QwF9t0){class="video"}
5. Use [window functions](#window) [(video)](https://youtu.be/uo4b0W9mqPc){class="video"}



## Setup {#setup-dplyr}


```r
# libraries needed for these examples
library(tidyverse)
library(lubridate)
library(reprores)
set.seed(8675309) # makes sure random numbers are reproducible
```


### The `disgust` dataset {#data-disgust}

These examples will use data from `reprores::disgust`, which contains data from the [Three Domain Disgust Scale](http://digitalrepository.unm.edu/cgi/viewcontent.cgi?article=1139&context=psy_etds). Each participant is identified by a unique `user_id` and each questionnaire completion has a unique `id`. Look at the Help for this dataset to see the individual questions.


```r
data("disgust", package = "reprores")

#disgust <- read_csv("https://psyteachr.github.io/reprores/data/disgust.csv")
```


## Six main dplyr verbs

Most of the <a class='glossary' target='_blank' title='The process of preparing data for visualisation and statistical analysis.' href='https://psyteachr.github.io/glossary/d#data-wrangling'>data wrangling</a> you'll want to do with psychological data will involve the `tidyr` functions you learned in [Chapter 4](#tidyr) and the six main `dplyr` verbs: `select`, `filter`, `arrange`, `mutate`, `summarise`, and `group_by`.

### select() {#select}

Select columns by name or number.

You can select each column individually, separated by commas (e.g., `col1, col2`). You can also select all columns between two columns by separating them with a colon (e.g., `start_col:end_col`).


```r
moral <- disgust %>% select(user_id, moral1:moral7)
names(moral)
```

```
## [1] "user_id" "moral1"  "moral2"  "moral3"  "moral4"  "moral5"  "moral6" 
## [8] "moral7"
```

You can select columns by number, which is useful when the column names are long or complicated.


```r
sexual <- disgust %>% select(2, 11:17)
names(sexual)
```

```
## [1] "user_id" "sexual1" "sexual2" "sexual3" "sexual4" "sexual5" "sexual6"
## [8] "sexual7"
```

You can use a minus symbol to unselect columns, leaving all of the other columns. If you want to exclude a span of columns, put parentheses around the span first (e.g., `-(moral1:moral7)`, not `-moral1:moral7`).


```r
pathogen <- disgust %>% select(-id, -date, -(moral1:sexual7))
names(pathogen)
```

```
## [1] "user_id"   "pathogen1" "pathogen2" "pathogen3" "pathogen4" "pathogen5"
## [7] "pathogen6" "pathogen7"
```

#### Select helpers {#select_helpers}

You can select columns based on criteria about the column names.

##### `starts_with()` {#starts_with}

Select columns that start with a character string.


```r
u <- disgust %>% select(starts_with("u"))
names(u)
```

```
## [1] "user_id"
```

##### `ends_with()` {#ends_with}

Select columns that end with a character string.


```r
firstq <- disgust %>% select(ends_with("1"))
names(firstq)
```

```
## [1] "moral1"    "sexual1"   "pathogen1"
```

##### `contains()` {#contains}

Select columns that contain a character string.


```r
pathogen <- disgust %>% select(contains("pathogen"))
names(pathogen)
```

```
## [1] "pathogen1" "pathogen2" "pathogen3" "pathogen4" "pathogen5" "pathogen6"
## [7] "pathogen7"
```

##### `num_range()` {#num_range}

Select columns with a name that matches the pattern `prefix`.


```r
moral2_4 <- disgust %>% select(num_range("moral", 2:4))
names(moral2_4)
```

```
## [1] "moral2" "moral3" "moral4"
```

::: {.info data-latex=""}
Use `width` to set the number of digits with leading
zeros. For example, `num_range('var_', 8:10, width=2)` selects columns `var_08`, `var_09`, and `var_10`.
:::

### filter() {#filter}

Select rows by matching column criteria.

Select all rows where the user_id is 1 (that's Lisa). 


```r
disgust %>% filter(user_id == 1)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral1 </th>
   <th style="text-align:right;"> moral2 </th>
   <th style="text-align:right;"> moral3 </th>
   <th style="text-align:right;"> moral4 </th>
   <th style="text-align:right;"> moral5 </th>
   <th style="text-align:right;"> moral6 </th>
   <th style="text-align:right;"> moral7 </th>
   <th style="text-align:right;"> sexual1 </th>
   <th style="text-align:right;"> sexual2 </th>
   <th style="text-align:right;"> sexual3 </th>
   <th style="text-align:right;"> sexual4 </th>
   <th style="text-align:right;"> sexual5 </th>
   <th style="text-align:right;"> sexual6 </th>
   <th style="text-align:right;"> sexual7 </th>
   <th style="text-align:right;"> pathogen1 </th>
   <th style="text-align:right;"> pathogen2 </th>
   <th style="text-align:right;"> pathogen3 </th>
   <th style="text-align:right;"> pathogen4 </th>
   <th style="text-align:right;"> pathogen5 </th>
   <th style="text-align:right;"> pathogen6 </th>
   <th style="text-align:right;"> pathogen7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
Remember to use `==` and not `=` to check if two things are equivalent. A single `=` assigns the righthand value to the lefthand variable and (usually) evaluates to `TRUE`.
:::

You can select on multiple criteria by separating them with commas.


```r
amoral <- disgust %>% filter(
  moral1 == 0, 
  moral2 == 0,
  moral3 == 0, 
  moral4 == 0,
  moral5 == 0,
  moral6 == 0,
  moral7 == 0
)
```

You can use the symbols `&`, `|`, and `!` to mean "and", "or", and "not". You can also use other operators to make equations.


```r
# everyone who chose either 0 or 7 for question moral1
moral_extremes <- disgust %>% 
  filter(moral1 == 0 | moral1 == 7)

# everyone who chose the same answer for all moral questions
moral_consistent <- disgust %>% 
  filter(
    moral2 == moral1 & 
    moral3 == moral1 & 
    moral4 == moral1 &
    moral5 == moral1 &
    moral6 == moral1 &
    moral7 == moral1
  )

# everyone who did not answer 7 for all 7 moral questions
moral_no_ceiling <- disgust %>%
  filter(moral1+moral2+moral3+moral4+moral5+moral6+moral7 != 7*7)
```

#### Match operator (%in%) {#match-operator}

Sometimes you need to exclude some participant IDs for reasons that can't be described in code. The match operator (`%in%`) is useful here for testing if a column value is in a list. Surround the equation with parentheses and put `!` in front to test that a value is not in the list.


```r
no_researchers <- disgust %>%
  filter(!(user_id %in% c(1,2)))
```


#### Dates {#dates}

You can use the `lubridate` package to work with dates. For example, you can use the `year()` function to return just the year from the `date` column and then select only data collected in 2010.


```r
disgust2010 <- disgust %>%
  filter(year(date) == 2010)
```

<table>
<caption>(\#tab:dates-year)Rows 1-6 from `disgust2010`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral1 </th>
   <th style="text-align:right;"> moral2 </th>
   <th style="text-align:right;"> moral3 </th>
   <th style="text-align:right;"> moral4 </th>
   <th style="text-align:right;"> moral5 </th>
   <th style="text-align:right;"> moral6 </th>
   <th style="text-align:right;"> moral7 </th>
   <th style="text-align:right;"> sexual1 </th>
   <th style="text-align:right;"> sexual2 </th>
   <th style="text-align:right;"> sexual3 </th>
   <th style="text-align:right;"> sexual4 </th>
   <th style="text-align:right;"> sexual5 </th>
   <th style="text-align:right;"> sexual6 </th>
   <th style="text-align:right;"> sexual7 </th>
   <th style="text-align:right;"> pathogen1 </th>
   <th style="text-align:right;"> pathogen2 </th>
   <th style="text-align:right;"> pathogen3 </th>
   <th style="text-align:right;"> pathogen4 </th>
   <th style="text-align:right;"> pathogen5 </th>
   <th style="text-align:right;"> pathogen6 </th>
   <th style="text-align:right;"> pathogen7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 6902 </td>
   <td style="text-align:right;"> 5469 </td>
   <td style="text-align:left;"> 2010-12-06 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6158 </td>
   <td style="text-align:right;"> 6066 </td>
   <td style="text-align:left;"> 2010-04-18 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6362 </td>
   <td style="text-align:right;"> 7129 </td>
   <td style="text-align:left;"> 2010-06-09 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6302 </td>
   <td style="text-align:right;"> 39318 </td>
   <td style="text-align:left;"> 2010-05-20 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5429 </td>
   <td style="text-align:right;"> 43029 </td>
   <td style="text-align:left;"> 2010-01-02 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6732 </td>
   <td style="text-align:right;"> 71955 </td>
   <td style="text-align:left;"> 2010-10-15 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>




Or select data from at least 5 years ago. You can use the `range` function to check the minimum and maximum dates in the resulting dataset.


```r
disgust_5ago <- disgust %>%
  filter(date < today() - dyears(5))

range(disgust_5ago$date)
```

```
## [1] "2008-07-10" "2017-04-04"
```


### arrange() {#arrange}

Sort your dataset using `arrange()`. You will find yourself needing to sort data in R much less than you do in Excel, since you don't need to have rows next to each other in order to, for example, calculate group means. But `arrange()` can be useful when preparing data from display in tables.


```r
disgust_order <- disgust %>%
  arrange(date, moral1)
```

<table>
<caption>(\#tab:arrange)Rows 1-6 from `disgust_order`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral1 </th>
   <th style="text-align:right;"> moral2 </th>
   <th style="text-align:right;"> moral3 </th>
   <th style="text-align:right;"> moral4 </th>
   <th style="text-align:right;"> moral5 </th>
   <th style="text-align:right;"> moral6 </th>
   <th style="text-align:right;"> moral7 </th>
   <th style="text-align:right;"> sexual1 </th>
   <th style="text-align:right;"> sexual2 </th>
   <th style="text-align:right;"> sexual3 </th>
   <th style="text-align:right;"> sexual4 </th>
   <th style="text-align:right;"> sexual5 </th>
   <th style="text-align:right;"> sexual6 </th>
   <th style="text-align:right;"> sexual7 </th>
   <th style="text-align:right;"> pathogen1 </th>
   <th style="text-align:right;"> pathogen2 </th>
   <th style="text-align:right;"> pathogen3 </th>
   <th style="text-align:right;"> pathogen4 </th>
   <th style="text-align:right;"> pathogen5 </th>
   <th style="text-align:right;"> pathogen6 </th>
   <th style="text-align:right;"> pathogen7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 155324 </td>
   <td style="text-align:left;"> 2008-07-11 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 155386 </td>
   <td style="text-align:left;"> 2008-07-12 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 155409 </td>
   <td style="text-align:left;"> 2008-07-12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 155366 </td>
   <td style="text-align:left;"> 2008-07-12 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 155370 </td>
   <td style="text-align:left;"> 2008-07-12 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
</tbody>
</table>



Reverse the order using `desc()`


```r
disgust_order_desc <- disgust %>%
  arrange(desc(date))
```

<table>
<caption>(\#tab:arrange-desc)Rows 1-6 from `disgust_order_desc`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral1 </th>
   <th style="text-align:right;"> moral2 </th>
   <th style="text-align:right;"> moral3 </th>
   <th style="text-align:right;"> moral4 </th>
   <th style="text-align:right;"> moral5 </th>
   <th style="text-align:right;"> moral6 </th>
   <th style="text-align:right;"> moral7 </th>
   <th style="text-align:right;"> sexual1 </th>
   <th style="text-align:right;"> sexual2 </th>
   <th style="text-align:right;"> sexual3 </th>
   <th style="text-align:right;"> sexual4 </th>
   <th style="text-align:right;"> sexual5 </th>
   <th style="text-align:right;"> sexual6 </th>
   <th style="text-align:right;"> sexual7 </th>
   <th style="text-align:right;"> pathogen1 </th>
   <th style="text-align:right;"> pathogen2 </th>
   <th style="text-align:right;"> pathogen3 </th>
   <th style="text-align:right;"> pathogen4 </th>
   <th style="text-align:right;"> pathogen5 </th>
   <th style="text-align:right;"> pathogen6 </th>
   <th style="text-align:right;"> pathogen7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 39456 </td>
   <td style="text-align:right;"> 356866 </td>
   <td style="text-align:left;"> 2017-08-21 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39447 </td>
   <td style="text-align:right;"> 128727 </td>
   <td style="text-align:left;"> 2017-08-13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39371 </td>
   <td style="text-align:right;"> 152955 </td>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39342 </td>
   <td style="text-align:right;"> 48303 </td>
   <td style="text-align:left;"> 2017-05-22 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39159 </td>
   <td style="text-align:right;"> 151633 </td>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 38942 </td>
   <td style="text-align:right;"> 370464 </td>
   <td style="text-align:left;"> 2017-02-01 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>




### mutate() {#mutate}

Add new columns. This is one of the most useful functions in the tidyverse.

Refer to other columns by their names (unquoted). You can add more than one column in the same mutate function, just separate the columns with a comma. Once you make a new column, you can use it in further column definitions e.g., `total` below).


```r
disgust_total <- disgust %>%
  mutate(
    pathogen = pathogen1 + pathogen2 + pathogen3 + pathogen4 + pathogen5 + pathogen6 + pathogen7,
    moral = moral1 + moral2 + moral3 + moral4 + moral5 + moral6 + moral7,
    sexual = sexual1 + sexual2 + sexual3 + sexual4 + sexual5 + sexual6 + sexual7,
    total = pathogen + moral + sexual,
    user_id = paste0("U", user_id)
  )
```

<table>
<caption>(\#tab:mutate)Rows 1-6 from `disgust_total`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral1 </th>
   <th style="text-align:right;"> moral2 </th>
   <th style="text-align:right;"> moral3 </th>
   <th style="text-align:right;"> moral4 </th>
   <th style="text-align:right;"> moral5 </th>
   <th style="text-align:right;"> moral6 </th>
   <th style="text-align:right;"> moral7 </th>
   <th style="text-align:right;"> sexual1 </th>
   <th style="text-align:right;"> sexual2 </th>
   <th style="text-align:right;"> sexual3 </th>
   <th style="text-align:right;"> sexual4 </th>
   <th style="text-align:right;"> sexual5 </th>
   <th style="text-align:right;"> sexual6 </th>
   <th style="text-align:right;"> sexual7 </th>
   <th style="text-align:right;"> pathogen1 </th>
   <th style="text-align:right;"> pathogen2 </th>
   <th style="text-align:right;"> pathogen3 </th>
   <th style="text-align:right;"> pathogen4 </th>
   <th style="text-align:right;"> pathogen5 </th>
   <th style="text-align:right;"> pathogen6 </th>
   <th style="text-align:right;"> pathogen7 </th>
   <th style="text-align:right;"> pathogen </th>
   <th style="text-align:right;"> moral </th>
   <th style="text-align:right;"> sexual </th>
   <th style="text-align:right;"> total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1199 </td>
   <td style="text-align:left;"> U0 </td>
   <td style="text-align:left;"> 2008-10-07 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 85 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> U1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 41 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1599 </td>
   <td style="text-align:left;"> U2 </td>
   <td style="text-align:left;"> 2008-10-27 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13332 </td>
   <td style="text-align:left;"> U2118 </td>
   <td style="text-align:left;"> 2012-01-02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 63 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> U2311 </td>
   <td style="text-align:left;"> 2008-07-15 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 71 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1160 </td>
   <td style="text-align:left;"> U3630 </td>
   <td style="text-align:left;"> 2008-10-06 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>



::: {.warning data-latex=""}
You can overwrite a column by giving a new column the same name as the old column (see `user_id`) above. Make sure that you mean to do this and that you aren't trying to use the old column value after you redefine it.
:::


### summarise() {#summarise}

Create summary statistics for the dataset. Check the [Data Wrangling Cheat Sheet](https://www.rstudio.org/links/data_wrangling_cheat_sheet) or the [Data Transformation Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-transformation-cheatsheet.pdf) for various summary functions. Some common ones are: `mean()`, `sd()`, `n()`, `sum()`, and `quantile()`.


```r
disgust_summary<- disgust_total %>%
  summarise(
    n = n(),
    q25 = quantile(total, .25, na.rm = TRUE),
    q50 = quantile(total, .50, na.rm = TRUE),
    q75 = quantile(total, .75, na.rm = TRUE),
    avg_total = mean(total, na.rm = TRUE),
    sd_total  = sd(total, na.rm = TRUE),
    min_total = min(total, na.rm = TRUE),
    max_total = max(total, na.rm = TRUE)
  )
```

<table>
<caption>(\#tab:summarise)All rows from `disgust_summary`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> q25 </th>
   <th style="text-align:right;"> q50 </th>
   <th style="text-align:right;"> q75 </th>
   <th style="text-align:right;"> avg_total </th>
   <th style="text-align:right;"> sd_total </th>
   <th style="text-align:right;"> min_total </th>
   <th style="text-align:right;"> max_total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 20000 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 70.6868 </td>
   <td style="text-align:right;"> 18.24253 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
</tbody>
</table>




### group_by() {#group_by}

Create subsets of the data. You can use this to create summaries, 
like the mean value for all of your experimental groups.

Here, we'll use `mutate` to create a new column called `year`, group by `year`, and calculate the average scores.


```r
disgust_groups <- disgust_total %>%
  mutate(year = year(date)) %>%
  group_by(year) %>%
  summarise(
    n = n(),
    avg_total = mean(total, na.rm = TRUE),
    sd_total  = sd(total, na.rm = TRUE),
    min_total = min(total, na.rm = TRUE),
    max_total = max(total, na.rm = TRUE),
    .groups = "drop"
  )
```

<table>
<caption>(\#tab:group-by)All rows from `disgust_groups`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> avg_total </th>
   <th style="text-align:right;"> sd_total </th>
   <th style="text-align:right;"> min_total </th>
   <th style="text-align:right;"> max_total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 2578 </td>
   <td style="text-align:right;"> 70.29975 </td>
   <td style="text-align:right;"> 18.46251 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 2580 </td>
   <td style="text-align:right;"> 69.74481 </td>
   <td style="text-align:right;"> 18.61959 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 1514 </td>
   <td style="text-align:right;"> 70.59238 </td>
   <td style="text-align:right;"> 18.86846 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 6046 </td>
   <td style="text-align:right;"> 71.34425 </td>
   <td style="text-align:right;"> 17.79446 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 5938 </td>
   <td style="text-align:right;"> 70.42530 </td>
   <td style="text-align:right;"> 18.35782 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 1251 </td>
   <td style="text-align:right;"> 71.59574 </td>
   <td style="text-align:right;"> 17.61375 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 70.46296 </td>
   <td style="text-align:right;"> 17.23502 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 113 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 74.26316 </td>
   <td style="text-align:right;"> 16.89787 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 107 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 67.87500 </td>
   <td style="text-align:right;"> 32.62531 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 110 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 57.16667 </td>
   <td style="text-align:right;"> 27.93862 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 90 </td>
  </tr>
</tbody>
</table>



::: {.warning data-latex=""}
If you don't add `.groups = "drop"` at the end of the `summarise()` function, you will get the following message: "`summarise()` ungrouping output (override with `.groups` argument)". This just reminds you that the groups are still in effect and any further functions will also be grouped. 

Older versions of dplyr didn't do this, so older code will generate this warning if you run it with newer version of dplyr. Older code might  `ungroup()` after `summarise()` to indicate that groupings should be dropped. The default behaviour is usually correct, so you don't need to worry, but it's best to explicitly set `.groups` in a `summarise()` function after `group_by()` if you want to "keep" or "drop" the groupings. 
:::

You can use `filter` after `group_by`. The following example returns the lowest total score from each year (i.e., the row where the `rank()` of the value in the column `total` is equivalent to `1`).


```r
disgust_lowest <- disgust_total %>%
  mutate(year = year(date)) %>%
  select(user_id, year, total) %>%
  group_by(year) %>%
  filter(rank(total) == 1) %>%
  arrange(year)
```

<table>
<caption>(\#tab:group-by-filter)All rows from `disgust_lowest`</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> user_id </th>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> U236585 </td>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U292359 </td>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U245384 </td>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U206293 </td>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U407089 </td>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 43 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U453237 </td>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> U356866 </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
</tbody>
</table>



You can also use `mutate` after `group_by`. The following example calculates subject-mean-centered scores by grouping the scores by `user_id` and then subtracting the group-specific mean from each score. <span class="text-warning">Note the use of `gather` to tidy the data into a long format first.</span>


```r
disgust_smc <- disgust %>%
  gather("question", "score", moral1:pathogen7) %>%
  group_by(user_id) %>%
  mutate(score_smc = score - mean(score, na.rm = TRUE)) %>% 
  ungroup()
```

::: {.warning data-latex=""}
Use `ungroup()` as soon as you are done with grouped functions, otherwise the data table will still be grouped when you use it in the future.
:::

<table>
<caption>(\#tab:group-by-mutate)Rows 1-6 from `disgust_smc`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:left;"> question </th>
   <th style="text-align:right;"> score </th>
   <th style="text-align:right;"> score_smc </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1199 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> 2008-10-07 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 0.9523810 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.0476190 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1599 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 2008-10-27 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13332 </td>
   <td style="text-align:right;"> 2118 </td>
   <td style="text-align:left;"> 2012-01-02 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -3.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 2311 </td>
   <td style="text-align:left;"> 2008-07-15 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0.6190476 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1160 </td>
   <td style="text-align:right;"> 3630 </td>
   <td style="text-align:left;"> 2008-10-06 </td>
   <td style="text-align:left;"> moral1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> -1.2500000 </td>
  </tr>
</tbody>
</table>




### All Together {#all-together}

A lot of what we did above would be easier if the data were tidy, so let's do that first. Then we can use `group_by` to calculate the domain scores.

After that, we can spread out the 3 domains, calculate the total score, remove any rows with a missing (`NA`) total, and calculate mean values by year.


```r
disgust_tidy <- reprores::disgust %>%
  gather("question", "score", moral1:pathogen7) %>%
  separate(question, c("domain","q_num"), sep = -1) %>%
  group_by(id, user_id, date, domain) %>%
  summarise(score = mean(score), .groups = "drop")
```

<table>
<caption>(\#tab:all-tidy)Rows 1-6 from `disgust_tidy`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:left;"> domain </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:left;"> moral </td>
   <td style="text-align:right;"> 1.428571 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:left;"> pathogen </td>
   <td style="text-align:right;"> 2.714286 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 1.714286 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 155324 </td>
   <td style="text-align:left;"> 2008-07-11 </td>
   <td style="text-align:left;"> moral </td>
   <td style="text-align:right;"> 3.000000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 155324 </td>
   <td style="text-align:left;"> 2008-07-11 </td>
   <td style="text-align:left;"> pathogen </td>
   <td style="text-align:right;"> 2.571429 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 155324 </td>
   <td style="text-align:left;"> 2008-07-11 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 1.857143 </td>
  </tr>
</tbody>
</table>




```r
disgust_scored <- disgust_tidy %>%
  spread(domain, score) %>%
  mutate(
    total = moral + sexual + pathogen,
    year = year(date)
  ) %>%
  filter(!is.na(total)) %>%
  arrange(user_id) 
```

<table>
<caption>(\#tab:all-scored)Rows 1-6 from `disgust_scored`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> user_id </th>
   <th style="text-align:left;"> date </th>
   <th style="text-align:right;"> moral </th>
   <th style="text-align:right;"> pathogen </th>
   <th style="text-align:right;"> sexual </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> year </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1199 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> 2008-10-07 </td>
   <td style="text-align:right;"> 5.285714 </td>
   <td style="text-align:right;"> 4.714286 </td>
   <td style="text-align:right;"> 2.142857 </td>
   <td style="text-align:right;"> 12.142857 </td>
   <td style="text-align:right;"> 2008 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2008-07-10 </td>
   <td style="text-align:right;"> 1.428571 </td>
   <td style="text-align:right;"> 2.714286 </td>
   <td style="text-align:right;"> 1.714286 </td>
   <td style="text-align:right;"> 5.857143 </td>
   <td style="text-align:right;"> 2008 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13332 </td>
   <td style="text-align:right;"> 2118 </td>
   <td style="text-align:left;"> 2012-01-02 </td>
   <td style="text-align:right;"> 1.000000 </td>
   <td style="text-align:right;"> 5.000000 </td>
   <td style="text-align:right;"> 3.000000 </td>
   <td style="text-align:right;"> 9.000000 </td>
   <td style="text-align:right;"> 2012 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 2311 </td>
   <td style="text-align:left;"> 2008-07-15 </td>
   <td style="text-align:right;"> 4.000000 </td>
   <td style="text-align:right;"> 4.285714 </td>
   <td style="text-align:right;"> 1.857143 </td>
   <td style="text-align:right;"> 10.142857 </td>
   <td style="text-align:right;"> 2008 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7980 </td>
   <td style="text-align:right;"> 4458 </td>
   <td style="text-align:left;"> 2011-09-05 </td>
   <td style="text-align:right;"> 3.428571 </td>
   <td style="text-align:right;"> 3.571429 </td>
   <td style="text-align:right;"> 3.000000 </td>
   <td style="text-align:right;"> 10.000000 </td>
   <td style="text-align:right;"> 2011 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 552 </td>
   <td style="text-align:right;"> 4651 </td>
   <td style="text-align:left;"> 2008-08-23 </td>
   <td style="text-align:right;"> 3.857143 </td>
   <td style="text-align:right;"> 4.857143 </td>
   <td style="text-align:right;"> 4.285714 </td>
   <td style="text-align:right;"> 13.000000 </td>
   <td style="text-align:right;"> 2008 </td>
  </tr>
</tbody>
</table>




```r
disgust_summarised <- disgust_scored %>%
  group_by(year) %>%
  summarise(
    n = n(),
    avg_pathogen = mean(pathogen),
    avg_moral = mean(moral),
    avg_sexual = mean(sexual),
    first_user = first(user_id),
    last_user = last(user_id),
    .groups = "drop"
  )
```

<table>
<caption>(\#tab:all-summarised)Rows 1-6 from `disgust_summarised`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> avg_pathogen </th>
   <th style="text-align:right;"> avg_moral </th>
   <th style="text-align:right;"> avg_sexual </th>
   <th style="text-align:right;"> first_user </th>
   <th style="text-align:right;"> last_user </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2008 </td>
   <td style="text-align:right;"> 2392 </td>
   <td style="text-align:right;"> 3.697265 </td>
   <td style="text-align:right;"> 3.806259 </td>
   <td style="text-align:right;"> 2.539298 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 188708 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 2410 </td>
   <td style="text-align:right;"> 3.674333 </td>
   <td style="text-align:right;"> 3.760937 </td>
   <td style="text-align:right;"> 2.528275 </td>
   <td style="text-align:right;"> 6093 </td>
   <td style="text-align:right;"> 251959 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 1418 </td>
   <td style="text-align:right;"> 3.731412 </td>
   <td style="text-align:right;"> 3.843139 </td>
   <td style="text-align:right;"> 2.510075 </td>
   <td style="text-align:right;"> 5469 </td>
   <td style="text-align:right;"> 319641 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 5586 </td>
   <td style="text-align:right;"> 3.756918 </td>
   <td style="text-align:right;"> 3.806506 </td>
   <td style="text-align:right;"> 2.628612 </td>
   <td style="text-align:right;"> 4458 </td>
   <td style="text-align:right;"> 406569 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 5375 </td>
   <td style="text-align:right;"> 3.740465 </td>
   <td style="text-align:right;"> 3.774591 </td>
   <td style="text-align:right;"> 2.545701 </td>
   <td style="text-align:right;"> 2118 </td>
   <td style="text-align:right;"> 458194 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 1222 </td>
   <td style="text-align:right;"> 3.771920 </td>
   <td style="text-align:right;"> 3.906944 </td>
   <td style="text-align:right;"> 2.549100 </td>
   <td style="text-align:right;"> 7646 </td>
   <td style="text-align:right;"> 462428 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 3.759259 </td>
   <td style="text-align:right;"> 4.000000 </td>
   <td style="text-align:right;"> 2.306878 </td>
   <td style="text-align:right;"> 11090 </td>
   <td style="text-align:right;"> 461307 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 3.781955 </td>
   <td style="text-align:right;"> 4.451128 </td>
   <td style="text-align:right;"> 2.375940 </td>
   <td style="text-align:right;"> 102699 </td>
   <td style="text-align:right;"> 460283 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 3.696429 </td>
   <td style="text-align:right;"> 3.625000 </td>
   <td style="text-align:right;"> 2.375000 </td>
   <td style="text-align:right;"> 4976 </td>
   <td style="text-align:right;"> 453237 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3.071429 </td>
   <td style="text-align:right;"> 3.690476 </td>
   <td style="text-align:right;"> 1.404762 </td>
   <td style="text-align:right;"> 48303 </td>
   <td style="text-align:right;"> 370464 </td>
  </tr>
</tbody>
</table>



## Additional dplyr one-table verbs

Use the code examples below and the help pages to figure out what the following one-table verbs do. Most have pretty self-explanatory names.

### rename() {#rename}

You can rename columns with `rename()`. Set the argument name to the new name, and the value to the old name. You need to put a name in quotes or backticks if it doesn't follow the rules for a good variable name (contains only letter, numbers, underscores, and full stops; and doesn't start with a number).


```r
sw <- starwars %>%
  rename(Name = name,
         Height = height,
         Mass = mass,
         `Hair Colour` = hair_color,
         `Skin Colour` = skin_color,
         `Eye Colour` = eye_color,
         `Birth Year` = birth_year)

names(sw)
```

```
##  [1] "Name"        "Height"      "Mass"        "Hair Colour" "Skin Colour"
##  [6] "Eye Colour"  "Birth Year"  "sex"         "gender"      "homeworld"  
## [11] "species"     "films"       "vehicles"    "starships"
```


::: {.try data-latex=""}
Almost everyone gets confused at some point with `rename()` and tries to put the original names on the left and the new names on the right. Try it and see what the error message looks like.
:::

### distinct() {#distinct}

Get rid of exactly duplicate rows with `distinct()`. This can be helpful if, for example, you are merging data from multiple computers and some of the data got copied from one computer to another, creating duplicate rows.


```r
# create a data table with duplicated values
dupes <- tibble(
  id = c( 1,   2,   1,   2,   1,   2),
  dv = c("A", "B", "C", "D", "A", "B")
)

distinct(dupes)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> dv </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> A </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> C </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> D </td>
  </tr>
</tbody>
</table>

</div>

### count() {#count}

The function `count()` is a quick shortcut for the common combination of `group_by()` and `summarise()` used to count the number of rows per group.


```r
starwars %>%
  group_by(sex) %>%
  summarise(n = n(), .groups = "drop")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hermaphroditic </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> male </td>
   <td style="text-align:right;"> 60 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> none </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
</tbody>
</table>

</div>


```r
count(starwars, sex)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hermaphroditic </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> male </td>
   <td style="text-align:right;"> 60 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> none </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
</tbody>
</table>

</div>


### slice() {#slice}


```r
slice(starwars, 1:3, 10)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> name </th>
   <th style="text-align:right;"> height </th>
   <th style="text-align:right;"> mass </th>
   <th style="text-align:left;"> hair_color </th>
   <th style="text-align:left;"> skin_color </th>
   <th style="text-align:left;"> eye_color </th>
   <th style="text-align:right;"> birth_year </th>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> homeworld </th>
   <th style="text-align:left;"> species </th>
   <th style="text-align:left;"> films </th>
   <th style="text-align:left;"> vehicles </th>
   <th style="text-align:left;"> starships </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Luke Skywalker </td>
   <td style="text-align:right;"> 172 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> blond </td>
   <td style="text-align:left;"> fair </td>
   <td style="text-align:left;"> blue </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> masculine </td>
   <td style="text-align:left;"> Tatooine </td>
   <td style="text-align:left;"> Human </td>
   <td style="text-align:left;"> The Empire Strikes Back, Revenge of the Sith    , Return of the Jedi     , A New Hope             , The Force Awakens </td>
   <td style="text-align:left;"> Snowspeeder          , Imperial Speeder Bike </td>
   <td style="text-align:left;"> X-wing          , Imperial shuttle </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C-3PO </td>
   <td style="text-align:right;"> 167 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> gold </td>
   <td style="text-align:left;"> yellow </td>
   <td style="text-align:right;"> 112 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> masculine </td>
   <td style="text-align:left;"> Tatooine </td>
   <td style="text-align:left;"> Droid </td>
   <td style="text-align:left;"> The Empire Strikes Back, Attack of the Clones   , The Phantom Menace     , Revenge of the Sith    , Return of the Jedi     , A New Hope </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2-D2 </td>
   <td style="text-align:right;"> 96 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> white, blue </td>
   <td style="text-align:left;"> red </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> masculine </td>
   <td style="text-align:left;"> Naboo </td>
   <td style="text-align:left;"> Droid </td>
   <td style="text-align:left;"> The Empire Strikes Back, Attack of the Clones   , The Phantom Menace     , Revenge of the Sith    , Return of the Jedi     , A New Hope             , The Force Awakens </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Obi-Wan Kenobi </td>
   <td style="text-align:right;"> 182 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> auburn, white </td>
   <td style="text-align:left;"> fair </td>
   <td style="text-align:left;"> blue-gray </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> masculine </td>
   <td style="text-align:left;"> Stewjon </td>
   <td style="text-align:left;"> Human </td>
   <td style="text-align:left;"> The Empire Strikes Back, Attack of the Clones   , The Phantom Menace     , Revenge of the Sith    , Return of the Jedi     , A New Hope </td>
   <td style="text-align:left;"> Tribubble bongo </td>
   <td style="text-align:left;"> Jedi starfighter        , Trade Federation cruiser, Naboo star skiff        , Jedi Interceptor        , Belbullab-22 starfighter </td>
  </tr>
</tbody>
</table>

</div>

### pull() {#pull}


```r
starwars %>%
  filter(species == "Droid") %>%
  pull(name)
```

```
## [1] "C-3PO"  "R2-D2"  "R5-D4"  "IG-88"  "R4-P17" "BB8"
```


## Window functions {#window}

Window functions use the order of rows to calculate values. You can use them to do things that require ranking or ordering, like choose the top scores in each class, or accessing the previous and next rows, like calculating cumulative sums or means.

The [dplyr window functions vignette](https://dplyr.tidyverse.org/articles/window-functions.html) has very good detailed explanations of these functions, but we've described a few of the most useful ones below. 

### Ranking functions


```r
grades <- tibble(
  id = 1:5,
  "Data Skills" = c(16, 17, 17, 19, 20), 
  "Statistics"  = c(14, 16, 18, 18, 19)
) %>%
  gather(class, grade, 2:3) %>%
  group_by(class) %>%
  mutate(row_number = row_number(),
         rank       = rank(grade),
         min_rank   = min_rank(grade),
         dense_rank = dense_rank(grade),
         quartile   = ntile(grade, 4),
         percentile = ntile(grade, 100))
```

<table>
<caption>(\#tab:unnamed-chunk-1)All rows from `grades`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> class </th>
   <th style="text-align:right;"> grade </th>
   <th style="text-align:right;"> row_number </th>
   <th style="text-align:right;"> rank </th>
   <th style="text-align:right;"> min_rank </th>
   <th style="text-align:right;"> dense_rank </th>
   <th style="text-align:right;"> quartile </th>
   <th style="text-align:right;"> percentile </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Data Skills </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Data Skills </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2.5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Data Skills </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2.5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Data Skills </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4.0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Data Skills </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Statistics </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Statistics </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2.0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Statistics </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3.5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Statistics </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3.5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Statistics </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>



::: {.try data-latex=""}
* What are the differences among `row_number()`, `rank()`, `min_rank()`, `dense_rank()`, and `ntile()`? 
* Why doesn't `row_number()` need an argument? 
* What would happen if you gave it the argument `grade` or `class`? 
* What do you think would happen if you removed the `group_by(class)` line above? 
* What if you added `id` to the grouping?
* What happens if you change the order of the rows?
* What does the second argument in `ntile()` do?
:::

You can use window functions to group your data into quantiles.


```r
sw_mass <- starwars %>%
  group_by(tertile = ntile(mass, 3)) %>%
  summarise(min = min(mass),
            max = max(mass),
            mean = mean(mass),
            .groups = "drop")
```

<table>
<caption>(\#tab:unnamed-chunk-2)All rows from `sw_mass`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> tertile </th>
   <th style="text-align:right;"> min </th>
   <th style="text-align:right;"> max </th>
   <th style="text-align:right;"> mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 45.6600 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 78.4100 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 1358 </td>
   <td style="text-align:right;"> 171.5789 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>



::: {.try data-latex=""}
Why is there a row of `NA` values? How would you get rid of them? 
:::


### Offset functions

The function `lag()` gives a previous row's value. It defaults to 1 row back, but you can change that with the `n` argument. The function `lead()` gives values ahead of the current row.


```r
lag_lead <- tibble(x = 1:6) %>%
  mutate(lag = lag(x),
         lag2 = lag(x, n = 2),
         lead = lead(x, default = 0))
```

<table>
<caption>(\#tab:unnamed-chunk-3)All rows from `lag_lead`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> x </th>
   <th style="text-align:right;"> lag </th>
   <th style="text-align:right;"> lag2 </th>
   <th style="text-align:right;"> lead </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>



You can use offset functions to calculate change between trials or where a value changes. Use the `order_by` argument to specify the order of the rows. Alternatively, you can use `arrange()` before the offset functions.


```r
trials <- tibble(
  trial = sample(1:10, 10),
  cond = sample(c("exp", "ctrl"), 10, T),
  score = rpois(10, 4)
) %>%
  mutate(
    score_change = score - lag(score, order_by = trial),
    change_cond = cond != lag(cond, order_by = trial, 
                              default = "no condition")
  ) %>%
  arrange(trial)
```

<table>
<caption>(\#tab:offset-adv)All rows from `trials`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> trial </th>
   <th style="text-align:left;"> cond </th>
   <th style="text-align:right;"> score </th>
   <th style="text-align:right;"> score_change </th>
   <th style="text-align:left;"> change_cond </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> -4 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> -4 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> -4 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> ctrl </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> exp </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> -1 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
</tbody>
</table>



::: {.try data-latex=""}
Look at the help pages for `lag()` and `lead()`.

* What happens if you remove the `order_by` argument or change it to `cond`?
* What does the `default` argument do?
* Can you think of circumstances in your own data where you might need to use `lag()` or `lead()`?
:::

### Cumulative aggregates

`cumsum()`, `cummin()`, and `cummax()` are base R functions for calculating cumulative means, minimums, and maximums. The dplyr package introduces `cumany()` and `cumall()`, which return `TRUE` if any or all of the previous values meet their criteria.


```r
cumulative <- tibble(
  time = 1:10,
  obs = c(2, 2, 1, 2, 4, 3, 1, 0, 3, 5)
) %>%
  mutate(
    cumsum = cumsum(obs),
    cummin = cummin(obs),
    cummax = cummax(obs),
    cumany = cumany(obs == 3),
    cumall = cumall(obs < 4)
  )
```

<table>
<caption>(\#tab:unnamed-chunk-4)All rows from `cumulative`</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> time </th>
   <th style="text-align:right;"> obs </th>
   <th style="text-align:right;"> cumsum </th>
   <th style="text-align:right;"> cummin </th>
   <th style="text-align:right;"> cummax </th>
   <th style="text-align:left;"> cumany </th>
   <th style="text-align:left;"> cumall </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
</tbody>
</table>



::: {.try data-latex=""}
* What would happen if you change `cumany(obs == 3)` to `cumany(obs > 2)`?
* What would happen if you change `cumall(obs < 4)` to `cumall(obs < 2)`?
* Can you think of circumstances in your own data where you might need to use `cumany()` or `cumall()`?
:::

## Glossary {#glossary-dplyr}

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [data wrangling](https://psyteachr.github.io/glossary/d.html#data-wrangling){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The process of preparing data for visualisation and statistical analysis. </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-dplyr}

* [Chapter 5: Data Transformation](http://r4ds.had.co.nz/transform.html) in *R for Data Science*
* [Data transformation cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf)
* [Chapter 16: Date and times](http://r4ds.had.co.nz/dates-and-times.html) in *R for Data Science*
