# Probability & Simulation {#sim}

<img src="images/memes/sim.jpg" class="meme right"
     alt="Morpheus from The Matrix. Top text: What if I told you; Bottom text: Ur in a simulation, inside a simulation, inside another simulation, inside a taco, inside a taco cat, inside a Taco Bell, inside an Arby's. Inside another simulation" />

## Learning Objectives {#ilo-sim}

### Basic

1. Generate and plot data randomly sampled from common distributions [(video)](https://youtu.be/iuecrT3q1kg){class="video"}
    + [uniform](#uniform)
    + [binomial](#binomial)
    + [normal](#normal)
    + [poisson](#poisson)
2. Generate related variables from a [multivariate](#mvdist) distribution [(video)](https://youtu.be/B14HfWQ1kIc){class="video"}
2. Define the following [statistical terms](#stat-terms):
    + [p-value](#p-value)
    + [alpha](#alpha)
    + [power](#power)
    + smallest effect size of interest ([SESOI](#sesoi))
    + [false positive](#false-pos) (type I error)
    + [false negative](#false-neg) (type II error)
    + confidence interval ([CI](#conf-inf))
3. Test sampled distributions against a null hypothesis [(video)](https://youtu.be/Am3G6rA2S1s){class="video"} 
    + [exact binomial test](#exact-binom)
    + [t-test](#t-test) (1-sample, independent samples, paired samples)
    + [correlation](#correlation) (pearson, kendall and spearman)
4. [Calculate power](#calc-power-binom) using iteration and a sampling function

### Intermediate

6. Calculate the minimum sample size for a specific power level and design


## Resources {#resources8}

* [Distribution Shiny App](http://shiny.psy.gla.ac.uk/debruine/simulate/) (or run `reprores::app("simulate")`
* [Simulation tutorials](https://debruine.github.io/tutorials/sim-data.html)
* [Chapter 21: Iteration](http://r4ds.had.co.nz/iteration.html)  of *R for Data Science*
* [Improving your statistical inferences](https://www.coursera.org/learn/statistical-inferences/) on Coursera (week 1)
* [Faux](https://debruine.github.io/faux/) package for data simulation
* [Simulation-Based Power-Analysis for Factorial ANOVA Designs](https://psyarxiv.com/baxsf) [@lakens_caldwell_2019]
* [Understanding mixed effects models through data simulation](https://psyarxiv.com/xp5cy/) [@debruine_barr_2019]

## Setup {#setup8}


```r
# libraries needed for these examples
library(tidyverse)
library(plotly)
library(faux)

set.seed(8675309) # makes sure random numbers are reproducible
```

Simulating data is a very powerful way to test your understanding of statistical concepts. We are going to use <a class='glossary' target='_blank' title='Generating data from summary parameters' href='https://psyteachr.github.io/glossary/s#simulation'>simulations</a> to learn the basics of <a class='glossary' target='_blank' title='A number between 0 and 1 where 0 indicates impossibility of the event and 1 indicates certainty' href='https://psyteachr.github.io/glossary/p#probability'>probability</a>.

## Univariate Distributions

First, we need to understand some different ways data might be distributed and how to simulate data from these distributions. A <a class='glossary' target='_blank' title='Relating to a single variable.' href='https://psyteachr.github.io/glossary/u#univariate'>univariate</a> distribution is the distribution of a single variable.

### Uniform Distribution {#uniform}

The <a class='glossary' target='_blank' title='A distribution where all numbers in the range have an equal probability of being sampled' href='https://psyteachr.github.io/glossary/u#uniform-distribution'>uniform distribution</a> is the simplest distribution. All numbers in the range have an equal probability of being sampled.

::: {.try data-latex=""}
Take a minute to think of things in your own research that are uniformly distributed.
:::

#### Continuous distribution

`runif(n, min=0, max=1)` 

Use `runif()` to sample from a continuous uniform distribution.


```r
u <- runif(100000, min = 0, max = 1)

# plot to visualise
ggplot() + 
  geom_histogram(aes(u), binwidth = 0.05, boundary = 0,
                 fill = "white", colour = "black")
```

<img src="10-sim_files/figure-epub3/runif-1.png" width="100%" style="display: block; margin: auto;" />

#### Discrete

`sample(x, size, replace = FALSE, prob = NULL)`

Use `sample()` to sample from a <a class='glossary' target='_blank' title='Data that can only take certain values, such as integers.' href='https://psyteachr.github.io/glossary/d#discrete'>discrete</a> distribution.

You can use `sample()` to simulate events like rolling dice or choosing from a deck of cards. The code below simulates rolling a 6-sided die 10000 times. We set `replace` to `TRUE` so that each event is independent. See what happens if you set `replace` to `FALSE`.


```r
rolls <- sample(1:6, 10000, replace = TRUE)

# plot the results
ggplot() + 
  geom_histogram(aes(rolls), binwidth = 1, 
                 fill = "white", color = "black")
```

<div class="figure" style="text-align: center">
<img src="10-sim_files/figure-epub3/sample-replace-1.png" alt="Distribution of dice rolls." width="100%" />
<p class="caption">(\#fig:sample-replace)Distribution of dice rolls.</p>
</div>

You can also use sample to sample from a list of named outcomes.


```r
pet_types <- c("cat", "dog", "ferret", "bird", "fish")
sample(pet_types, 10, replace = TRUE)
```

```
##  [1] "cat"    "cat"    "cat"    "cat"    "ferret" "dog"    "bird"   "cat"   
##  [9] "dog"    "fish"
```

Ferrets are a much less common pet than cats and dogs, so our sample isn't very realistic. You can set the probabilities of each item in the list with the `prob` argument.


```r
pet_types <- c("cat", "dog", "ferret", "bird", "fish")
pet_prob <- c(0.3, 0.4, 0.1, 0.1, 0.1)
sample(pet_types, 10, replace = TRUE, prob = pet_prob)
```

```
##  [1] "fish" "dog"  "cat"  "dog"  "cat"  "dog"  "fish" "dog"  "cat"  "fish"
```


### Binomial Distribution {#binomial}

The <a class='glossary' target='_blank' title='The distribution of data where each observation can have one of two outcomes, like success/failure, yes/no or head/tails. ' href='https://psyteachr.github.io/glossary/b#binomial-distribution'>binomial distribution</a> is useful for modelling binary data, where each observation can have one of two outcomes, like success/failure, yes/no or head/tails. 


`rbinom(n, size, prob)`

The `rbinom` function will generate a random binomial distribution.

* `n` = number of observations
* `size` = number of trials
* `prob` = probability of success on each trial

Coin flips are a typical example of a binomial distribution, where we can assign heads to 1 and tails to 0.


```r
# 20 individual coin flips of a fair coin
rbinom(20, 1, 0.5)
```

```
##  [1] 1 1 1 0 1 1 0 1 0 0 1 1 1 0 0 0 1 0 0 0
```



```r
# 20 individual coin flips of a baised (0.75) coin
rbinom(20, 1, 0.75)
```

```
##  [1] 1 1 1 0 1 0 1 1 1 0 1 1 1 0 0 1 1 1 1 1
```

You can generate the total number of heads in 1 set of 20 coin flips by setting `size` to 20 and `n` to 1.


```r
rbinom(1, 20, 0.75)
```

```
## [1] 13
```

You can generate more sets of 20 coin flips by increasing the `n`.


```r
rbinom(10, 20, 0.5)
```

```
##  [1] 10 14 11  7 11 13  6 10  9  9
```

You should always check your randomly generated data to check that it makes sense. For large samples, it's easiest to do that graphically. A histogram is usually the best choice for plotting binomial data.


```r
flips <- rbinom(1000, 20, 0.5)

ggplot() +
  geom_histogram(
    aes(flips), 
    binwidth = 1, 
    fill = "white", 
    color = "black"
  )
```

<img src="10-sim_files/figure-epub3/sim_flips-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
Run the simulation above several times, noting how the histogram changes. Try changing the values of `n`, `size`, and `prob`.
:::


### Normal Distribution {#normal}

`rnorm(n, mean, sd)`

We can simulate a <a class='glossary' target='_blank' title='A symmetric distribution of data where values near the centre are most probable.' href='https://psyteachr.github.io/glossary/n#normal-distribution'>normal distribution</a> of size `n` if we know the `mean` and standard deviation (`sd`). A density plot is usually the best way to visualise this type of data if your `n` is large.


```r
dv <- rnorm(1e5, 10, 2)

# proportions of normally-distributed data 
# within 1, 2, or 3 SD of the mean
sd1 <- .6827 
sd2 <- .9545
sd3 <- .9973

ggplot() +
  geom_density(aes(dv), fill = "white") +
  geom_vline(xintercept = mean(dv), color = "red") +
  geom_vline(xintercept = quantile(dv, .5 - sd1/2), color = "darkgreen") +
  geom_vline(xintercept = quantile(dv, .5 + sd1/2), color = "darkgreen") +
  geom_vline(xintercept = quantile(dv, .5 - sd2/2), color = "blue") +
  geom_vline(xintercept = quantile(dv, .5 + sd2/2), color = "blue") +
  geom_vline(xintercept = quantile(dv, .5 - sd3/2), color = "purple") +
  geom_vline(xintercept = quantile(dv, .5 + sd3/2), color = "purple") +
  scale_x_continuous(
    limits = c(0,20), 
    breaks = seq(0,20)
  )
```

<img src="10-sim_files/figure-epub3/rnorm-1.png" width="100%" style="display: block; margin: auto;" />

::: {.info data-latex=""}
Run the simulation above several times, noting how the density plot changes. What do the vertical lines represent? Try changing the values of `n`, `mean`, and `sd`.
:::


### Poisson Distribution {#poisson}

The <a class='glossary' target='_blank' title='A distribution that models independent events happening over a unit of time' href='https://psyteachr.github.io/glossary/p#poisson-distribution'>Poisson distribution</a> is useful for modelling events, like how many times something happens over a unit of time, as long as the events are independent (e.g., an event having happened in one time period doesn't make it more or less likely to happen in the next).

`rpois(n, lambda)`

The `rpois` function will generate a random Poisson distribution.

* `n` = number of observations
* `lambda` = the mean number of events per observation

Let's say we want to model how many texts you get each day for a whole. You know that you get an average of 20 texts per day. So we set `n = 365` and `lambda = 20`. Lambda is a <a class='glossary' target='_blank' title='A value that describes a distribution, such as the mean or SD' href='https://psyteachr.github.io/glossary/p#parameter'>parameter</a> that describes the Poisson distribution, just like mean and standard deviation are parameters that describe the normal distribution.


```r
texts <- rpois(n = 365, lambda = 20)

ggplot() +
  geom_histogram(
    aes(texts), 
    binwidth = 1, 
    fill = "white", 
    color = "black"
  )
```

<img src="10-sim_files/figure-epub3/rpois-1.png" width="100%" style="display: block; margin: auto;" />

So we can see that over a year, you're unlikely to get fewer than 5 texts in a day, or more than 35 (although it's not impossible).

## Multivariate Distributions {#mvdist}

### Bivariate Normal {#bvn}

A <a class='glossary' target='_blank' title='Two normally distributed vectors that have a specified correlation with each other.' href='https://psyteachr.github.io/glossary/b#bivariate-normal'>bivariate normal</a> distribution is two normally distributed vectors that have a specified relationship, or <a class='glossary' target='_blank' title='The relationship two vectors have to each other.' href='https://psyteachr.github.io/glossary/c#correlation'>correlation</a> to each other.

What if we want to sample from a population with specific relationships between variables? We can sample from a bivariate normal distribution using `mvrnorm()` from the `MASS` package. 

::: {.warning data-latex=""}
Don't load MASS with the `library()` function because it will create a conflict with the `select()` function from dplyr and you will always need to preface it with `dplyr::`. Just use `MASS::mvrnorm()`.
:::

You need to know how many observations you want to simulate (`n`) the means of the two variables (`mu`) and you need to calculate a <a class='glossary' target='_blank' title='Parameters showing how a set of vectors vary and are correlated.' href='https://psyteachr.github.io/glossary/c#covariance-matrix'>covariance matrix</a> (`sigma`) from the correlation between the variables (`rho`) and their standard deviations (`sd`).


```r
n   <- 1000 # number of random samples
# name the mu values to give the resulting columns names
mu     <- c(x = 10, y = 20) # the means of the samples
sd <- c(5, 6)   # the SDs of the samples

rho <- 0.5  # population correlation between the two variables

# correlation matrix
cor_mat <- matrix(c(  1, rho, 
                    rho,   1), 2) 

# create the covariance matrix
sigma <- (sd %*% t(sd)) * cor_mat

# sample from bivariate normal distribution
bvn <- MASS::mvrnorm(n, mu, sigma) 
```

Plot your sampled variables to check everything worked like you expect. It's easiest to convert the output of `mvnorm` into a tibble in order to use it in ggplot.


```r
bvn %>%
  as_tibble() %>%
  ggplot(aes(x, y)) +
    geom_point(alpha = 0.5) + 
    geom_smooth(method = "lm") +
    geom_density2d()
```

```
## `geom_smooth()` using formula 'y ~ x'
```

<img src="10-sim_files/figure-epub3/graph-bvn-1.png" width="100%" style="display: block; margin: auto;" />

### Multivariate Normal {#mvnorm}

You can generate more than 2 correlated variables, but it gets a little trickier to create the correlation matrix.



```r
n      <- 200 # number of random samples
mu     <- c(x = 10, y = 20, z = 30) # the means of the samples
sd <- c(8, 9, 10)   # the SDs of the samples

rho1_2 <- 0.5 # correlation between x and y
rho1_3 <- 0   # correlation between x and z
rho2_3 <- 0.7 # correlation between y and z

# correlation matrix
cor_mat <- matrix(c(     1, rho1_2, rho1_3, 
                    rho1_2,      1, rho2_3,
                    rho1_3, rho2_3,      1), 3) 

sigma <- (sd %*% t(sd)) * cor_mat
bvn3 <- MASS::mvrnorm(n, mu, sigma)

cor(bvn3) # check correlation matrix
```

```
##           x         y         z
## x 1.0000000 0.5896674 0.1513108
## y 0.5896674 1.0000000 0.7468737
## z 0.1513108 0.7468737 1.0000000
```


You can use the `plotly` library to make a 3D graph.


```r
#set up the marker style
marker_style = list(
    color = "#ff0000", 
    line = list(
      color = "#444", 
      width = 1
    ), 
    opacity = 0.5,
    size = 5
  )

# convert bvn3 to a tibble, plot and add markers
bvn3 %>%
  as_tibble() %>%
  plot_ly(x = ~x, y = ~y, z = ~z, marker = marker_style) %>%
  add_markers()
```

<img src="10-sim_files/figure-epub3/3d-graph-mvn-1.png" width="100%" style="display: block; margin: auto;" />

### Faux

Alternatively, you can use the package [faux](https://debruine.github.io/faux/){target="_blank"} to generate any number of correlated variables. It also has a function for checking the parameters of your new simulated data (`check_sim_stats()`).


```r
bvn3 <- rnorm_multi(
  n = n, 
  vars = 3,
  mu = mu, 
  sd = sd,
  r = c(rho1_2, rho1_3, rho2_3),
  varnames = c("x", "y", "z")
)

check_sim_stats(bvn3)
```

```
##     n var    x    y    z  mean   sd
## 1 200   x 1.00 0.54 0.05 10.23 7.92
## 2 200   y 0.54 1.00 0.65 19.94 8.72
## 3 200   z 0.05 0.65 1.00 30.09 9.51
```

You can also use faux to simulate data for factorial designs. Set up the between-subject and within-subject factors as lists with the levels as (named) vectors. Means and standard deviations can be included as vectors or data frames. The function calculates sigma for you, structures your dataset, and outputs a plot of the design.


```r
b <- list(pet = c(cat = "Cat Owners",
                  dog = "Dog Owners"))
w <- list(time = c("morning",
                   "noon",
                   "night"))
mu <- data.frame(
  cat    = c(10, 12, 14),
  dog    = c(10, 15, 20),
  row.names = w$time
)
sd <- c(3, 3, 3, 5, 5, 5)

pet_data <- sim_design(
  within = w, 
  between = b,
  n = 100, 
  mu = mu,
  sd = sd, 
  r = .5)
```

<img src="10-sim_files/figure-epub3/faux-sim-design-1.png" width="100%" style="display: block; margin: auto;" />

You can use the `check_sim_stats()` function, but you need to set the argument `between` to a vector of all the between-subject factor columns.


```r
check_sim_stats(pet_data, between = "pet")
```

```
##   pet   n     var morning noon night  mean   sd
## 1 cat 100 morning    1.00 0.52  0.48 10.79 3.40
## 2 cat 100    noon    0.52 1.00  0.50 12.41 2.88
## 3 cat 100   night    0.48 0.50  1.00 14.64 3.13
## 4 dog 100 morning    1.00 0.55  0.44  9.65 4.74
## 5 dog 100    noon    0.55 1.00  0.46 14.45 5.69
## 6 dog 100   night    0.44 0.46  1.00 19.86 5.46
```

See the [faux website](https://debruine.github.io/faux/){target="_blank"} for more detailed tutorials.


## Statistical terms {#stat-terms}

Let's review some important statistical terms before we review tests of distributions. 

### Effect {#effect}

The <a class='glossary' target='_blank' title='Some measure of your data, such as the mean value, or the number of standard deviations the mean differs from a chance value.' href='https://psyteachr.github.io/glossary/e#effect'>effect</a> is some measure of your data. This will depend on the type of data you have and the type of statistical test you are using. For example, if you flipped a coin 100 times and it landed heads 66 times, the effect would be 66/100. You can then use the exact binomial test to compare this effect to the <a class='glossary' target='_blank' title='An outcome that does not show an otherwise expected effect.' href='https://psyteachr.github.io/glossary/n#null-effect'>null effect</a> you would expect from a fair coin (50/100) or to any other effect you choose. The <a class='glossary' target='_blank' title='The difference between the effect in your data and the null effect (usually a chance value)' href='https://psyteachr.github.io/glossary/e#effect-size'>effect size</a> refers to the difference between the effect in your data and the null effect (usually a chance value).

<img src="images/memes/p-value.jpg" class="meme right" />

### P-value {#p-value}

The <a class='glossary' target='_blank' title='The probability of seeing an effect at least as extreme as what you have, if the real effect was the value you are testing against (e.g., a null effect)' href='https://psyteachr.github.io/glossary/p#p-value'>p-value</a> of a test is the probability of seeing an effect at least as extreme as what you have, if the real effect was the value you are testing against (e.g., a null effect). So if you used a binomial test to test against a chance probability of 1/6 (e.g., the probability of rolling 1 with a 6-sided die), then a p-value of 0.17 means that you could expect to see effects at least as extreme as your data 17% of the time just by chance alone. 

### Alpha {#alpha}

If you are using null hypothesis significance testing (<a class='glossary' target='_blank' title='Null Hypothesis Signficance Testing' href='https://psyteachr.github.io/glossary/n#nhst'>NHST</a>), then you need to decide on a cutoff value (<a class='glossary' target='_blank' title='(stats) The cutoff value for making a decision to reject the null hypothesis; (graphics) A value between 0 and 1 used to control the levels of transparency in a plot' href='https://psyteachr.github.io/glossary/a#alpha'>alpha</a>) for making a decision to reject the null hypothesis. We call p-values below the alpha cutoff <a class='glossary' target='_blank' title='The conclusion when the p-value is less than the critical alpha. ' href='https://psyteachr.github.io/glossary/s#significant'>significant</a>. In psychology, alpha is traditionally set at 0.05, but there are good arguments for [setting a different criterion in some circumstances](http://daniellakens.blogspot.com/2019/05/justifying-your-alpha-by-minimizing-or.html). 

### False Positive/Negative {#false-pos}

The probability that a test concludes there is an effect when there is really no effect (e.g., concludes a fair coin is biased) is called the <a class='glossary' target='_blank' title='When a test concludes there is an effect when there really is no effect' href='https://psyteachr.github.io/glossary/f#false-positive'>false positive</a> rate (or <a class='glossary' target='_blank' title='A false positive; When a test concludes there is an effect when there is really is no effect' href='https://psyteachr.github.io/glossary/t#type-i-error'>Type I Error</a> Rate). The <a class='glossary' target='_blank' title='(stats) The cutoff value for making a decision to reject the null hypothesis; (graphics) A value between 0 and 1 used to control the levels of transparency in a plot' href='https://psyteachr.github.io/glossary/a#alpha'>alpha</a> is the false positive rate we accept for a test. The probability that a test concludes there is no effect when there really is one (e.g., concludes a biased coin is fair) is called the <a class='glossary' target='_blank' title='When a test concludes there is no effect when there really is an effect' href='https://psyteachr.github.io/glossary/f#false-negative'>false negative</a> rate (or <a class='glossary' target='_blank' title='A false negative; When a test concludes there is no effect when there is really is an effect' href='https://psyteachr.github.io/glossary/t#type-ii-error'>Type II Error</a> Rate). The <a class='glossary' target='_blank' title='The false negative rate we accept for a statistical test.' href='https://psyteachr.github.io/glossary/b#beta'>beta</a> is the false negative rate we accept for a test.

::: {.info data-latex=""}
The false positive rate is not the overall probability of getting a false positive, but the probability of a false positive *under the null hypothesis*. Similarly, the false negative rate is the probability of a false negative *under the alternative hypothesis*. Unless we know the probability that we are testing a null effect, we can't say anything about the overall probability of false positives or negatives. If 100% of the hypotheses we test are false, then all significant effects are false positives, but if all of the hypotheses we test are true, then all of the positives are true positives and the overall false positive rate is 0.
:::

### Power and SESOI {#power}

<a class='glossary' target='_blank' title='The probability of rejecting the null hypothesis when it is false.' href='https://psyteachr.github.io/glossary/p#power'>Power</a> is equal to 1 minus beta (i.e., the <a class='glossary' target='_blank' title='When a test concludes there is an effect when there is really is an effect' href='https://psyteachr.github.io/glossary/t#true-positive'>true positive</a> rate), and depends on the effect size, how many samples we take (n), and what we set alpha to. For any test, if you specify all but one of these values, you can calculate the last. The effect size you use in power calculations should be the smallest effect size of interest (<a class='glossary' target='_blank' title='Smallest Effect Size of Interest: the smallest effect that is theoretically or practically meaningful' href='https://psyteachr.github.io/glossary/s#sesoi'>SESOI</a>). See [@TOSTtutorial](https://doi.org/10.1177/2515245918770963) for a tutorial on methods for choosing an SESOI. 

::: {.try data-latex=""}
Let's say you want to be able to detect at least a 15% difference from chance (50%) in a coin's fairness, and you want your test to have a 5% chance of false positives and a 10% chance of false negatives. What are the following values?

* alpha = <input class='webex-solveme nospaces' size='4' data-answer='["0.05",".05","5%"]'/>
* beta = <input class='webex-solveme nospaces' size='4' data-answer='["0.1","0.10",".1",".10","10%"]'/>
* false positive rate = <input class='webex-solveme nospaces' size='4' data-answer='["0.05",".05","5%"]'/>
* false negative rate = <input class='webex-solveme nospaces' size='4' data-answer='["0.1","0.10",".1",".10","10%"]'/>
* power = <input class='webex-solveme nospaces' size='4' data-answer='["0.9","0.90",".9",".90","90%"]'/>
* SESOI = <input class='webex-solveme nospaces' size='4' data-answer='["0.15",".15","15%"]'/>
:::

### Confidence Intervals {#conf-int}

The <a class='glossary' target='_blank' title='A type of interval estimate used to summarise a given statistic or measurement where a proportion of intervals calculated from the sample(s) will contain the true value of the statistic.' href='https://psyteachr.github.io/glossary/c#confidence-interval'>confidence interval</a> is a range around some value (such as a mean) that has some probability of containing the parameter, if you repeated the process many times. Traditionally in psychology, we use 95% confidence intervals, but you can calculate CIs for any percentage.

::: {.info data-latex=""}
A 95% CI does *not* mean that there is a 95% probability that the true mean lies within this range, but that, if you repeated the study many times and calculated the CI this same way every time, you'd expect the true mean to be inside the CI in 95% of the studies. This seems like a subtle distinction, but can lead to some misunderstandings. See [@Morey2016](https://link.springer.com/article/10.3758/s13423-015-0947-8) for more detailed discussion.
:::

## Tests

### Exact binomial test {#exact-binom}

`binom.test(x, n, p)`

You can test a binomial distribution against a specific probability using the exact binomial test.

* `x` = the number of successes
* `n` = the number of trials
* `p` = hypothesised probability of success

Here we can test a series of 10 coin flips from a fair coin and a biased coin against the hypothesised probability of 0.5 (even odds).


```r
n <- 10
fair_coin <- rbinom(1, n, 0.5)
biased_coin <- rbinom(1, n, 0.6)

binom.test(fair_coin, n, p = 0.5)
binom.test(biased_coin, n, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  fair_coin and n
## number of successes = 5, number of trials = 10, p-value = 1
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.187086 0.812914
## sample estimates:
## probability of success 
##                    0.5 
## 
## 
## 	Exact binomial test
## 
## data:  biased_coin and n
## number of successes = 5, number of trials = 10, p-value = 1
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.187086 0.812914
## sample estimates:
## probability of success 
##                    0.5
```

::: {.info data-latex=""}
Run the code above several times, noting the p-values for the fair and biased coins. Alternatively, you can [simulate coin flips](http://shiny.psy.gla.ac.uk/debruine/coinsim/) online and build up a graph of results and p-values. 

* How does the p-value vary for the fair and biased coins?
* What happens to the confidence intervals if you increase n from 10 to 100?
* What criterion would you use to tell if the observed data indicate the coin is fair or biased?
* How often do you conclude the fair coin is biased (false positives)? 
* How often do you conclude the biased coin is fair (false negatives)?
:::


#### Sampling function {#sampling-binom}

To estimate these rates, we need to repeat the sampling above many times. A <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> is ideal for repeating the exact same procedure over and over. Set the arguments of the function to variables that you might want to change. Here, we will want to estimate power for:

* different sample sizes (`n`)
* different effects (`bias`)
* different hypothesised probabilities (`p`, defaults to 0.5)


```r
sim_binom_test <- function(n, bias, p = 0.5) {
  # simulate 1 coin flip n times with the specified bias
  coin <- rbinom(1, n, bias)
  # run a binomial test on the simulated data for the specified p
  btest <- binom.test(coin, n, p)
  # return the p-value of this test
  btest$p.value
}
```

Once you've created your function, test it a few times, changing the values.


```r
sim_binom_test(100, 0.6)
```

```
## [1] 0.271253
```

#### Calculate power {#calc-power-binom}

Then you can use the `replicate()` function to run it many times and save all the output values. You can calculate the <a class='glossary' target='_blank' title='The probability of rejecting the null hypothesis when it is false.' href='https://psyteachr.github.io/glossary/p#power'>power</a> of your analysis by checking the proportion of your simulated analyses that have a p-value less than your <a class='glossary' target='_blank' title='(stats) The cutoff value for making a decision to reject the null hypothesis; (graphics) A value between 0 and 1 used to control the levels of transparency in a plot' href='https://psyteachr.github.io/glossary/a#alpha'>alpha</a> (the probability of rejecting the null hypothesis when the null hypothesis is true).


```r
my_reps <- replicate(1e4, sim_binom_test(100, 0.6))

alpha <- 0.05 # this does not always have to be 0.05

mean(my_reps < alpha)
```

```
## [1] 0.4565
```

::: {.info data-latex=""}
`1e4` is just scientific notation for a 1 followed by 4 zeros (`10000`). When you're running simulations, you usually want to run a lot of them. It's a pain to keep track of whether you've typed 5 or 6 zeros (100000 vs 1000000) and this will change your running time by an order of magnitude.
:::

You can plot the distribution of p-values.


```r
ggplot() + 
  geom_histogram(
    aes(my_reps), 
    binwidth = 0.05, 
    boundary = 0,
    fill = "white", 
    color = "black"
  )
```

<img src="10-sim_files/figure-epub3/plot-reps-binom-1.png" width="100%" style="display: block; margin: auto;" />


### T-test {#t-test}

`t.test(x, y, alternative, mu, paired)`

Use a t-test to compare the mean of one distribution to a null hypothesis (one-sample t-test), compare the means of two samples (independent-samples t-test), or compare pairs of values (paired-samples t-test).

You can run a one-sample t-test comparing the mean of your data to `mu`. Here is a simulated distribution with a mean of 0.5 and an SD of 1, creating an effect size of 0.5 SD when tested against a `mu` of 0. Run the simulation a few times to see how often the t-test returns a significant p-value (or run it in the [shiny app](http://shiny.psy.gla.ac.uk/debruine/normsim/)).


```r
sim_norm <- rnorm(100, 0.5, 1)
t.test(sim_norm, mu = 0)
```

```
## 
## 	One Sample t-test
## 
## data:  sim_norm
## t = 5.9355, df = 99, p-value = 4.34e-08
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  0.3679233 0.7374439
## sample estimates:
## mean of x 
## 0.5526836
```

Run an independent-samples t-test by comparing two lists of values.


```r
a <- rnorm(100, 0.5, 1)
b <- rnorm(100, 0.7, 1)
t_ind <- t.test(a, b, paired = FALSE)
t_ind
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  a and b
## t = -0.98718, df = 197.75, p-value = 0.3248
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.4344457  0.1445867
## sample estimates:
## mean of x mean of y 
## 0.5524265 0.6973560
```

::: {.warning data-latex=""}
The `paired` argument defaults to `FALSE`, but it's good practice to always explicitly set it so you are never confused about what type of test you are performing.
:::

#### Sampling function {#sampling-t}

We can use the `names()` function to find out the names of all the t.test parameters and use this to just get one type of data, like the test statistic (e.g., t-value).


```r
names(t_ind)
t_ind$statistic
```

```
##  [1] "statistic"   "parameter"   "p.value"     "conf.int"    "estimate"   
##  [6] "null.value"  "stderr"      "alternative" "method"      "data.name"  
##          t 
## -0.9871838
```

If you want to run the simulation many times and record information each time, first you need to turn your simulation into a function.


```r
sim_t_ind <- function(n, m1, sd1, m2, sd2) {
  # simulate v1
  v1 <- rnorm(n, m1, sd1)
  
  #simulate v2
  v2 <- rnorm(n, m2, sd2)
    
  # compare using an independent samples t-test
  t_ind <- t.test(v1, v2, paired = FALSE)
  
  # return the p-value
  return(t_ind$p.value)
}
```

Run it a few times to check that it gives you sensible values.


```r
sim_t_ind(100, 0.7, 1, 0.5, 1)
```

```
## [1] 0.0533657
```

#### Calculate power {#calc-power-t}

Now replicate the simulation 1000 times.


```r
my_reps <- replicate(1e4, sim_t_ind(100, 0.7, 1, 0.5, 1))

alpha <- 0.05
power <- mean(my_reps < alpha)
power
```

```
## [1] 0.2906
```

::: {.try data-latex=""}
Run the code above several times. How much does the power value fluctuate? How many replications do you need to run to get a reliable estimate of power?
:::

Compare your power estimate from simluation to a power calculation using `power.t.test()`. Here, `delta` is the difference between `m1` and `m2` above.


```r
power.t.test(n = 100, 
             delta = 0.2, 
             sd = 1, 
             sig.level = alpha, 
             type = "two.sample")
```

```
## 
##      Two-sample t test power calculation 
## 
##               n = 100
##           delta = 0.2
##              sd = 1
##       sig.level = 0.05
##           power = 0.2902664
##     alternative = two.sided
## 
## NOTE: n is number in *each* group
```

You can plot the distribution of p-values.


```r
ggplot() + 
  geom_histogram(
    aes(my_reps), 
    binwidth = 0.05, 
    boundary = 0,
    fill = "white", 
    color = "black"
  )
```

<img src="10-sim_files/figure-epub3/plot-reps-t-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
What do you think the distribution of p-values is 
when there is no effect (i.e., the means are identical)? Check this yourself.
:::

::: {.warning data-latex=""}
Make sure the `boundary` argument is set to `0` for p-value histograms. See what happens with a null effect if `boundary` is not set.
:::


### Correlation {#correlation}

You can test if continuous variables are related to each other using the `cor()` function. Let's use `rnorm_multi()` to make a quick table of correlated values.


```r
dat <- rnorm_multi(
  n = 100, 
  vars = 2, 
  r = -0.5,
  varnames = c("x", "y")
)

cor(dat$x, dat$y)
```

```
## [1] -0.4218379
```

::: {.try data-latex=""}
Set `n` to a large number like 1e6 so that the correlations are less affected by chance. Change the value of the **mean** for `a`, `x`, or `y`. Does it change the correlation between `x` and `y`? What happens when you increase or decrease the **sd**? Can you work out any rules here?
:::

`cor()` defaults to Pearson's correlations. Set the `method` argument to use Kendall or Spearman correlations.


```r
cor(dat$x, dat$y, method = "spearman")
```

```
## [1] -0.389559
```

#### Sampling function {#sampling-cor}

Create a function that creates two variables with `n` observations and `r` correlation. Use the function `cor.test()` to give you p-values for the correlation.


```r
sim_cor_test <- function(n = 100, r = 0) {
  dat <- rnorm_multi(
    n = n, 
    vars = 2, 
    r = r,
    varnames = c("x", "y")
  )

  ctest <- cor.test(dat$x, dat$y)
  ctest$p.value
}
```

Once you've created your function, test it a few times, changing the values.


```r
sim_cor_test(50, .5)
```

```
## [1] 0.0002660767
```

#### Calculate power {#calc-power-cor}

Now replicate the simulation 1000 times.


```r
my_reps <- replicate(1e4, sim_cor_test(50, 0.5))

alpha <- 0.05
power <- mean(my_reps < alpha)
power
```

```
## [1] 0.97
```

Compare to the value calcuated by the pwr package.


```r
pwr::pwr.r.test(n = 50, r = 0.5)
```

```
## 
##      approximate correlation power calculation (arctangh transformation) 
## 
##               n = 50
##               r = 0.5
##       sig.level = 0.05
##           power = 0.9669813
##     alternative = two.sided
```


## Example

This example uses the [Growth Chart Data Tables](https://www.cdc.gov/growthcharts/data/zscore/zstatage.csv) from the [US CDC](https://www.cdc.gov/growthcharts/zscore.htm). The data consist of height in centimeters for the z-scores of –2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, and 2 by sex (1=male; 2=female) and half-month of age (from 24.0 to 240.5 months).

### Load & wrangle

We have to do a little data wrangling first. Have a look at the data after you import it and relabel `Sex` to `male` and `female` instead of `1` and `2`. Also convert `Agemos` (age in months) to years. Relabel the column `0` as `mean` and calculate a new column named `sd` as the difference between columns `1` and `0`. 


```r
orig_height_age <- read_csv("https://www.cdc.gov/growthcharts/data/zscore/zstatage.csv") 
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Sex = col_character(),
##   Agemos = col_character(),
##   `-2` = col_double(),
##   `-1.5` = col_double(),
##   `-1` = col_double(),
##   `-0.5` = col_double(),
##   `0` = col_double(),
##   `0.5` = col_double(),
##   `1` = col_double(),
##   `1.5` = col_double(),
##   `2` = col_double()
## )
```

```r
height_age <- orig_height_age %>%
  filter(Sex %in% c(1,2)) %>%
  mutate(
    sex = recode(Sex, "1" = "male", "2" = "female"),
    age = as.numeric(Agemos)/12,
    sd = `1` - `0`
  ) %>%
  select(sex, age, mean = `0`, sd)
```


### Plot

Plot your new data frame to see how mean height changes with age for boys and girls.


```r
ggplot(height_age, aes(age, mean, color = sex)) +
  geom_smooth(aes(ymin = mean - sd, 
                  ymax = mean + sd),
              stat="identity")
```

<img src="10-sim_files/figure-epub3/plot-height-means-1.png" width="100%" style="display: block; margin: auto;" />

### Simulate a population

Simulate 50 random male heights and 50 random female heights for 20-year-olds using the `rnorm()` function and the means and SDs from the `height_age` table. Plot the data.


```r
age_filter <- 20
m <- filter(height_age, age == age_filter, sex == "male")
f <- filter(height_age, age == age_filter, sex == "female")

sim_height <- tibble(
  male = rnorm(50, m$mean, m$sd),
  female = rnorm(50, f$mean, f$sd)
) %>%
  gather("sex", "height", male:female)

ggplot(sim_height) +
  geom_density(aes(height, fill = sex), alpha = 0.5) +
  xlim(125, 225)
```

<img src="10-sim_files/figure-epub3/sim-height-20-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
Run the simulation above several times, noting how the density plot changes. Try changing the age you're simulating.
:::

### Analyse simulated data

Use the `sim_t_ind(n, m1, sd1, m2, sd2)` function we created above to generate one simulation with a sample size of 50 in each group using the means and SDs of male and female 14-year-olds.


```r
age_filter <- 14
m <- filter(height_age, age == age_filter, sex == "male")
f <- filter(height_age, age == age_filter, sex == "female")

sim_t_ind(50, m$mean, m$sd, f$mean, f$sd)
```

```
## [1] 0.001543531
```

### Replicate simulation

Now replicate this 1e4 times using the `replicate()` function. This function will save the returned p-values in a list (`my_reps`). We can then check what proportion of those p-values are less than our alpha value. This is the power of our test.


```r
my_reps <- replicate(1e4, sim_t_ind(50, m$mean, m$sd, f$mean, f$sd))

alpha <- 0.05
power <- mean(my_reps < alpha)
power
```

```
## [1] 0.6405
```

### One-tailed prediction

This design has about 65% power to detect the sex difference in height (with a 2-tailed test). Modify the `sim_t_ind` function for a 1-tailed prediction.

You could just set `alternative` equal to "greater" in the function, but it might be better to add the `alt` argument to your function (giving it the same default value as `t.test`) and change the value of `alternative` in the function to `alt`.


```r
sim_t_ind <- function(n, m1, sd1, m2, sd2, alt = "two.sided") {
  v1 <- rnorm(n, m1, sd1)
  v2 <- rnorm(n, m2, sd2)
  t_ind <- t.test(v1, v2, paired = FALSE, alternative = alt)
  
  return(t_ind$p.value)
}

alpha <- 0.05
my_reps <- replicate(1e4, sim_t_ind(50, m$mean, m$sd, f$mean, f$sd, "greater"))
mean(my_reps < alpha)
```

```
## [1] 0.7613
```

### Range of sample sizes

What if we want to find out what sample size will give us 80% power? We can try trial and error. We know the number should be slightly larger than 50. But you can search more systematically by repeating your power calculation for a range of sample sizes. 

::: {.info data-latex=""}
This might seem like overkill for a t-test, where you can easily look up sample size calculators online, but it is a valuable skill to learn for when your analyses become more complicated.
:::

Start with a relatively low number of replications and/or more spread-out samples to estimate where you should be looking more specifically. Then you can repeat with a narrower/denser range of sample sizes and more iterations.


```r
# make another custom function to return power
pwr_func <- function(n, reps = 100, alpha = 0.05) {
  ps <- replicate(reps, sim_t_ind(n, m$mean, m$sd, f$mean, f$sd, "greater"))
  mean(ps < alpha)
}

# make a table of the n values you want to check
power_table <- tibble(
  n = seq(20, 100, by = 5)
) %>%
  # run the power function for each n
  mutate(power = map_dbl(n, pwr_func))

# plot the results
ggplot(power_table, aes(n, power)) +
  geom_smooth() +
  geom_point() +
  geom_hline(yintercept = 0.8)
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

<img src="10-sim_files/figure-epub3/range-sample-sizes-1.png" width="100%" style="display: block; margin: auto;" />

Now we can narrow down our search to values around 55 (plus or minus 5) and increase the number of replications from 1e3 to 1e4.


```r
power_table <- tibble(
  n = seq(50, 60)
) %>%
  mutate(power = map_dbl(n, pwr_func, reps = 1e4))

ggplot(power_table, aes(n, power)) +
 geom_smooth() +
 geom_point() +
 geom_hline(yintercept = 0.8)
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

<img src="10-sim_files/figure-epub3/narrow-range-sample-sizes-1.png" width="100%" style="display: block; margin: auto;" />

## Glossary {#glossary-sim}



|term                                                                                                                         |definition                                                                                                                                                                                 |
|:----------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|[alpha](https://psyteachr.github.io/glossary/a.html#alpha){class="glossary" target="_blank"}                                 |(stats) The cutoff value for making a decision to reject the null hypothesis; (graphics) A value between 0 and 1 used to control the levels of transparency in a plot                      |
|[beta](https://psyteachr.github.io/glossary/b.html#beta){class="glossary" target="_blank"}                                   |The false negative rate we accept for a statistical test.                                                                                                                                  |
|[binomial distribution](https://psyteachr.github.io/glossary/b.html#binomial-distribution){class="glossary" target="_blank"} |The distribution of data where each observation can have one of two outcomes, like success/failure, yes/no or head/tails.                                                                  |
|[bivariate normal](https://psyteachr.github.io/glossary/b.html#bivariate-normal){class="glossary" target="_blank"}           |Two normally distributed vectors that have a specified correlation with each other.                                                                                                        |
|[confidence interval](https://psyteachr.github.io/glossary/c.html#confidence-interval){class="glossary" target="_blank"}     |A type of interval estimate used to summarise a given statistic or measurement where a proportion of intervals calculated from the sample(s) will contain the true value of the statistic. |
|[correlation](https://psyteachr.github.io/glossary/c.html#correlation){class="glossary" target="_blank"}                     |The relationship two vectors have to each other.                                                                                                                                           |
|[covariance matrix](https://psyteachr.github.io/glossary/c.html#covariance-matrix){class="glossary" target="_blank"}         |Parameters showing how a set of vectors vary and are correlated.                                                                                                                           |
|[discrete](https://psyteachr.github.io/glossary/d.html#discrete){class="glossary" target="_blank"}                           |Data that can only take certain values, such as integers.                                                                                                                                  |
|[effect](https://psyteachr.github.io/glossary/e.html#effect){class="glossary" target="_blank"}                               |Some measure of your data, such as the mean value, or the number of standard deviations the mean differs from a chance value.                                                              |
|[effect size](https://psyteachr.github.io/glossary/e.html#effect-size){class="glossary" target="_blank"}                     |The difference between the effect in your data and the null effect (usually a chance value)                                                                                                |
|[false negative](https://psyteachr.github.io/glossary/f.html#false-negative){class="glossary" target="_blank"}               |When a test concludes there is no effect when there really is an effect                                                                                                                    |
|[false positive](https://psyteachr.github.io/glossary/f.html#false-positive){class="glossary" target="_blank"}               |When a test concludes there is an effect when there really is no effect                                                                                                                    |
|[function](https://psyteachr.github.io/glossary/f.html#function){class="glossary" target="_blank"}                           |A named section of code that can be reused.                                                                                                                                                |
|[nhst](https://psyteachr.github.io/glossary/n.html#nhst){class="glossary" target="_blank"}                                   |Null Hypothesis Signficance Testing                                                                                                                                                        |
|[normal distribution](https://psyteachr.github.io/glossary/n.html#normal-distribution){class="glossary" target="_blank"}     |A symmetric distribution of data where values near the centre are most probable.                                                                                                           |
|[null effect](https://psyteachr.github.io/glossary/n.html#null-effect){class="glossary" target="_blank"}                     |An outcome that does not show an otherwise expected effect.                                                                                                                                |
|[p value](https://psyteachr.github.io/glossary/p.html#p-value){class="glossary" target="_blank"}                             |The probability of seeing an effect at least as extreme as what you have, if the real effect was the value you are testing against (e.g., a null effect)                                   |
|[parameter](https://psyteachr.github.io/glossary/p.html#parameter){class="glossary" target="_blank"}                         |A value that describes a distribution, such as the mean or SD                                                                                                                              |
|[poisson distribution](https://psyteachr.github.io/glossary/p.html#poisson-distribution){class="glossary" target="_blank"}   |A distribution that models independent events happening over a unit of time                                                                                                                |
|[power](https://psyteachr.github.io/glossary/p.html#power){class="glossary" target="_blank"}                                 |The probability of rejecting the null hypothesis when it is false.                                                                                                                         |
|[probability](https://psyteachr.github.io/glossary/p.html#probability){class="glossary" target="_blank"}                     |A number between 0 and 1 where 0 indicates impossibility of the event and 1 indicates certainty                                                                                            |
|[sesoi](https://psyteachr.github.io/glossary/s.html#sesoi){class="glossary" target="_blank"}                                 |Smallest Effect Size of Interest: the smallest effect that is theoretically or practically meaningful                                                                                      |
|[significant](https://psyteachr.github.io/glossary/s.html#significant){class="glossary" target="_blank"}                     |The conclusion when the p-value is less than the critical alpha.                                                                                                                           |
|[simulation](https://psyteachr.github.io/glossary/s.html#simulation){class="glossary" target="_blank"}                       |Generating data from summary parameters                                                                                                                                                    |
|[true positive](https://psyteachr.github.io/glossary/t.html#true-positive){class="glossary" target="_blank"}                 |When a test concludes there is an effect when there is really is an effect                                                                                                                 |
|[type i error](https://psyteachr.github.io/glossary/t.html#type-i-error){class="glossary" target="_blank"}                   |A false positive; When a test concludes there is an effect when there is really is no effect                                                                                               |
|[type ii error](https://psyteachr.github.io/glossary/t.html#type-ii-error){class="glossary" target="_blank"}                 |A false negative; When a test concludes there is no effect when there is really is an effect                                                                                               |
|[uniform distribution](https://psyteachr.github.io/glossary/u.html#uniform-distribution){class="glossary" target="_blank"}   |A distribution where all numbers in the range have an equal probability of being sampled                                                                                                   |
|[univariate](https://psyteachr.github.io/glossary/u.html#univariate){class="glossary" target="_blank"}                       |Relating to a single variable.                                                                                                                                                             |



## Exercises {#exercises-sim}

Download the [exercises](exercises/10_sim_exercise.Rmd). See the [answers](exercises/10_sim_answers.Rmd) only after you've attempted all the questions.


```r
# run this to access the exercise
reprores::exercise(10)

# run this to access the answers
reprores::exercise(10, answers = TRUE)
```
