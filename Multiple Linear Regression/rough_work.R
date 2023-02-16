
# Libraries

library(mice)
library(Hmisc)
library(scales)

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

# Removing Trailing Space ensuring correct Spelling

employees$department <- trimws(employees$department, which=c("right"))
employees$department[employees$department == "sweing"] <- "sewing"

# Removing date column

employees <- employees[, -1]
colnames(employees)

# Converting from `chr` to `factor`

employees[,c(1:4, 12)] <- lapply(employees[,c(1:4, 12)], factor)
str(employees)

# Number of Missing Values

colSums(is.na(employees))
names(which(colSums(is.na(employees)) > 0))


# Missing Value Imputation

with(employees, impute(employees$wip, mean))
md.pattern(employees, rotate.names=TRUE)
complete(mice(employees, method="pmm", seed=42), 2)
qqnorm(scale(employees$wip))

      
          # ------  Analysis ------ 

## Pair Plot

num_employees <- employees[sapply(employees, is.numeric)]
pairs(num_employees, col=hue_pal()(3)[3], pch=20)

##  Pair Plot for Numeric Variables
num_employees <- employees[sapply(employees, is.numeric)]
pairs(num_employees, col=hue_pal()(3)[3], pch=20)
