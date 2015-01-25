yield_chart <- function(mdata, defaultColors){
        
        
        # To use for fills, add
        
        
        
        t <-mdata
        
        dt <- ggplot(data=t, aes(x=variable, y=value,group=date,   color=factor(format(date,"%m/%d/%Y")))) + theme(legend.title=element_blank())+
                geom_line(size=1.5) + geom_point(size=3, fill="white") +  xlab("Maturity") + ylab("Yield %") + ggtitle("Yield Curve") 

        
        dt
        
} 