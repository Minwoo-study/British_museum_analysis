library(LexisNexisTools)
#install.packages('tidyverse')
#library(tidyverse)
library(data.table)
library(lubridate)

# ?��?��목록 불러?���?
# LNToutput <- lnt_read(x = './docx/DOCX.DOCX')
LNToutput <- lnt_read(x = 'C:/Users/life/Desktop/Museum/20220613~20220701')

# dataframe?���? ?��?��

# 중복 기사 찾기
duplicates_df <- lnt_similarity(LNToutput = LNToutput,
                                threshold = 0.9, 
                                nthread = parallel::detectCores()-1,
                                rel_dist = F # ?��간문?���? F 처리
)

# ?��?��?�� 0.9?��?�� 기사 ?��?��
duplicates_df <- duplicates_df[duplicates_df$Similarity >= 0.9]
LNToutput <- LNToutput[!LNToutput@meta$ID %in% duplicates_df$ID_duplicate, ]

# 질의?�� 존재?��?�� 기사�? ?��기기 (?��?�� : mask)
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