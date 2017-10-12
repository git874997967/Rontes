Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_91')
Sys.setenv(SPARK_HOME='C:\\Users\\yzm\\AppData\\Local\\rstudio\\spark\\Cache\\spark-2.0.2-bin-hadoop2.7')
library(sparklyr)
library(rJava)
library(dplyr)
library(SparkR)
sc <- sparkR.session(master=" spark://localhost:4040")

