
# Libraries

library(mice)
library(Hmisc)

# Data Inspection

employees <- read.csv("garments_worker_productivity.csv")
View(employees)
dim(employees)

unique(employees$date)
unique(employees$quarter)
unique(employees$department)
unique(employees$day)
unique(employees$team)
unique(employees$targeted_productivity)
unique(employees$smv)
unique(employees$wip)
unique(employees$over_time)
unique(employees$incentive)
unique(employees$idle_time)
unique(employees$idle_men)
unique(employees$no_of_style_change)
unique(employees$no_of_workers)
unique(employees$actual_productivity)


# Number of Missing Values

colSums(is.na(employees))
names(which(colSums(is.na(employees)) > 0))


# Missing Value Imputation

with(employees, impute(employees$wip, mean))
md.pattern(employees, rotate.names=TRUE)
complete(mice(employees, method="pmm", seed=42), 2)
qqnorm(scale(employees$wip))