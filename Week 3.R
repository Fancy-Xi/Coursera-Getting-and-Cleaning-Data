## Using dplyr
library(dplyr)
data <-read.csv("getdata_data_ss06hid.csv")
names(data)
## Quiz 3
#Q1
agricultureLogical <- data$ACR==3 & data$AGS ==6
names(data)
head(which(agricultureLogical),3)
#Q2
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
z <- tempfile()
download.file(url,z,mode = "wb")
pic <- readJPEG(z, native = TRUE)
quantile(pic, probs = c(0.3, 0.8))
#Q3
GDPraw<- read.csv("GDP.csv")
Country <- read.csv("Country.csv")
GDP <- GDPraw[c(5:194),c(1,2,4,5)]
colnames (GDP)[c(1,2,3,4)] <- c("CountryCode", "Rank","Economy","Total")

mergedata = merge(GDP, Country, by = 'CountryCode')
# why this doesn't work
mergedata<-arrange(mergedata, desc(Rank))
mergedata <- mergedata %>% arrange(desc(Rank))
mergedata$` Economy`[13]
nrow(mergedata)
# this is from others, doesn't work too
mergedata[order(-Rank)][13,.(Economy)]

a <- data.frame ("var1"=sample(1:100, 20), "var2"=sample(6:88,20), "var3"=sample(98:154,20))
head(a)
arrange(a,desc(var1))

#Q3 try load data differently and solved the problem
library("data.table")
GDP2 <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                        , skip = 5
                        ,nrows = 190
                        ,select = c(1,2,4,5)
                        ,col.names = c("CountryCode", "Rank", "Economy", "Total"))
Country2 <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
mergedata2 = merge(GDP2, Country2, by = 'CountryCode')
dim(mergedata2)
mergedata2<-arrange(mergedata2, desc(Rank))
mergedata2[13,]$Economy

##Rank in GDP2 is integer but is factor in GDP dataset, try convert Rank into integer
as.numeric(as.character(mergedata$Rank))

#Q4 
tapply(mergedata2$Rank, mergedata2$`Income Group`, mean)

#Q5
mergedata2$Rank=cut2(mergedata2$Rank, g=5)
table(mergedata2$Rank, mergedata2$`Income Group`)
