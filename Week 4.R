url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(url, destfile= "./cameras.csv",method = "curl")
cameraData <- read.csv("cameras.csv")
names(cameraData)
#change all the names to lower cases
tolower(names(cameraData))
#split names with "." out
splitnames <- strsplit(names(cameraData), "\\.")
splitnames
#keep the first part of the splitted names
firstelement <- function(x) {
    x[1]
}
sapply(splitnames, firstelement)

#find cases where intercextion include Alameda
grep("Alameda", cameraData$intersection)
# return true or false
grepl("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
# select all the cases don't have alameda in intersection
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
table(grepl("Alameda", cameraData2$intersection))


#Q1
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url2, destfile= "./housing.csv",method = "curl")
housing <- read.csv("housing.csv")
names(housing)
dim(housing)
##split names on the characters "wgtp" 
splitnames <- strsplit(names(housing), "wgtp")
splitnames[123]

#Q2
url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url3, destfile= "./GDP4.csv",method = "curl")
GDP4 <- read.csv("GDP4.csv")
GDP4 <- GDP4[5:194, c(1,2,4,5)]
colnames (GDP4)[c(1,2,3,4)] <- c("CountryCode", "Rank","Economy","Total")
names(GDP4)
class(GDP4$Rank)
## Read data
GDP3 <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip = 5, nrows = 190, 
              select = c(1,2,4,5), 
              col.names = c("CountryCode", "Rank", "Economy", "Total"))
names(GDP3)
dim(GDP3)
GDP3$Total
## remove , in Total
GDP3$Total <- sub(",", "", GDP3$Total)
GDP3$Total <- as.numeric(GDP3$Total)
mean(GDP3$Total)

# Q3
grep("^United", GDP3$Economy)

# Q4
## Read GDP data
GDP5 <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip = 5, nrows = 190, 
                          select = c(1,2,4,5), 
                          col.names = c("CountryCode", "Rank", "Economy", "Total"))
names(GDP5)
dim(GDP5)
## Read Education data
education <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
names(education)
dim(education)
q4 <- merge(GDP5, education, by="CountryCode")
dim(q4)
## Find June
grep("[Ff]iscal+ (.*)[Jj]une", q4$`Special Notes`, value = TRUE)
#alternative
q4[grepl(pattern = "Fiscal year end: June 30;", q4$`Special Notes`), .N]

# Q5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
years<- sampleTimes[which(year(sampleTimes)==2012)]
length(years)
weekdays(years)
weekday<-years[which(weekdays(years)== "Monday")]
length(weekday)









