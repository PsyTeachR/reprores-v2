# data for reprores ----

library(dplyr)
library(tidyr)
library(faux)
library(readr)
faux::faux_options(verbose = FALSE)
set.seed(8675309)

reponame <- "reprores-v2"


# function for creating dataset descriptions in Roxygen
make_dataset <- function(dataname, title, desc, vardesc = list(), filetype = "csv", source = NULL, write = TRUE, ct = readr::cols()) {

  # read data and save to data directory
  datafile <- paste0("data-raw/", dataname, ".", filetype)
  if (filetype == "csv") {
    data <- readr::read_csv(datafile, col_types = ct)
  } else if (filetype == "xls") {
    data <- readxl::read_xls(datafile)
  }
  # this is awkward, but devtools::document won't work unless the saved data has the name you intend to use for it
  dat <- list()
  dat[[dataname]] <- data
  list2env(dat, envir = environment())
  e <- paste0("usethis::use_data(", dataname, ", overwrite = TRUE)")
  eval(parse(text = e))

  # save(data, file = paste0("data/", dataname, ".rda"),
  #      compress = "bzip2", version = 2)

  # make codebook and save
  cb <- faux::codebook(data, vardesc = vardesc,
                       author = "Lisa DeBruine",
                       name = title, description = gsub("\n", " ", desc),
                       license = "CC-BY 4.0")
  readr::write_file(cb, paste0("data-raw/", dataname, ".json"))

  # create Roxygen description
  itemdesc <- vardesc$description
  items <- paste0("#'    \\item{", names(itemdesc), "}{", itemdesc, "}")

  if (is.null(source)) source <- sprintf(
    "https://psyteachr.github.io/%s/data/%s.%s", 
    reponame,
    dataname, 
    filetype
  )

  s <- sprintf("# %s ----\n#' %s\n#'\n#' %s\n#'\n#' @format A data frame with %d rows and %d variables:\n#' \\describe{\n%s\n#' }\n#' @source \\url{%s}\n\"%s\"\n\n",
               dataname, title,
               gsub("\n+", "\n#'\n#' ", desc),
               nrow(data), ncol(data),
               paste(items, collapse = "\n"),
               source, dataname
  )
  if (!isFALSE(write)) write(s, paste0("R/data_", dataname, ".R"))
  invisible(s)
}


## smalldata ----
time <- list(time = c(pre = "Pre-intervention score",
                      post = "Post-intervention score"))
group <- list(group = c(control = "Control group",
                        exp = "Experimental group"))
set.seed(8675309)
data <- faux::sim_design(within = time,
                         between = group,
                         n = 5,
                         mu = c(100, 100, 100, 110),
                         sd = 20, r = 0.5,
                         dv = "score")
readr::write_csv(data, "data-raw/smalldata.csv")
vardesc <- list(
  description = list(
    id = "Subject ID",
    group = "Between-subject factor (control vs experimental group)",
    pre = "Score before the intervention",
    post = "Score after the intervention"
  )
)
make_dataset("smalldata", "Small Factorial Design: 2w*2b",
             "Small simulated dataset (n = 5) with one within-subject factor (time) having 2 levels (pre and post) and one beteen-subject factor (group) having two levels (control and experimental). The dataset is in wide format and created with faux.", vardesc)

## country_codes ----
ccodes <- read_csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")
readr::write_csv(ccodes, "data-raw/country_codes.csv")

vardesc <- list(
  description = list(
    "name" = "Full country name",
    "alpha-2" = "2-character country code",
    "alpha-3" = "3-character country code",
    "country-code" = "3-digit country code",
    "iso_3166-2" = "ISO code",
    "region" = "World region",
    "sub-region" = "Sub-region",
    "intermediate-region" = "Intermediate region",
    "region-code" = "World region code",
    "sub-region-code" = "Sub-region code",
    "intermediate-region-code" = "Intermediate region code"
  )
)

make_dataset("country_codes",
             "Country Codes",
             "Multiple country, subregion, and region codes for 249 countries.\nFrom https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes", vardesc, source = "https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")

