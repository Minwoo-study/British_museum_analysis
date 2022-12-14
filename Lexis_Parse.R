library(LexisNexisTools)
#install.packages('tidyverse')
#library(tidyverse)
library(data.table)
library(lubridate)

# ??Όλͺ©λ‘ λΆλ¬?€κΈ?
# LNToutput <- lnt_read(x = './docx/DOCX.DOCX')
LNToutput <- lnt_read(x = 'C:/Users/life/Desktop/Museum/20220613~20220701')

# dataframe?Όλ‘? ? ?

# μ€λ³΅ κΈ°μ¬ μ°ΎκΈ°
duplicates_df <- lnt_similarity(LNToutput = LNToutput,
                                threshold = 0.9, 
                                nthread = parallel::detectCores()-1,
                                rel_dist = F # ?κ°λ¬Έ? λ‘? F μ²λ¦¬
)

# ? ?¬? 0.9?΄? κΈ°μ¬ ?­? 
duplicates_df <- duplicates_df[duplicates_df$Similarity >= 0.9]
LNToutput <- LNToutput[!LNToutput@meta$ID %in% duplicates_df$ID_duplicate, ]

# μ§μ?΄ μ‘΄μ¬?? κΈ°μ¬λ§? ?¨κΈ°κΈ° (?? : mask)
# LNToutput@meta$stats <- lnt_lookup(LNToutput, pattern = "[Mm]ask(s*)")
# LNToutput <- LNToutput[!sapply(LNToutput@meta$stats, is.null), ]

meta_articles_df <- lnt_convert(LNToutput, to = "data.frame")
meta_articles_df

# DataFrame/ filtering the data 
#meta_articlmeta_articles_df <- meta_articles_df %>% 
    filter(Date >= ymd("2017-08-01"), Date <= ymd("2017-10-27"))
#range(meta_articles_df$DATE)es_df <- lnt_convert(LNToutput, to = "data.frame")
#meta_articles_df
# this part is not necessary


# export File
fwrite(data.table(meta_articles_df),'C:/Users/life/Desktop/Museum_parsing/museum_6.csv')
