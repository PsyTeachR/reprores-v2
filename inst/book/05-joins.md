# Data Relations {#joins}

<div class="right meme"><img src="images/memes/joins.png"
     alt="3-panel meme. 1: dog looks at a baby in a chair, text reads 'An SQL query goes into a bar, walks up to two tables and asks...'; 2: baby looks at dog, text reads 'Can I join you?'; 3: dog and baby look at camera, no text" /></div>

## Learning Objectives {#ilo-joins}

1. Be able to use the 4 mutating join verbs: [(video)](https://youtu.be/WV0yg6f3DNM){class="video"}
    + [`left_join()`](#left_join)
    + [`right_join()`](#right_join)
    + [`inner_join()`](#inner_join)
    + [`full_join()`](#full_join)
2. Be able to use the 2 filtering join verbs: [(video)](https://youtu.be/ijoCEKifefQ){class="video"}
    + [`semi_join()`](#semi_join)
    + [`anti_join()`](#anti_join)
3. Be able to use the 2 binding join verbs: [(video)](https://youtu.be/8RWdNhbVZ4I){class="video"}
    + [`bind_rows()`](#bind_rows)
    + [`bind_cols()`](#bind_cols)
4. Be able to use the 3 set operations: [(video)](https://youtu.be/c3V33ElWUYI){class="video"}
    + [`intersect()`](#intersect)
    + [`union()`](#union)
    + [`setdiff()`](#setdiff)


## Setup {#setup-joins}


```r
# libraries needed
library(tidyverse)
library(reprores)
```

## Data

First, we'll create two small data tables. 

`subject` has id, gender and age for subjects 1-5. Age and gender are missing for subject 3.


```r
subject <- tibble(
  id = 1:5,
  gender = c("m", "m", NA, "nb", "f"),
  age = c(19, 22, NA, 19, 18)
)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>



`exp` has subject id and the score from an experiment. Some subjects are missing, some completed twice, and some are not in the subject table.


```r
exp <- tibble(
  id = c(2, 3, 4, 4, 5, 5, 6, 6, 7),
  score = c(10, 18, 21, 23, 9, 11, 11, 12, 3)
)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>




## Mutating Joins

<a class='glossary' target='_blank' title='Joins that act like the dplyr::mutate() function in that they add new columns to one table based on values in another table.' href='https://psyteachr.github.io/glossary/m#mutating-joins'>Mutating joins</a> act like the `mutate()` function in that they add new columns to one table based on values in another table.  

All the mutating joins have this basic syntax:

`****_join(x, y, by = NULL, suffix = c(".x", ".y")`

* `x` = the first (left) table
* `y` = the second (right) table
* `by` = what columns to match on. If you leave this blank, it will match on all columns with the same names in the two tables.
* `suffix` = if columns have the same name in the two tables, but you aren't joining by them, they get a suffix to make them unambiguous. This defaults to ".x" and ".y", but you can change it to something more meaningful.

::: {.info data-latex=""}
You can leave out the `by` argument if you're matching on all of the columns with the same name, but it's good practice to always specify it so your code is robust to changes in the loaded data.
:::

### left_join() {#left_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/left_join.png" alt="Left Join" width="100%" />
<p class="caption">(\#fig:img-left-join)Left Join</p>
</div></div>

A `left_join` keeps all the data from the first (left) table and joins anything that matches from the second (right) table. If the right table has more than one match for a row in the right table, there will be more than one row in the joined table (see ids 4 and 5).


```r
left_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/left_join_rev.png" alt="Left Join (reversed)" width="100%" />
<p class="caption">(\#fig:img-left-join-rev)Left Join (reversed)</p>
</div></div>

The order of tables is swapped here, so the result is all rows from the `exp` table joined to any matching rows from the `subject` table.


```r
left_join(exp, subject, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> score </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

</div>

### right_join() {#right_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/right_join.png" alt="Right Join" width="100%" />
<p class="caption">(\#fig:img-right-join)Right Join</p>
</div></div>

A `right_join` keeps all the data from the second (right) table and joins anything that matches from the first (left) table. 


```r
right_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>

::: {.info data-latex=""}
This table has the same information as `left_join(exp, subject, by = "id")`, but the columns are in a different order (left table, then right table).
:::

### inner_join() {#inner_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/inner_join.png" alt="Inner Join" width="100%" />
<p class="caption">(\#fig:img-inner-join)Inner Join</p>
</div></div>

An `inner_join` returns all the rows that have a match in the other table.


```r
inner_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>


### full_join() {#full_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/full_join.png" alt="Full Join" width="100%" />
<p class="caption">(\#fig:img-full-join)Full Join</p>
</div></div>

A `full_join` lets you join up rows in two tables while keeping all of the information from both tables. If a row doesn't have a match in the other table, the other table's column values are set to `NA`.


```r
full_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>


## Filtering Joins

<a class='glossary' target='_blank' title='Joins that act like the dplyr::filter() function in that they remove rows from the data in one table based on the values in another table.' href='https://psyteachr.github.io/glossary/f#filtering-joins'>Filtering joins</a> act like the `filter()` function in that they remove rows from the data in one table based on the values in another table. The result of a filtering join will only contain rows from the left table and have the same number or fewer rows than the left table. 

### semi_join() {#semi_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/semi_join.png" alt="Semi Join" width="100%" />
<p class="caption">(\#fig:img-semi-join)Semi Join</p>
</div></div>

A `semi_join` returns all rows from the left table where there are matching values in the right table, keeping just columns from the left table.


```r
semi_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>

::: {.info data-latex=""}
Unlike an inner join, a semi join will never duplicate the rows in the left table if there is more than one matching row in the right table.
:::

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/semi_join_rev.png" alt="Semi Join (Reversed)" width="100%" />
<p class="caption">(\#fig:img-semi-join-rev)Semi Join (Reversed)</p>
</div></div>

Order matters in a semi join.


```r
semi_join(exp, subject, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>

### anti_join() {#anti_join}

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/anti_join.png" alt="Anti Join" width="100%" />
<p class="caption">(\#fig:img-anti-join)Anti Join</p>
</div></div>

An `anti_join` return all rows from the left table where there are *not* matching values in the right table, keeping just columns from the left table.


```r
anti_join(subject, exp, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

<div class = 'join'><div class="figure" style="text-align: center">
<img src="images/joins/anti_join_rev.png" alt="Anti Join (Reversed)" width="100%" />
<p class="caption">(\#fig:img-anti-join-rev)Anti Join (Reversed)</p>
</div></div>

Order matters in an anti join.


```r
anti_join(exp, subject, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>

## Binding Joins

<a class='glossary' target='_blank' title='Joins that bind one table to another by adding their rows or columns together.' href='https://psyteachr.github.io/glossary/b#binding-joins'>Binding joins</a> bind one table to another by adding their rows or columns together.

### bind_rows() {#bind_rows}

You can combine the rows of two tables with `bind_rows`.

Here we'll add subject data for subjects 6-9 and bind that to the original subject table.


```r
new_subjects <- tibble(
  id = 6:9,
  gender = c("nb", "m", "f", "f"),
  age = c(19, 16, 20, 19)
)

bind_rows(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

The columns just have to have the same names, they don't have to be in the same order. Any columns that differ between the two tables will just have `NA` values for entries from the other table.

If a row is duplicated between the two tables (like id 5 below), the row will also be duplicated in the resulting table. If your tables have the exact same columns, you can use `union()` (see below) to avoid duplicates.


```r
new_subjects <- tibble(
  id = 5:9,
  age = c(18, 19, 16, 20, 19),
  gender = c("f", "nb", "m", "f", "f"),
  new = c(1,2,3,4,5)
)

bind_rows(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> new </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>

</div>

### bind_cols() {#bind_cols}

You can merge two tables with the same number of rows using `bind_cols`. This is only useful if the two tables have their rows in the exact same order. The only advantage over a left join is when the tables don't have any IDs to join by and you have to rely solely on their order.


```r
new_info <- tibble(
  colour = c("red", "orange", "yellow", "green", "blue")
)

bind_cols(subject, new_info)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> colour </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> red </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> orange </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> yellow </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> green </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> blue </td>
  </tr>
</tbody>
</table>

</div>

## Set Operations

<a class='glossary' target='_blank' title='Functions that compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff).' href='https://psyteachr.github.io/glossary/s#set-operations'>Set operations</a> compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff).

### intersect() {#intersect}

`intersect()` returns all rows in two tables that match exactly. The columns don't have to be in the same order.


```r
new_subjects <- tibble(
  id = seq(4, 9),
  age = c(19, 18, 19, 16, 20, 19),
  gender = c("f", "f", "m", "m", "f", "f")
)

intersect(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has an `intersect()` function. The error message can be confusing and looks something like this:


```r
base::intersect(subject, new_subjects)
```

```
## Error in `vectbl_as_row_location()`:
## ! Must subset rows with a valid subscript vector.
## ℹ Logical subscripts must match the size of the indexed input.
## ✖ Input has size 6 but subscript `!duplicated(x, fromLast = fromLast, ...)` has size 0.
```
:::

### union() {#union}

`union()` returns all the rows from both tables, removing duplicate rows.


```r
union(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>


::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has a `union()` function. You usually won't get an error message, but the output won't be what you expect.


```r
base::union(subject, new_subjects)
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "m"  "m"  NA   "nb" "f" 
## 
## [[3]]
## [1] 19 22 NA 19 18
## 
## [[4]]
## [1] 4 5 6 7 8 9
## 
## [[5]]
## [1] 19 18 19 16 20 19
## 
## [[6]]
## [1] "f" "f" "m" "m" "f" "f"
```
:::

### setdiff() {#setdiff}

`setdiff` returns rows that are in the first table, but not in the second table.


```r
setdiff(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

Order matters for `setdiff`.


```r
setdiff(new_subjects, subject)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> f </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> m </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> m </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> f </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> f </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has a `setdiff()` function. You usually won't get an error message, but the output might not be what you expect because the base R `setdiff()` expects columns to be in the same order, so id 5 here registers as different between the two tables.


```r
base::setdiff(subject, new_subjects)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>
:::

## Glossary {#glossary-joins}

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
   <td style="text-align:left;"> [binding joins](https://psyteachr.github.io/glossary/b.html#binding-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that bind one table to another by adding their rows or columns together. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [filtering joins](https://psyteachr.github.io/glossary/f.html#filtering-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that act like the dplyr::filter() function in that they remove rows from the data in one table based on the values in another table. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [mutating joins](https://psyteachr.github.io/glossary/m.html#mutating-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that act like the dplyr::mutate() function in that they add new columns to one table based on values in another table. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [set operations](https://psyteachr.github.io/glossary/s.html#set-operations){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Functions that compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff). </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-joins}

* [Chapter 13: Relational Data](http://r4ds.had.co.nz/relational-data.html) in *R for Data Science*
* [Cheatsheet for dplyr join functions](http://stat545.com/bit001_dplyr-cheatsheet.html)
* [Lecture slides on dplyr two-table verbs](slides/05_joins_slides.pdf)