## disgust ----
vardesc <- list(
  description = list(
    id = "Each questionnaire completion's unique ID",
    user_id = "Each participant's unique ID",
    date = "Date of completion (YYY-mm-dd)",
    moral1 =  "Shoplifting a candy bar from a convenience store",
    moral2 =  "Stealing from a neighbor",
    moral3 =  "A student cheating to get good grades",
    moral4 =  "Deceiving a friend",
    moral5 =  "Forging someone's signature on a legal document",
    moral6 =  "Cutting to the front of a line to purchase the last few tickets to a show",
    moral7 =  "Intentionally lying during a business transaction",
    sexual1 =  "Hearing two strangers having sex",
    sexual2 =  "Performing oral sex",
    sexual3 =  "Watching a pornographic video",
    sexual4 =  "Finding out that someone you don't like has sexual fantasies about you",
    sexual5 =  "Bringing someone you just met back to your room to have sex",
    sexual6 =  "A stranger of the opposite sex intentionally rubbing your thigh in an elevator",
    sexual7 =  "Having anal sex with someone of the opposite sex",
    pathogen1 =  "Stepping on dog poop",
    pathogen2 =  "Sitting next to someone who has red sores on their arm",
    pathogen3 =  "Shaking hands with a stranger who has sweaty palms",
    pathogen4 =  "Seeing some mold on old leftovers in your refrigerator",
    pathogen5 =  "Standing close to a person who has body odor",
    pathogen6 =  "Seeing a cockroach run across the floor",
    pathogen7 =  "Accidentally touching a person's bloody cut"
  )
)

make_dataset("disgust",
             "Three Domain Disgust Questionnaire (items)",
             "A dataset containing responses to the 21 items in the Three Domain Disgust Questionnaire (Tybur et al.)", vardesc)


## disgust_cors ----
vardesc <- list(
  description = list(
    V1 = "The first correalted item",
    V2 = "The second correlated item",
    r = "The Pearson's correlation between the first and second item"
  )
)

make_dataset("disgust_cors",
             "Three Domain Disgust Questionnaire (correlations)",
             "Correlations among questions on the Three Domain Disgust Questionnaire (Tybur et al.)", vardesc)

## disgust_scores ----
vardesc <- list(
  description = list(
    id = "Each questionnaire completion's unique ID",
    user_id = "Each participant's unique ID",
    date = "Date of completion (YYY-mm-dd)",
    moral = "The mean value for the 7 moral items",
    sexual = "The mean value for the 7 sexual items",
    pathogen = "The mean value for the 7 pathogen items"
  ),
  minValue = list(moral = 0, pathogen = 0, sexual = 0),
  maxValue = list(moral = 6, pathogen = 6, sexual = 6)
)
make_dataset("disgust_scores", "Three Domain Disgust Questionnaire (scores)",
             "A dataset containing subscale scores for to the Three Domain Disgust Questionnaire (Tybur et al.), calculated from [disgust].", vardesc)


## EMBU_mother ----
vardesc <- list(
  description = list(
    id = "A unique ID for each questionnaire completion",
    r1 = "It happened that my mother was sour or angry with me without letting me know the cause",
    e1 = "My mother praised me",
    p1 = "It happened that I wished my mother would worry less about what I was doing",
    r2 = "It happened that my mother gave me more corporal punishment than I deserved",
    p2 = "When I came home, I then had to account for what I had been doing, to my mother",
    e2 = "I think that my mother tried to make my adolescence stimulating, interesting and instructive (for instance by giving me good books, arranging for me to go on camps, taking me to clubs)",
    r3 = "My mother criticized me and told me how lazy and useless I was in front of others",
    p3 = "It happened that my mother forbade me to do things other children were allowed to do because she was afraid that something might happen to me",
    no_subscale = "My mother tried to spur me to become the best",
    p4 = "My mother would look sad or in some other way show that I had behaved badly so that I got real feelings of guilt",
    p5 = "I think that my mother's anxiety that something might happen to me was exaggerated",
    e3 = "If things went badly for me, I then felt that my mother tried to comfort and encourage me",
    r4 = "I was treated as the ‘black sheep' or ‘scapegoat' of the family",
    e4 = "My mother showed with words and gestures that he liked me",
    r5 = "I felt that my mother liked my brother(s) and/or sister(s) more than she liked me",
    r6 = "My mother treated me in such a way that I felt ashamed",
    p6 = "I was allowed to go where I liked without my mother caring too much",
    p7 = "I felt that my mother interfered with everything I did",
    e5 = "I felt that warmth and tenderness existed between me and my mother",
    p8 = "My mother put decisive limits for what I was and was not allowed to do, to which she then adhered rigorously",
    r7 = "My mother would punish me hard, even for triffles (small offenses)",
    p9 = "My mother wanted to decide how I should be dressed or how I should look",
    e6 = "I felt that my mother was proud when I succeeded in something I had undertaken"
  )
)
make_dataset("EMBU_mother", "Parental Attachment (Mothers)",
             "Items starting with r, p and e are for the rejection (r), overprotection (p), and emotional warmth (e) subscales.\nArrindell et al. (1999). The development of a short form of the EMBU: Its appraisal with students in Greece, Guatemala, Hungary and Italy. Personality and Individual Differences, 27, 613-628.", vardesc)

