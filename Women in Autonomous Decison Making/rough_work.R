
# Turning Data into surveydata object

library(surveydata, quietly=TRUE)
library(likert)
require(maps)

women_vs_men <- females_wider[, c(1:15)] 
questions <- colnames(women_vs_men)
colnames(women_vs_men) <- c("country", paste0("Q_", 1:14))
colnames(women_vs_men)

varlabels(women_vs_men) <- questions
women_vs_men <- as.surveydata(women_vs_men, renameVarlabel=TRUE)

p1 <- survey_plot_yes_no(women_vs_men, "Q_2")
p1
women_vs_men
membersurvey
as.surveydata(females_wider)
survey_plot_yes_no(as.surveydata(females_wider), `A woman can apply for a passport in the same way as a man (1=yes; 0=no)`)


map(database="world", region="Democratic Republic of the Congo")
map(database="world", region=c("Republic of Congo"))