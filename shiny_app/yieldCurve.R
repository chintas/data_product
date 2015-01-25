
yieldCurve <- function(firstDate, secondDate = NULL ){
        
        yldURL <- "http://www.treasury.gov/resource-center/data-chart-center/interest-rates/pages/XmlView.aspx?data=yieldyear&year="
        yldURL <- paste(yldURL, year(firstDate), sep="")
        
        
        doc <- xmlTreeParse(yldURL, useInternal = TRUE)
        rootNode <- xmlRoot(doc)
        xmlName(rootNode)
        
        ns <- "http://schemas.microsoft.com/ado/2007/08/dataservices"
        date <- xpathSApply(rootNode, "//d:NEW_DATE", namespaces = c(d = ns), xmlValue)
        bc_1mth <- xpathSApply(rootNode, "//d:BC_1MONTH", namespaces = c(d = ns), xmlValue)
        bc_3mth <- xpathSApply(rootNode, "//d:BC_3MONTH", namespaces = c(d = ns), xmlValue)
        bc_6mth <- xpathSApply(rootNode, "//d:BC_6MONTH", namespaces = c(d = ns), xmlValue)
        bc_1yr <- xpathSApply(rootNode, "//d:BC_1YEAR", namespaces = c(d = ns), xmlValue)
        bc_2yr <- xpathSApply(rootNode, "//d:BC_2YEAR", namespaces = c(d = ns), xmlValue)
        bc_3yr <- xpathSApply(rootNode, "//d:BC_3YEAR", namespaces = c(d = ns), xmlValue)
        bc_5yr <- xpathSApply(rootNode, "//d:BC_5YEAR", namespaces = c(d = ns), xmlValue)
        bc_7yr <- xpathSApply(rootNode, "//d:BC_7YEAR", namespaces = c(d = ns), xmlValue)
        bc_10yr <- xpathSApply(rootNode, "//d:BC_10YEAR", namespaces = c(d = ns), xmlValue)
        bc_20yr <- xpathSApply(rootNode, "//d:BC_20YEAR", namespaces = c(d = ns), xmlValue)
        bc_30yr <- xpathSApply(rootNode, "//d:BC_30YEAR", namespaces = c(d = ns), xmlValue)
        date <- as.Date(date, "%Y-%m-%d" )
        data <- data.frame(id=1:length(date))
        data$date <- date
        data$c_1MO <-  as.numeric(bc_1mth)
        data$c_3MO <-  as.numeric(bc_3mth)
        data$c_6MO <-  as.numeric(bc_6mth)
        data$c_1YR <-  as.numeric(bc_1yr)
        data$c_2YR <-  as.numeric(bc_2yr)
        data$c_3YR <-  as.numeric(bc_3yr)
        data$c_5YR <-  as.numeric(bc_5yr)
        data$c_7YR <-  as.numeric(bc_7yr)
        data$c_10YR <- as.numeric(bc_10yr)
        data$c_20YR <- as.numeric(bc_20yr)
        data$c_30YR <- as.numeric(bc_30yr)
        
        
        
        data.melt<- melt(data, id.vars = "date", measure.vars = c("c_1MO", "c_3MO","c_6MO","c_1YR","c_2YR","c_3YR","c_5YR","c_7YR","c_10YR","c_20YR","c_30YR"))
        #data.melt$variable <- as.factor(data.melt$variable)
        #data.melt$variable[data.melt$variable == "c_1MO"] <- "1 Mo"
        
        #qplot(data.melt$variable,y= data.melt$value,data.melt)
       
        data.sub <-subset(data.melt, date == firstDate )

        if(!is.null(secondDate)){
                data.sub <-rbind(data.melt[as.Date(date) == secondDate, ], data.sub )
                
        }
        #ggplot(data=data.sub, aes(x=variable, y=value, group=date, shape=date, color=date)) + geom_line() 
        data.sub
}

#ggplot(data=data.melt, aes(x=variable, y=value, group=date, shape=date, color=date)) + geom_line() + geom_point()



#data.cast<- dcast(test,variable ~ date)
#data.cast$variable <- c("1 Mo", "3 Mo", "6 Mo", "1 Yr", "2 Yr", "3 Yr", "5 Yr", "7 Yr", "10 Yr", "20 Yr", "30 Yr")
#qplot(data.cast$variable,y= data.cast[,2],data.cast)  + scale_x_discrete(limits=c("1 Mo", "3 Mo", "6 Mo", "1 Yr", "2 Yr", "3 Yr", "5 Yr", "7 Yr", "10 Yr", "20 Yr", "30 Yr"))