## empathizing ----
vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    sex = "The participant's sex",
    age = "The participant's age in years",
    id = "Each questionnaire completion's unique ID",
    starttime = "The time the questionnaire was started (yyyy-MM-dd HH:mm:ss)",
    endtime = "The time the questionnaire was completed (yyyy-MM-dd HH:mm:ss)",
    Q01 = "I can easily tell if someone else wants to enter a conversation.",
    Q02 = "I really enjoy caring for other people.",
    Q03R = "I find it hard to know what to do in a social situation.",
    Q04R = "I often find it difficult to judge if something is rude or polite.",
    Q05R = "In a conversation, I tend to focus on my own thoughts rather than on what my listener might be thinking.",
    Q06 = "I can pick up quickly if someone says one thing but means another.",
    Q07R = "It is hard for me to see why some things upset people so much.",
    Q08 = "I find it easy to put myself in somebody else's shoes.",
    Q09 = "I am good at predicting how someone will feel.",
    Q10 = "I am quick to spot when someone in a group is feeling awkward or uncomfortable.",
    Q11R = "I can't always see why someone should have felt offended by a remark.",
    Q12 = "I don't tend to find social situations confusing.",
    Q13 = "Other people tell me I am good at understanding how they are feeling and what they are thinking.",
    Q14 = "I can easily tell if someone else is interested or bored with what I am saying.",
    Q15 = "Friends usually talk to me about their problems as they say that I am very understanding.",
    Q16 = "I can sense if I am intruding, even if the other person doesn't tell me.",
    Q17R = "Other people often say that I am insensitive, though I don't always see why.",
    Q18 = "I can tune into how someone else feels rapidly and intuitively.",
    Q19 = "I can easily work out what another person might want to talk about.",
    Q20 = "I can tell if someone is masking their true emotion.",
    Q21 = "I am good at predicting what someone will do.",
    Q22 = "I tend to get emotionally involved with a friend's problems."
  )
)

d <- read_csv("data-raw/empathizing.csv") %>%
  gather(q, score, q2663:q2684) %>%
  mutate(label = recode(score,
                        "1" = "strongly agree",
                        "2" = "slightly agree",
                        "3" = "slightly disagree",
                        "4" = "strongly disagree"),
         rev = q %in% c("q2665", "q2666", "q2667", "q2669", "q2673", "q2679")
         )

nm <- unique(d$q)
rcode <- faux::make_id(length(nm), "Q")
names(rcode) <- nm
d$qname = recode(d$q, !!!rcode)
d$qname = paste0(d$qname, ifelse(d$rev, "R", ""))
unique(d$qname)

data <- select(d, -q, -score, -rev) %>%
  spread(qname, label)

write_csv(data, "data-raw/eq_data.csv")

make_dataset("eq_data", "Empathizing Quotient",
             "Reverse coded (Q#R) questions coded and strongly disagree = 2, slightly disagree = 1, else = 0. The other questions are coded as strongly agree = 2, slightly agree = 1, else = 0.\nWakabayashi, A., Baron-Cohen, S., Wheelwright, S., Goldenfeld, N., Delaney, J., Fine, D., Smith, R., & Weil, L. (2006). Development of short forms of the Empathy Quotient (EQ-Short) and the Systemizing Quotient (SQ-Short). Personality and Individual Differences, 41(5), 929–940. https://doi.org/10.1016/j.paid.2006.03.017", vardesc)

## family ----

vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    sex = "The participant's sex",
    age = "The participant's age in years",
    momage = "How old was your female parent when you were born?",
    dadage = "How old was your male parent when you were born?",
    oldbro = "How many older brothers do you have?",
    oldsis = "How many older sisters do you have?",
    youngbro = "How many younger brothers do you have?",
    youngsis = "How many younger sisters do you have?",
    twinbro = "How many same-age (e.g. twin) brothers do you have?",
    twinsis = "How many same-age (e.g. twin) sisters do you have?"
  )
)

make_dataset("family_composition", "Family Composition",
             "Responses to a brief questionnaire about family composition.",
             vardesc)


## eye_descriptions ----
vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    sex = "The participant's sex",
    age = "The participant's age in years"
  )
)
tt <- paste0("The description for face ", 1:50)
names(tt) <- paste0("t", 1:50)
vardesc$description <- c(vardesc$description, tt)

make_dataset("eye_descriptions", "Descriptions of Eyes",
             "Participant's written descriptions of the eyes of 50 people", vardesc)

## infmort ----
vardesc <- list(
  description = list(
    Country = "The full country name",
    Year = "The year the statistic was calculated for (yyyy)",
    "Infant mortality rate (probability of dying between birth and age 1 per 1000 live births)" = "Infant mortality rate (the probability of dying between birth and age 1 per 1000 live births) and confidence interval in the format \"rate \\[lowCI-highCI\\]\""
  )
)

