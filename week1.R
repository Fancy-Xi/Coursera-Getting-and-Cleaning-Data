#week1 
getwd()
setwd()
sedwd("../") #move up one directory
file.exists("directoryname") #check is the directory exists
dir.create("directoryname") #create a directory

if (!file.exists("data")) {
    dir.create("data")
}

#dowload files from the internet
download.file()

#Baltimore data
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv", method="curl")
list.files("./data")

dataDownloaded <- date()
dateDownloaded

cameraData <- read.table("./data/cameras.csv",sep = ",",header = TRUE)
head(cameraData)
# or use read.csv which default: se=",", and header=TRUE
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

#the data.table package
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DF,3)
DT = data.table(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DT)
tables()
##Subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]
##Subsetting columns
{
    x=1
    x=2
}
k = {print(10);5}
DT[,list(mean(x),sum(z))]
DT[,table(y)]
##add a new column that's z^2
DT[,w:=z^2]
##multiple operations
DT[,m:={tmp <- (x+z); log2(tmp+5)}]
##plyr like operations
DT[,a:=x>0]
DT[,b:=mean(x+w), by=a]
##special variables
set.seed(123)
DT <- data.table(x=sample(letters[1:3],1E5, TRUE))
DT[, .N, by=x] #count the number of variables grouped by x
##Keys
DT<- data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
setkey(DT,x)
DT['a'] #subset table where x==a
#Joins
DT1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x); setkey(DT2,x)
merge(DT1,DT2)


quiz <-read.csv("data/getdata_data_ss06hid.csv")
head(quiz)
nrow(quiz)
worth <- quiz[quiz$VAL>=1000000, ]
head(worth)
nrow(worth)

install.packages("xlsx")
library(xlsx)
install.packages("readxl")
library(readxl)
quiz2<- read_xlsx("data/getdata_data_DATA.gov_NGAP.xlsx",sheet=1, col_names  =TRUE)

dat <- quiz2[18:23,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "./data/survey.csv", method="curl")


install.packages("swirl")
library(swirl)
install_from_swirl("Getting and Cleaning Data")
install.packages("dplyr")

x <- read.fwf("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for", skip = 4, widths = c(12,7,4,9,4,9,4,9,4))
head(x)
str(x)
ncol(x)
nrow(x)
dim(x)
sum(x[,4])
y <- x[,4]
  head(y)
sum(y) 
    
    
    
    