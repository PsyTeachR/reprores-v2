# Data Visualisation {#ggplot}

<div class="right meme"><img src="images/memes/better_graphs.png" 
     alt = "xkcd comic titled 'General quality of charts and graphs in scientific papers'; y-axis: BAD on the bottom to GOOD on the top; x-axis: 1950s to 2010s; Line graph increases with time except for a dip between 1990 and 2010 labelled POWERPOINT/MSPAINT ERA" /></div>

## Learning Objectives {#ilo-ggplot}

### Basic

1. Understand what types of graphs are best for [different types of data](#vartypes) [(video)](https://youtu.be/tOFQFPRgZ3M){class="video"}
    + 1 discrete
    + 1 continuous
    + 2 discrete
    + 2 continuous
    + 1 discrete, 1 continuous
    + 3 continuous
2. Create common types of graphs with ggplot2 [(video)](https://youtu.be/kKlQupjD__g){class="video"}
    + [`geom_bar()`](#geom_bar)
    + [`geom_density()`](#geom_density)
    + [`geom_freqpoly()`](#geom_freqpoly)
    + [`geom_histogram()`](#geom_histogram)
    + [`geom_col()`](#geom_col)
    + [`geom_boxplot()`](#geom_boxplot)
    + [`geom_violin()`](#geom_violin)
    + [Vertical Intervals](#vertical_intervals)
        + `geom_crossbar()`
        + `geom_errorbar()`
        + `geom_linerange()`
        + `geom_pointrange()`
    + [`geom_point()`](#geom_point)
    + [`geom_smooth()`](#geom_smooth)
3. Set custom [size](#custom-size),
              [labels](#custom-labels), 
              [colours](#custom-colours), and
              [themes](#themes) [(video)](https://youtu.be/6pHuCbOh86s){class="video"}
4. [Combine plots](combo_plots) on the same plot, as facets, or as a grid using patchwork [(video)](https://youtu.be/AnqlfuU-VZk){class="video"}
5. [Save plots](#ggsave) as an image file [(video)](https://youtu.be/f1Y53mjEli0){class="video"}
    
### Intermediate

6. Add lines to graphs
7. Deal with [overlapping data](#overlap)
8. Create less common types of graphs
    + [`geom_tile()`](#geom_tile)
    + [`geom_density2d()`](#geom_density2d)
    + [`geom_bin2d()`](#geom_bin2d)
    + [`geom_hex()`](#geom_hex)
    + [`geom_count()`](#geom_count)
9. Adjust axes (e.g., flip coordinates, set axis limits)
10. Create interactive graphs with [`plotly`](#plotly)


## Resources {#resources3}

* [Data visualisation using R, for researchers who don't use R](https://psyarxiv.com/4huvw/)
* [Chapter 3: Data Visualisation](http://r4ds.had.co.nz/data-visualisation.html) of *R for Data Science*
* [ggplot2 cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
* [Chapter 28: Graphics for communication](http://r4ds.had.co.nz/graphics-for-communication.html) of *R for Data Science*
* [Look at Data](http://socviz.co/look-at-data.html) from [Data Vizualization for Social Science](http://socviz.co/)
* [Hack Your Data Beautiful](https://psyteachr.github.io/hack-your-data/) workshop by University of Glasgow postgraduate students
* [Graphs](http://www.cookbook-r.com/Graphs) in *Cookbook for R*
* [ggplot2 documentation](https://ggplot2.tidyverse.org/reference/)
* [The R Graph Gallery](http://www.r-graph-gallery.com/) (this is really useful)
* [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
* [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/) by Winston Chang
* [ggplot extensions](https://www.ggplot2-exts.org/)
* [plotly](https://plot.ly/ggplot2/) for creating interactive graphs


## Setup {#setup_ggplot}


```r
# libraries needed for these graphs
library(tidyverse)
library(patchwork) 
library(plotly)
library(ggwordcloud)
library(reprores)

set.seed(30250) # makes sure random numbers are reproducible
```

## Common Variable Combinations {#vartypes}

<a class='glossary' target='_blank' title='Data that can take on any values between other existing values.' href='https://psyteachr.github.io/glossary/c#continuous'>Continuous</a> variables are properties you can measure, like height. <a class='glossary' target='_blank' title='Data that can only take certain values, such as integers.' href='https://psyteachr.github.io/glossary/d#discrete'>Discrete</a> variables are things you can count, like the number of pets you have. Categorical variables can be <a class='glossary' target='_blank' title='Categorical variables that don’t have an inherent order, such as types of animal.' href='https://psyteachr.github.io/glossary/n#nominal'>nominal</a>, where the categories don't really have an order, like cats, dogs and ferrets (even though ferrets are obviously best). They can also be <a class='glossary' target='_blank' title='Discrete variables that have an inherent order, such as number of legs' href='https://psyteachr.github.io/glossary/o#ordinal'>ordinal</a>, where there is a clear order, but the distance between the categories isn't something you could exactly equate, like points on a <a class='glossary' target='_blank' title='A rating scale with a small number of discrete points in order' href='https://psyteachr.github.io/glossary/l#likert'>Likert</a> rating scale.

Different types of visualisations are good for different types of variables. 

Load the `pets` dataset and explore it with `glimpse(pets)` or `View(pets)`. This is a simulated dataset with one random factor (`id`), two categorical factors (`pet`, `country`) and three continuous variables (`score`, `age`, `weight`). 


```r
data("pets", package = "reprores")
# if you don't have the reprores package, use:
# pets <- read_csv("https://psyteachr.github.io/reprores/data/pets.csv", col_types = "cffiid")
glimpse(pets)
```

```
## Rows: 800
## Columns: 6
## $ id      <chr> "S001", "S002", "S003", "S004", "S005", "S006", "S007", "S008"…
## $ pet     <fct> dog, dog, dog, dog, dog, dog, dog, dog, dog, dog, dog, dog, do…
## $ country <fct> UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK, UK…
## $ score   <int> 90, 107, 94, 120, 111, 110, 100, 107, 106, 109, 85, 110, 102, …
## $ age     <int> 6, 8, 2, 10, 4, 8, 9, 8, 6, 11, 5, 9, 1, 10, 7, 8, 1, 8, 5, 13…
## $ weight  <dbl> 19.78932, 20.01422, 19.14863, 19.56953, 21.39259, 21.31880, 19…
```


::: {.try data-latex=""}
Before you read ahead, come up with an example of each type of variable combination and sketch the types of graphs that would best display these data.

* 1 categorical
* 1 continuous
* 2 categorical
* 2 continuous
* 1 categorical, 1 continuous
* 3 continuous
:::


## Basic Plots

R has some basic plotting functions, but they're difficult to use and aesthetically not very nice. They can be useful to have a quick look at data while you're working on a script, though. The function `plot()` usually defaults to a sensible type of plot, depending on whether the arguments `x` and `y` are categorical, continuous, or missing.


```r
plot(x = pets$pet)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/plot0-1.png" alt="plot() with categorical x" width="100%" />
<p class="caption">(\#fig:plot0)plot() with categorical x</p>
</div>


```r
plot(x = pets$pet, y = pets$score)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/plot1-1.png" alt="plot() with categorical x and continuous y" width="100%" />
<p class="caption">(\#fig:plot1)plot() with categorical x and continuous y</p>
</div>


```r
plot(x = pets$age, y = pets$weight)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/plot2-1.png" alt="plot() with continuous x and y" width="100%" />
<p class="caption">(\#fig:plot2)plot() with continuous x and y</p>
</div>
The function `hist()` creates a quick histogram so you can see the distribution of your data. You can adjust how many columns are plotted with the argument `breaks`.


```r
hist(pets$score, breaks = 20)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/hist-1.png" alt="hist()" width="100%" />
<p class="caption">(\#fig:hist)hist()</p>
</div>

## GGplots

While the functions above are nice for quick visualisations, it's hard to make pretty, publication-ready plots. The package `ggplot2` (loaded with `tidyverse`) is one of the most common packages for creating beautiful visualisations.

`ggplot2` creates plots using a "grammar of graphics" where you add <a class='glossary' target='_blank' title='The geometric style in which data are displayed, such as boxplot, density, or histogram.' href='https://psyteachr.github.io/glossary/g#geom'>geoms</a> in layers. It can be complex to understand, but it's very powerful once you have a mental model of how it works. 

Let's start with a totally empty plot layer created by the `ggplot()` function with no arguments.


```r
ggplot()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/ggplot-empty-1.png" alt="A plot base created by ggplot()" width="100%" />
<p class="caption">(\#fig:ggplot-empty)A plot base created by ggplot()</p>
</div>

The first argument to `ggplot()` is the `data` table you want to plot. Let's use the `pets` data we loaded above. The second argument is the `mapping` for which columns in your data table correspond to which properties of the plot, such as the `x`-axis, the `y`-axis, line `colour` or `linetype`, point `shape`, or object `fill`. These mappings are specified by the `aes()` function. Just adding this to the `ggplot` function creates the labels and ranges for the `x` and `y` axes. They usually have sensible default values, given your data, but we'll learn how to change them later.


```r
mapping <- aes(x = pet, 
               y = score, 
               colour = country, 
               fill = country)
ggplot(data = pets, mapping = mapping)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/ggplot-labels-1.png" alt="Empty ggplot with x and y labels" width="100%" />
<p class="caption">(\#fig:ggplot-labels)Empty ggplot with x and y labels</p>
</div>
::: {.info data-latex=""}
People usually omit the argument names and just put the `aes()` function directly as the second argument to `ggplot`. They also usually omit `x` and `y` as argument names to `aes()` (but you have to name the other properties). 
:::

Next we can add "geoms", or plot styles. You literally add them with the `+` symbol. You can also add other plot attributes, such as labels, or change the theme and base font size.


```r
ggplot(pets, aes(pet, score, colour = country, fill = country)) +
  geom_violin(alpha = 0.5) +
  labs(x = "Pet type",
       y = "Score on an Important Test",
       colour = "Country of Origin",
       fill = "Country of Origin",
       title = "My first plot!") +
  theme_bw(base_size = 15)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/ggplot-geom-1.png" alt="Violin plot with country represented by colour." width="100%" />
<p class="caption">(\#fig:ggplot-geom)Violin plot with country represented by colour.</p>
</div>


## Common Plot Types

There are many geoms, and they can take different arguments to customise their appearance. We'll learn about some of the most common below.

### Bar plot {#geom_bar}

Bar plots are good for categorical data where you want to represent the count.


```r
ggplot(pets, aes(pet)) +
  geom_bar()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/barplot-1.png" alt="Bar plot" width="100%" />
<p class="caption">(\#fig:barplot)Bar plot</p>
</div>

### Density plot {#geom_density}

Density plots are good for one continuous variable, but only if you have a fairly large number of observations.


```r
ggplot(pets, aes(score)) +
  geom_density()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/density-1.png" alt="Density plot" width="100%" />
<p class="caption">(\#fig:density)Density plot</p>
</div>

You can represent subsets of a variable by assigning the category variable to the argument `group`, `fill`, or `color`. 


```r
ggplot(pets, aes(score, fill = pet)) +
  geom_density(alpha = 0.5)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/density-grouped-1.png" alt="Grouped density plot" width="100%" />
<p class="caption">(\#fig:density-grouped)Grouped density plot</p>
</div>

::: {.try data-latex=""}
Try changing the `alpha` argument to figure out what it does.
:::

### Frequency polygons {#geom_freqpoly}

If you want the y-axis to represent count rather than density, try `geom_freqpoly()`.


```r
ggplot(pets, aes(score, color = pet)) +
  geom_freqpoly(binwidth = 5)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/freqpoly-1.png" alt="Frequency ploygon plot" width="100%" />
<p class="caption">(\#fig:freqpoly)Frequency ploygon plot</p>
</div>

::: {.try data-latex=""}
Try changing the `binwidth` argument to 10 and 1. How do you figure out the right value?
:::

### Histogram {#geom_histogram}

Histograms are also good for one continuous variable, and work well if you don't have many observations. Set the `binwidth` to control how wide each bar is.


```r
ggplot(pets, aes(score)) +
  geom_histogram(binwidth = 5, fill = "white", color = "black")
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/histogram-1.png" alt="Histogram" width="100%" />
<p class="caption">(\#fig:histogram)Histogram</p>
</div>

::: {.info data-latex=""}
Histograms in ggplot look pretty bad unless you set the `fill` and `color`.
:::

If you show grouped histograms, you also probably want to change the default `position` argument.


```r
ggplot(pets, aes(score, fill=pet)) +
  geom_histogram(binwidth = 5, alpha = 0.5, 
                 position = "dodge")
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/histogram-grouped-1.png" alt="Grouped Histogram" width="100%" />
<p class="caption">(\#fig:histogram-grouped)Grouped Histogram</p>
</div>

::: {.try data-latex=""}
Try changing the `position` argument to "identity", "fill", "dodge", or "stack".
:::

### Column plot {#geom_col}

Column plots are the worst way to represent grouped continuous data, but also one of the most common. If your data are already aggregated (e.g., you have rows for each group with columns for the mean and standard error), you can use `geom_bar` or `geom_col` and `geom_errorbar` directly. If not, you can use the function `stat_summary` to calculate the mean and standard error and send those numbers to the appropriate geom for plotting.


```r
ggplot(pets, aes(pet, score, fill=pet)) +
  stat_summary(fun = mean, geom = "col", alpha = 0.5) + 
  stat_summary(fun.data = mean_se, geom = "errorbar",
               width = 0.25) +
  coord_cartesian(ylim = c(80, 120))
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/colplot-statsum-1.png" alt="Column plot" width="100%" />
<p class="caption">(\#fig:colplot-statsum)Column plot</p>
</div>

::: {.try data-latex=""}
Try changing the values for `coord_cartesian`. What does this do?
:::

### Boxplot {#geom_boxplot}

Boxplots are great for representing the distribution of grouped continuous variables. They fix most of the problems with using bar/column plots for continuous data.


```r
ggplot(pets, aes(pet, score, fill=pet)) +
  geom_boxplot(alpha = 0.5)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/boxplot-1.png" alt="Box plot" width="100%" />
<p class="caption">(\#fig:boxplot)Box plot</p>
</div>

### Violin plot {#geom_violin}

Violin pots are like sideways, mirrored density plots. They give even more information than a boxplot about distribution and are especially useful when you have non-normal distributions.


```r
ggplot(pets, aes(pet, score, fill=pet)) +
  geom_violin(draw_quantiles = .5,
              trim = FALSE, alpha = 0.5,)
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/violin-1.png" alt="Violin plot" width="100%" />
<p class="caption">(\#fig:violin)Violin plot</p>
</div>

::: {.try data-latex=""}
Try changing the `quantile` argument. Set it to a vector of the numbers 0.1 to 0.9 in steps of 0.1.
:::

### Vertical intervals {#vertical_intervals}

Boxplots and violin plots don't always map well onto inferential stats that use the mean. You can represent the mean and standard error or any other value you can calculate.

Here, we will create a table with the means and standard errors for two groups. We'll learn how to calculate this from raw data in the chapter on [data wrangling](#dplyr). We also create a new object called `gg` that sets up the base of the plot. 


```r
dat <- tibble(
  group = c("A", "B"),
  mean = c(10, 20),
  se = c(2, 3)
)
gg <- ggplot(dat, aes(group, mean, 
                      ymin = mean-se, 
                      ymax = mean+se))
```

The trick above can be useful if you want to represent the same data in different ways. You can add different geoms to the base plot without having to re-type the base plot code.


```r
gg + geom_crossbar()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/geom-crossbar-1.png" alt="geom_crossbar()" width="100%" />
<p class="caption">(\#fig:geom-crossbar)geom_crossbar()</p>
</div>


```r
gg + geom_errorbar()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/geom-errorbar-1.png" alt="geom_errorbar()" width="100%" />
<p class="caption">(\#fig:geom-errorbar)geom_errorbar()</p>
</div>


```r
gg + geom_linerange()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/geom-linerange-1.png" alt="geom_linerange()" width="100%" />
<p class="caption">(\#fig:geom-linerange)geom_linerange()</p>
</div>


```r
gg + geom_pointrange()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/geom-pointrange-1.png" alt="geom_pointrange()" width="100%" />
<p class="caption">(\#fig:geom-pointrange)geom_pointrange()</p>
</div>


You can also use the function `stats_summary` to calculate mean, standard error, or any other value for your data and display it using any geom. 


```r
ggplot(pets, aes(pet, score, color=pet)) +
  stat_summary(fun.data = mean_se, geom = "crossbar") +
  stat_summary(fun.min = function(x) mean(x) - sd(x),
               fun.max = function(x) mean(x) + sd(x),
               geom = "errorbar", width = 0) +
  theme(legend.position = "none") # gets rid of the legend
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/vertint-statssum-1.png" alt="Vertical intervals with stats_summary()" width="100%" />
<p class="caption">(\#fig:vertint-statssum)Vertical intervals with stats_summary()</p>
</div>

### Scatter plot {#geom_point}

Scatter plots are a good way to represent the relationship between two continuous variables.


```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_point()
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/scatter-1.png" alt="Scatter plot using geom_point()" width="100%" />
<p class="caption">(\#fig:scatter)Scatter plot using geom_point()</p>
</div>

### Line graph {#geom_smooth}

You often want to represent the relationship as a single line.


```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm")
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/smooth-1.png" alt="Line plot using geom_smooth()" width="100%" />
<p class="caption">(\#fig:smooth)Line plot using geom_smooth()</p>
</div>

::: {.try data-latex=""}
What are some other options for the `method` argument to `geom_smooth`? When might you want to use them?
:::

::: {.info data-latex=""}
You can plot functions other than the linear `y ~ x`. The code below creates a data table where `x` is 101 values between -10 and 10. and `y` is `x` squared plus `3*x` plus `1`. You'll probably recognise this from algebra as the quadratic equation. You can set the `formula` argument in `geom_smooth` to a quadratic formula (`y ~ x + I(x^2)`) to fit a quadratic function to the data.


```r
quad <- tibble(
  x = seq(-10, 10, length.out = 101),
  y = x^2 + 3*x + 1
)

ggplot(quad, aes(x, y)) +
  geom_point() +
  geom_smooth(formula = y ~ x + I(x^2), 
              method="lm")
```

<div class="figure" style="text-align: center">
<img src="03-ggplot_files/figure-html/quadratic-1.png" alt="Fitting quadratic functions" width="100%" />
<p class="caption">(\#fig:quadratic)Fitting quadratic functions</p>
</div>
:::

## Customisation

### Size and Position {#custom-size}

You can change the size, aspect ratio and position of plots in an R Markdown document in the setup chunk.


```r
knitr::opts_chunk$set(
  fig.width  = 8, # figures default to 8 inches wide
  fig.height = 5, # figures default to 5 inches tall
  fig.path   = 'images/', # figures saved in images directory
  out.width = "90%", # images take up 90% of page width
  fig.align = 'center' # centre images
)
```

You can change defaults for any single image using <a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>chunk</a> options.

<div class='verbatim'><code>&#96;&#96;&#96;{r fig-pet1, fig.width=10, fig.height=3, out.width="100%", fig.align="center", fig.cap="10x3 inches at 100% width centre aligned."}</code>

```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y~x, method = lm)
```

<code>&#96;&#96;&#96;</code></div>
<div class="figure" style="text-align: center">
<img src="images/fig-chunk-example1-out-1.png" alt="10x3 inches at 100% width centre aligned." width="100%" />
<p class="caption">(\#fig:fig-chunk-example1-out)10x3 inches at 100% width centre aligned.</p>
</div>

<div class='verbatim'><code>&#96;&#96;&#96;{r fig-pet2, fig.width=5, fig.height=3, out.width="50%", fig.align="left", fig.cap="5x3 inches at 50% width aligned left."}</code>

```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y~x, method = lm)
```

<code>&#96;&#96;&#96;</code></div>

<div class="figure" style="text-align: left">
<img src="images/fig-chunk-example2-out-1.png" alt="5x3 inches at 50% width aligned left." width="50%" />
<p class="caption">(\#fig:fig-chunk-example2-out)5x3 inches at 50% width aligned left.</p>
</div>

### Labels {#custom-labels}

You can set custom titles and axis labels in a few different ways.


```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm") +
  labs(title = "Pet Score with Age",
       x = "Age (in Years)",
       y = "Pet Score",
       color = "Pet Type")
```

<div class="figure" style="text-align: center">
<img src="images/line-labels1-1.png" alt="Set custom labels with labs()" width="90%" />
<p class="caption">(\#fig:line-labels1)Set custom labels with labs()</p>
</div>


```r
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm") +
  ggtitle("Pet Score with Age") +
  xlab("Age (in Years)") +
  ylab("Pet Score")
```

<div class="figure" style="text-align: center">
<img src="images/line-labels2-1.png" alt="Set custom labels with individual functions" width="90%" />
<p class="caption">(\#fig:line-labels2)Set custom labels with individual functions</p>
</div>
























































