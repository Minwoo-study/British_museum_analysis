library(LexisNexisTools)
#install.packages('tidyverse')
#library(tidyverse)
library(data.table)
library(lubridate)

# ?ŒŒ?¼ëª©ë¡ ë¶ˆëŸ¬?˜¤ê¸?
# LNToutput <- lnt_read(x = './docx/DOCX.DOCX')
LNToutput <- lnt_read(x = 'C:/Users/life/Desktop/Museum/20220613~20220701')

# dataframe?œ¼ë¡? ? „?™˜

# ì¤‘ë³µ ê¸°ì‚¬ ì°¾ê¸°
duplicates_df <- lnt_similarity(LNToutput = LNToutput,
                                threshold = 0.9, 
                                nthread = parallel::detectCores()-1,
                                rel_dist = F # ?‹œê°„ë¬¸? œë¡? F ì²˜ë¦¬
)

# ?œ ?‚¬?„ 0.9?´?ƒ ê¸°ì‚¬ ?‚­? œ
duplicates_df <- duplicates_df[duplicates_df$Similarity >= 0.9]
LNToutput <- LNToutput[!LNToutput@meta$ID %in% duplicates_df$ID_duplicate, ]

# ì§ˆì˜?–´ ì¡´ì¬?•˜?Š” ê¸°ì‚¬ë§? ?‚¨ê¸°ê¸° (?˜ˆ?‹œ : mask)
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