make_dataset("infmort", "Infant Mortality",
             "Infant mortality by country and year from the World Health Organisation.", vardesc, source = "https://apps.who.int/gho/data/view.main.182?lang=en")


## matmort ----
vardesc <- list(
  description = list(
    Country = "The full country name",
    "1990" = "Maternal mortality for 1990 (format: \"rate \\[lowCI-highCI\\]\")",
    "2000" = "Maternal mortality for 2000 (format: \"rate \\[lowCI-highCI\\]\")",
    "2015" = "Maternal mortality for 2015 (format: \"rate \\[lowCI-highCI\\]\")"
  )
)

make_dataset("matmort", "Maternal Mortality",
             "Maternal mortality by country and year from the World Health Organisation.", vardesc, filetype = "xls", source = "https://apps.who.int/gho/data/node.main.15?lang=en")


## sensation_seeking ----

vardesc <- list(
  description = list(
    id = "Each questionnaire completion's unique ID",
    user_id = "Each participant's unique ID",
    date = "Date of completion (YYY-mm-dd)",
    sss1 = "1:I would like a job that requires a lot of traveling. vs 0:I would prefer a job in one location.",
    sss2 = "1:I am invigorated by a brisk, cold day. vs 0:I cannot wait to get indoors on a cold day.",
    sss3 = "1:I get bored seeing the same old faces. vs 0:I like the comfortable familiarity of everyday friends.",
    sss4 = "0:I would prefer living in an ideal society in which everyone is safe, secure, and happy. vs 1:I would have preferred living in the unsettled days of our history.",
    sss5 = "1:I sometimes like to do things that are a little frightening. vs 0:A sensible person avoids activities that are dangerous.",
    sss6 = "0:I would not like to be hypnotized. vs 1:I would like to have the experience of being hypnotized.",
    sss7 = "1:The most important goal of life is to live it to the fullest and experience as much as possible. vs 0:The most important goal of life is to find peace and happiness.",
    sss8 = "1:I would like to try parachute jumping. vs 0:I would never want to try jumping out of a plane, with or without a parachute.",
    sss9 = "0:I enter cold water gradually, giving myself time to get used to it. vs 1:I like to dive or jump right in to the ocean or a cold pool.",
    sss10 = "0:When I go on vacation, I prefer the comfort of a good room and bed. vs 1:When I go on vacation, I prefer the change of camping out.",
    sss11 = "1:I prefer people who are emotionally expressive even if they are a bit unstable. vs 0:I prefer people who are calm and even-tempered.",
    sss12 = "1:A good painting should shock or jolt the senses. vs 0:A good painting should give one a feeling of peace and security.",
    sss13 = "0:People who ride motorcycles must have some kind of unconscious need to hurt themselves. vs 1:I would like to drive or ride a motorcycle.",
    sss14 = "0:In a good sexual relationship, people never get bored with each other. vs 1:It is normal to get bored after a time with the same sexual partner."
  )
)

make_dataset("sensation_seeking", "Sensation Seeking Scale", "Zuckerman M. (1984). Sensation seeking: a comparative approach to a human trait. Behavioral and Brain Sciences. 7: 413-471.", vardesc)

## stroop ----
set.seed(8675309)
cc <- c("blue", "purple", "green", "red", "brown")
sub <- faux::sim_design(id = "sub_id", dv = "sub_i",
                        mu = 0, sd = 50, n= 50, plot = FALSE)
stroop <- faux::sim_design(
  within = list(word = cc, ink = cc, rep= 1:5),
  id = "sub_id", dv = "rt", long = TRUE,
  n = 50, mu = 650, sd = 100, r = 0.5, plot = FALSE
) %>%
  left_join(sub, by = "sub_id") %>%
  # 5% say the word instead of ink colour
  mutate(ink = as.character(ink),
         word = as.character(word),
         correct = rbinom(nrow(.), 1, .95),
         response = ifelse(correct == 1, ink, word),
         rt = ifelse(rbinom(nrow(.), 1, .05), NA, rt),
         response = ifelse(is.na(rt), NA, response),
         ink_effect = ifelse(ink == word, - 50, 0),
         rt = rt + ink_effect + sub_i) %>%
  select(sub_id, word, ink, response, rt) %>%
  arrange(sub_id)

readr::write_csv(stroop, "data-raw/stroop.csv")

vardesc <- list(
  description = list(
    sub_id = "Subject ID",
    word = "The text of the word",
    ink = "The ink colour of the word",
    response = "The subject's response (should equal the ink colour)",
    rt = "Reaction time (in ms)"
  )
)

