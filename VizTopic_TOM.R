

library(tidyverse)
library(tm)
library(plotly)


data <- read.csv('C:/Users/XXXXXXXXXXXXXXXXX/final_viz_bigramas.csv',encoding = "UTF-8")
data <- data %>% drop_na


colnms=c("Topic_2", "Topic_6")
data$Topic_11<-rowSums(data[,colnms])
colnms2=c("Topic_2", "Topic_6", "Topic_8")

data <- data %>% rename (
  '01_Cine, arte y espectáculos'=Topic_1,
  #'02_Hechos violentos'=Topic_2,
  '02_Política exterior'=Topic_3,
  '03_Farándula'=Topic_4,
  '04_Causas judiciales y hechos de corrupción'=Topic_5,
  #'06_Hechos de inseguridad'=Topic_6,
  '05_Deportes'=Topic_7,
  #'08_Tópico no interpretable'=Topic_8,
  '06_Elecciones'=Topic_9,
  '07_Economía'=Topic_10,
  '08_Hechos violentos/Inseguridad'=Topic_11)


data <- data%>%select(-colnms2)

###TÓPICOS POR DÍA
topic_proportion_per_date <- aggregate(data,by=list(dias=data$DATE),mean)
topic_proportion_per_date<-topic_proportion_per_date %>% select(-DocumentIdentifier,-titulo, -texto, -Medio, -title_text, -title_text_ed,-V2Themes)
topic_proportion_per_date$dias<-as.Date(topic_proportion_per_date$dias, format="%Y-%m-%d")

g1b<-topic_proportion_per_date %>% 
  pivot_longer(cols=c("01_Cine, arte y espectáculos":"08_Hechos violentos/Inseguridad"),names_to = c("Topics")) %>%
  ggplot(aes(x=dias, y=value, colour=Topics)) +
  geom_smooth(size=1.2) +
  theme_classic() +
  geom_vline(xintercept=as.numeric(topic_proportion_per_date$dias[173]), linetype=1, colour='red') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_date$dias[250]), linetype=1, colour='black') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_date$dias[278]), linetype=1, colour='black') +
  geom_text(aes(x=topic_proportion_per_date$dias[173], label="\nPASO", y=0.08), colour="red", angle=90)+
  geom_text(aes(x=topic_proportion_per_date$dias[250], label="\nPrimera vuelta", y=0.08), colour="black", angle=90)+
  geom_text(aes(x=topic_proportion_per_date$dias[278], label="\nSegunda vuelta", y=0.08), colour="black", angle=90)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_color_brewer(palette="Set1") +
  labs(title='Evolución de los tópicos',subtitle='Media de la composición de los tópicos de noticias')

g1b
###TÓPICOS POR DIARIO SEGÚN DÍA

topic_proportion_per_nwsp <- data %>% group_by(Medio, DATE) %>% summarise_each(funs(mean))
topic_proportion_per_nwsp <- topic_proportion_per_nwsp%>%select(-DocumentIdentifier,-titulo, -texto,-title_text, -title_text_ed, -V2Themes)
topic_proportion_per_nwsp$DATE<-as.Date(topic_proportion_per_nwsp$DATE, format="%Y-%m-%d")

g4<-topic_proportion_per_nwsp %>% 
  pivot_longer(cols=c("01_Cine, arte y espectáculos":"08_Hechos violentos/Inseguridad"),names_to = c("Topics")) %>%
  ggplot(aes(x=DATE, y=value, color=Topics)) +
  geom_smooth() +
  facet_wrap(~Topics) +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp$DATE[174]), linetype=1, colour='red') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp$DATE[253]), linetype=1, colour='black') +
  geom_text(aes(x=topic_proportion_per_nwsp$DATE[174], label="\nPASO", y=0.12), colour="red", angle=90)+
  geom_text(aes(x=topic_proportion_per_nwsp$DATE[253], label="\nGenerales", y=0.12), colour="black", angle=90)+
  theme_classic() +
  theme(legend.position = 'none')+
  labs(title='Evolución de los tópicos (media de la composición de las noticias)')

g4
g5<-topic_proportion_per_nwsp %>% 
  pivot_longer(cols=c("01_Cine, arte y espectáculos":"08_Hechos violentos/Inseguridad"),names_to = c("Topics")) %>%
  ggplot(aes(x=DATE, y=value, colour=Topics)) +
  geom_smooth() +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp$DATE[173]), linetype=1, colour='red') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp$DATE[250]), linetype=1, colour='black') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp$DATE[278]), linetype=1, colour='black') +
  geom_text(aes(x=topic_proportion_per_nwsp$DATE[173], label="\nPASO", y=0.12), colour="red", angle=90)+
  geom_text(aes(x=topic_proportion_per_nwsp$DATE[250], label="\nPrimera vuelta", y=0.12), colour="black", angle=90)+
  geom_text(aes(x=topic_proportion_per_date$dias[278], label="\nSegunda vuelta", y=0.12), colour="black", angle=90)+
  theme(axis.text.x = element_text(angle = 90))+
  facet_wrap(~Medio,nrow=7) +
  scale_color_brewer(palette="Set1") +
  theme_classic() +
  labs(title='Evolución de los tópicos según diario')

g5

## DIARIOS INDIVIDUALES

topic_proportion_per_nwsp2 <- data %>% group_by(Medio, DATE) %>% summarise_each(funs(mean))
topic_proportion_per_nwsp2 <- topic_proportion_per_nwsp2%>%select(-DocumentIdentifier,-titulo, -texto,-title_text, -title_text_ed, -V2Themes)
topic_proportion_per_nwsp2$DATE<-as.Date(topic_proportion_per_nwsp2$DATE, format="%Y-%m-%d")
topic_proportion_per_nwsp2 <- filter(topic_proportion_per_nwsp2, Medio == "Página 12")

g6<-topic_proportion_per_nwsp2 %>% 
  pivot_longer(cols=c("01_Cine, arte y espectáculos":"08_Hechos violentos/Inseguridad"),names_to = c("Topics")) %>%
  ggplot(aes(x=DATE, y=value, colour=Topics)) +
  geom_smooth(size=1.2) +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp2$DATE[174]), linetype=1, colour='red') +
  geom_vline(xintercept=as.numeric(topic_proportion_per_nwsp2$DATE[253]), linetype=1, colour='black') +
  geom_text(aes(x=topic_proportion_per_nwsp2$DATE[174], label="\nPASO", y=0.12), colour="red", angle=90)+
  geom_text(aes(x=topic_proportion_per_nwsp2$DATE[253], label="\nGenerales", y=0.12), colour="black", angle=90)+
  theme(axis.text.x = element_text(angle = 90))+
  facet_wrap(~Medio,nrow=2) +
  scale_color_brewer(palette="Set1") +
  theme_classic() +
  labs(title='Evolución de los tópicos según diario')

g6


## Composición de tópicos según medios, 2015-2017. Media de la composición de las noticias

autores <- data %>% 
  group_by(Medio) %>%
  summarise(n=n()) %>% 
  arrange(desc(n)) %>%
  top_n(7) %>%
  select(Medio)
aggregate(data, 
          by = list(medios = data$Medio), 
          mean) %>%
  filter(medios %in% autores$Medio) %>%
  gather(topic, value,`01_Cine, arte y espectáculos`:`08_Hechos violentos/Inseguridad`) %>%
  ggplot(aes(x=medios, y=value, fill=topic)) + 
  geom_bar(stat = "identity") + ylab("value") +
  geom_text(aes(label = round(value,2)), 
            position=position_stack(vjust = 0.5),
            check_overlap = TRUE) +
  coord_flip() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme_minimal()



