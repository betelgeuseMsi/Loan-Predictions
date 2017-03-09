```r
train = read.csv("train.txt", sep = ",", header = T, na.strings = c("", NA))
test = read.csv("test.txt", sep = ",", header = T, na.strings = c("", NA))
summary(train)
```
```python
import pandas as pd
```