make_dataset("stroop", "Stroop Task", "50 simulated subject in a stroop task viewing all combinations of word and ink colours blue, purple, green, red, and brown, 5 times each. Subjects respond with the ink colour. Subjects who do not respond in time have NA for response and rt.", vardesc)

## systemising ----
vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    sex = "The participant's sex",
    age = "The participant's age in years",
    id = "Each questionnaire completion's unique ID",
    starttime = "The time the questionnaire was started (yyyy-MM-dd HH:mm:ss)",
    endtime = "The time the questionnaire was completed (yyyy-MM-dd HH:mm:ss)",
    Q01 = "If I were buying a car, I would want to obtain specific information about its engine.",
    Q02 = "If there was a problem with the electrical wiring in my home, I’d be able to fix it myself.",
    Q03R = "I rarely read articles or web pages about new technology.",
    Q04R = "I do not enjoy games that involve a high degree of strategy.",
    Q05 = "I am fascinated by how machines work.",
    Q06 = "In math, I am intrigued by the rules and patterns governing numbers.",
    Q07R = "I find it difficult to understand instruction manuals for putting appliances together.",
    Q08 = "If I were buying a computer, I would want to know exact details about its hard disc drive capacity and processor speed.",
    Q09R = "I find it difficult to read and understand maps.",
    Q10R = "When I look at a piece of furniture, I do not notice the details of how it was constructed.",
    Q11R = "I find it difficult to learn my way around a new city.",
    Q12R = "I do not tend to watch science documentaries on television or read articles about science and nature.",
    Q13 = "If I were buying a stereo, I would want to know about its precise technical features.",
    Q14 = "I find it easy to grasp exactly how odds work in betting.",
    Q15R = "I am not very meticulous when I carry out D.I.Y.",
    Q16 = "When I look at a building, I am curious about the precise way it was constructed.",
    Q17R = "I find it difficult to understand information the bank sends me on different investment and saving systems.",
    Q18 = "When travelling by train, I often wonder exactly how the rail networks are coordinated.",
    Q19R = "If I were buying a camera, I would not look carefully into the quality of the lens.",
    Q20R = "When I hear the weather forecast, I am not very interested in the meteorological patterns.",
    Q21 = "When I look a mountain, I think about how precisely it was formed.",
    Q22 = "I can easily visualize how the motorways in my region link up.",
    Q23R = "When I'm in a plane, I do not think about the aerodynamics.",
    Q24 = "I am interested in knowing the path a river takes from its source to the sea.",
    Q25R = "I am not interested in understanding how wireless communication works."
  )
)

d <- read_csv("data-raw/systemizing.csv") %>%
  gather(q, score, q2616:q2640) %>%
  mutate(label = recode(score,
                        "1" = "strongly agree",
                        "2" = "slightly agree",
                        "3" = "slightly disagree",
                        "4" = "strongly disagree"),
         rev = q %in% c("q2618","q2619","q2622","q2624","q2625","q2626","q2627","q2630","q2632","q2634","q2635","q2638","q2640")
  )

nm <- unique(d$q)
rcode <- faux::make_id(length(nm), "Q")
names(rcode) <- nm
d$qname = recode(d$q, !!!rcode)
d$qname = paste0(d$qname, ifelse(d$rev, "R", ""))
unique(d$qname)

data <- select(d, -q, -score, -rev) %>%
  spread(qname, label)

write_csv(data, "data-raw/sq_data.csv")

make_dataset("sq_data", "Systemizing Quotient",
             "Reverse coded (Q#R) questions coded as strongly disagree = 2, slightly disagree = 1, else = 0. The other questions are coded as strongly agree = 2, slightly agree = 1, else = 0.\nWakabayashi, A., Baron-Cohen, S., Wheelwright, S., Goldenfeld, N., Delaney, J., Fine, D., Smith, R., & Weil, L. (2006). Development of short forms of the Empathy Quotient (EQ-Short) and the Systemizing Quotient (SQ-Short). Personality and Individual Differences, 41(5), 929–940. https://doi.org/10.1016/j.paid.2006.03.017", vardesc)

## personality ----

vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    date = "The date this questionnaire was completed",
    Op1 = "Tend to vote for conservative political candidates (REV)",
    Ne1 = "Have frequent mood swings (FWD)",
    Ne2 = "Am not easily bothered by things (REV)",
    Op2 = "Believe in the importance of art (FWD)",
    Ex1 = "Am the life of the party (FWD)",
    Ex2 = "Am skilled in handling social situations (FWD)",
    Co1 = "Am always prepared (FWD)",
    Co2 = "Make plans and stick to them (FWD)",
    Ne3 = "Dislike myself (FWD)",
    Ag1 = "Respect others (FWD)",
    Ag2 = "Insult people (REV)",
    Ne4 = "Seldom feel blue (REV)",
    Ex3 = "Don't like to draw attention to myself (REV)",
    Co3 = "Carry out my plans (FWD)",
    Op3 = "Am not interested in abstract ideas (REV)",
    Ex4 = "Make friends easily (FWD)",
    Op4 = "Tend to vote for liberal political candidates (FWD)",
    Ex5 = "Know how to captivate people (FWD)",
    Ag3 = "Believe that others have good intentions (FWD)",
    Co4 = "Do just enough work to get by (REV)",
    Co5 = "Find it difficult to get down to work (REV)",
    Ne5 = "Panic easily (FWD)",
    Op5 = "Avoid philosophical discussions (REV)",
    Ag4 = "Accept people as they are (FWD)",
    Op6 = "Do not enjoy going to art museums (REV)",
    Co6 = "Pay attention to details (FWD)",
    Ex6 = "Keep in the background (REV)",
    Ne6 = "Feel comfortable with myself (REV)",
    Co7 = "Waste my time (REV)",
    Ag5 = "Get back at others (REV)",
    Co8 = "Get chores done right away (FWD)",
    Ex7 = "Don't talk a lot (REV)",
    Ne7 = "Am often down in the dumps (FWD)",
    Co9 = "Shirk my duties (REV)",
    Op7 = "Do not like art (REV)",
    Ne8 = "Often feel blue (FWD)",
    Ag6 = "Cut others to pieces (REV)",
    Ag7 = "Have a good word for everyone (FWD)",
    Co10 = "Don't see things through (REV)",
    Ex8 = "Feel comfortable around people (FWD)",
    Ex9 = "Have little to say (REV)"
  )
)

make_dataset("personality", "5-Factor Personality Items", "Archival data from the Face Research Lab of a 5-factor personality questionnaire. Each question is labelled with the domain (Op = openness, Co = conscientiousness, Ex = extroversion, Ag = agreeableness, and Ne = neuroticism) and the question number. Participants rate each statement on a Likert scale from 0 (Never) to 6 (Always). Questions with REV have already been reverse-coded (0 = Always, 6 = Never). \n\nInstructions: A number of statements which people have used to describe themselves are given below. Read each statement and then click on of the seven options to indicate how frequently this statement applies to you. There are no right or wrong answers. Do not spend too much time on any one statement, but give the answer which seems to describe how you generally feel or behave.", vardesc)

## personality_scores ----

vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    date = "The date this questionnaire was completed",
    Ag = "Mean score on Agreeableness items",
    Co = "Mean score on Conscientiousness items",
    Ex = "Mean score on Extraversion items",
    Ne = "Mean score on Neuroticism items",
    Op = "Mean score on Openness items"
  )
)

make_dataset("personality_scores", "5-Factor Personality Scores", "Archival data from the Face Research Lab of a 5-factor personality questionnaire, with factor score calculated from [personality].", vardesc)

## pets ----
set.seed(8675309)
dog_r <- c(.25, .25, .5)
cat_r <- c(-.25, -.25, .5)
fer_r <- c(0, 0, .5)
pets <- faux::sim_design(
  within = list(var = c("score", "age", "weight")),
  between = list(pet = c("dog", "cat", "ferret"),
                 country = c("UK", "NL")),
  n = list(dog_UK = 200, cat_UK = 150, ferret_UK = 50,
           dog_NL = 200, cat_NL = 150, ferret_NL = 50),
  sd = c(score = 10, age = 3, weight = 2),
  r = list(dog_UK = dog_r, cat_UK = cat_r, ferret_UK = fer_r,
           dog_NL = dog_r, cat_NL = cat_r, ferret_NL = fer_r),
  mu = list(score = c(100, 100, 90, 90, 110, 110),
            age = c(7, 7, 7, 7, 7, 7),
            weight = c(20, 18, 10, 9, 5, 4.5)),
  plot = FALSE) %>%
  mutate(score = round(score),
         age = faux::norm2trunc(age, 0, mu = 7, sd = 3),
         age = round(age))

write_csv(pets, "data-raw/pets.csv")

vardesc <- list(
  description = list(
    id = "Subject ID",
    pet = "Type of pet (dog, cat, ferret)",
    country = "What country the pet is from (UK or NL)",
    score = "Score on some test (integers around 100)",
    age = "Age of the pet in years",
    weight = "Weight of the pet in kilograms"
  )
)

make_dataset("pets", "Pets",
             "A simulated dataset with one random factor (id), two categorical factors (pet, country) and three continuous variables (score, age, weight). This dataset is useful for practicing plotting.", vardesc, ct = "cffiid")

## experimentum_exps ----

vardesc <- list(
  description = list(
    session_id = "The unique session ID assigned each time a user starts a project",
    project_id = "The unique ID for the project (a collection of questionnaires and/or experiments",
    exp_id = "The unique ID for the experiment",
    user_id = "The unique ID for the user (subject/participant)",
    user_sex = "The user's sex/gender (male, female, nonbinary, na)",
    user_status = "The user's status (test, guest, registered, student,res, super, admin)",
    user_age = "The user's age in years; calculated from birthdate",
    trial_name = "The name of the trial",
    trial_n = "The unique number of the trial in the experiment",
    order = "The order the trial was shown in (for experiments with randomised order)",
    dv = "The response",
    rt = "The reaction time in ms",
    side = "The side of presentation (for multi-stimulus trials)",
    dt = "The timestamp of the trial response"
  )
)

make_dataset("experimentum_exps", "Experimentum Project Experiment",
             "Data from a demo experiment on Experimentum <https://debruine.github.io/experimentum/>. Subjects are shown pairs of upright and inverted Mooney faces and asked to click on the upright face.", vardesc, ct = "iiiiffdciicicT")

## experimentum_quests ----
vardesc <- list(
  description = list(
    session_id = "The unique session ID assigned each time a user starts a project",
    project_id = "The unique ID for the project (a collection of questionnaires and/or experiments",
    quest_id = "The unique ID for the questionnaire",
    user_id = "The unique ID for the user (subject/participant)",
    user_sex = "The user's sex/gender (male, female, nonbinary, na)",
    user_status = "The user's status (test, guest, registered, student,res, super, admin)",
    user_age = "The user's age in years; calculated from birthdate",
    q_name = "The name of the question",
    q_id = "The unique ID of the question in the questionnaire",
    order = "The order the trial was shown in (for questionnaires with randomised order)",
    dv = "The response",
    starttime = "The timestamp of the questionnaire start",
    endtime = "The timestamp of the questionnaire submission"
  )
)

make_dataset("experimentum_quests", "Experimentum Project Questionnaires",
             "Data from a demo questionnaire on Experimentum <https://debruine.github.io/experimentum/>. Subjects are asked questions about dogs to test the different questionnaire response types.  Questions   * current: \tDo you own a dog? (yes/no)   * past: Have you ever owned a dog? (yes/no)   * name: What is the best name for a dog? (free short text)   * good: How good are dogs? (1=pretty good:7=very good)   * country: What country do borzois come from?   * good_borzoi: How good are borzois? (0=pretty good:100=very good)   * text: Write some text about dogs. (free long text)   * time: What time is it? (time)", vardesc, ct = "iiiiffdccicTT")

## psa001_agg ----

vardesc <- list(
  description = list(
    region = "world region (Africa; Asia; Australia & New Zealand; Central America & Mexico; Eastern Europe; Middle East; Scandanavia; South America; UK; USA & Canada; Western Europe)",
    stim_id = "target image - first character designates race, second character designates gender, followed by a unique identifier that matches Target in [psa001_cfd_faces]",
    aggressive = "average rated aggression (1 to 9)",
    attractive = "average rated attractiveness (1 to 9)",
    caring = "average rated caringness (1 to 9)",
    confident = "average rated confidence (1 to 9)",
    dominant = "average rated dominance (1 to 9)",
    emostable = "average rated emotional stability (1 to 9)",
    intelligent = "average rated intelligence (1 to 9)",
    mean = "average rated meanness (1 to 9)",
    responsible = "average rated responsibility (1 to 9)",
    sociable = "average rated sociability (1 to 9)",
    trustworthy = "average rated trustworthiness (1 to 9)",
    unhappy = "average rated unhappiness (1 to 9)",
    weird = "average rated weirdness (1 to 9)"
  )
)

make_dataset("psa001_agg", "First Impressions of Faces (Aggregated)",
             "Aggregated data from Psychological Science Accelerator project: To Which World Regions Does the Valence-Dominance Model of Social Perception Apply? <https://psyarxiv.com/n26dy>. Mean ratings on 13 traits for each of 120 faces shown in 10 world regions. Face characteristics at [psa001_cfd_faces]. \n\n Full data and analysis scripts at <https://osf.io/jfwtr/>", vardesc,
             source = "https://osf.io/jkt29/")

## psa001_cfd_faces ----

psa_faces <- read_csv("data-raw/psa001_cfd_faces.csv")

vardesc <- list(
  description = list(
    Target = "target image - first character designates race, second character designates gender, followed by a unique identifier that matches Target in the CFD dataset",
    Race = "target self-identified race (A = asian; B = black; L = latinx; W = white)",
    Gender = "target sex (F = female; M = male)",
    Age = "Estimate the approximate age of this person (in years) ranges 18.7 to 34.9"
  )
)

make_dataset("psa001_cfd_faces", "Face Characteristics",
             "Face stimulus characteristics from Psychological Science Accelerator project: To Which World Regions Does the Valence-Dominance Model of Social Perception Apply? <https://psyarxiv.com/n26dy>. To be used with [psa001_agg]. \n\n Faces from Ma, Correll, & Wittenbrink (2015). The Chicago Face Database: A Free Stimulus Set of Faces and Norming Data. Behavior Research Methods, 47, 1122-1135.\n\n Full data and analysis scripts at <https://osf.io/jfwtr/>", vardesc,
             source = "https://osf.io/rzgh2/")




## mess ----
set.seed(8675309)
mess <- data.frame(
  junk = "junk",
  order = 1:26,
  score = round(rnorm(26), 2),
  letter = letters,
  good = sample(c("TRUE", "FALSE", "T", "F", 0, 1), 26, replace = TRUE),
  min_max = paste(1:26, "-", 2:27),
  date = c(paste0("2020-01-", 1:26))
) %>%
  add_row(order = 1:26, letter = LETTERS) %>%
  arrange(order, letter) %>%
  mutate(order = ifelse(row_number() == 3, "missing", order),
         order = ifelse(is.na(score), NA, order),
         letter = ifelse(is.na(score), NA, letter),
         score = ifelse(row_number() %in% c(9,23), NA, score)
         ) %>%
  select(everything())

messtxt <- readr::format_csv(mess) %>%
  gsub("NA,NA,NA,NA,NA,NA,NA", "", ., fixed = TRUE)
write(messtxt, "data-raw/mess.csv")

vardesc <- list(
  description = list(
    junk = "Junk values (just the word 'junk')",
    order = "Meant to be all integer values",
    score = "Meant to be all numeric values",
    letter = "Meant to be all character values",
    good = "Meant to be all logical values",
    min_max = "Two integers separated by a dash",
    date = "Dates in two different formats"
  )
)

make_dataset("mess", "Messy Data",
             "A dataset with missing values, blank rows, incorrect data types, multiple values in one column, and multiple date types for practicing data import.", vardesc)

## add bad header rows
write(paste0("This is my messy dataset\n\n", messtxt), "data-raw/mess.csv")

## users ----

vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    sex = "The participant's sex",
    birthyear = "The participant's year of birth"
  )
)

make_dataset("users", "User Demographics",
             "A dataset with unique participant ID, sex and birth year. To be used in conjunction with data from [disgust], [disgust_scores], [personality], [personality_scores], and [users2].", vardesc)

## users2 ----

vardesc <- list(
  description = list(
    user_id = "Each participant's unique ID",
    birthyear = "The participant's year of birth",
    sex = "The participant's sex"
  )
)

make_dataset("users2", "User Demographics 2",
             "A dataset with unique participant ID, birth year, and sex. To be used in conjunction with data from [disgust], [disgust_scores], [personality], [personality_scores], and [users].", vardesc)


# demo data ----
demo <- tibble(
  character = LETTERS[1:6],
  integer = 1:6,
  double = 1.5:6.5,
  logical = c(T, T, F, F, NA, T),
  date = format((lubridate::today() - 0:5), format = "%d-%b-%y")
)

rio::export(demo, "data-raw/demo.csv")
rio::export(demo, "data-raw/demo.tsv")
rio::export(demo, "data-raw/demo.xlsx", overwrite = TRUE)
rio::export(demo, "data-raw/demo.sav")
rio::export(demo, "data-raw/demo.json")

vardesc <- list(
  description = list(
    character = "letters",
    integer = "Numbers with no decimal places",
    double = "Numbers with decimal places",
    logical = "TRUE/FALSE values",
    date = "Dates in the format 31-Jan-21"
  )
)

make_dataset("demo", "Importing Demo",
             "A dataset with five different types of columns, and in five different formats (csv, tsv, xlsx, sav, and json), used to practice importing.", vardesc)

# update documentation -----
devtools::document()

## copy raw data to book data dir ----
f <- list.files("data-raw", full.names = TRUE)
copied <- sapply(f, file.copy,
        to = "docs/data/",
        overwrite = TRUE)

## make zip file ----
f <- list.files(path = "data-raw", pattern = "[^zip]$", full.names = TRUE)
dir.create("docs/data", FALSE)
utils::zip("docs/data/data.zip", f, flags = "-j")

